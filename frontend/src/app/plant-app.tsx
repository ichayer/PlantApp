import { useEffect, useState } from 'react'
import { Card, CardContent } from "src/components/ui/card"
import { Button } from "src/components/ui/button"
import { ScrollArea } from "src/components/ui/scroll-area"
import { Droplet, Calendar, PlusCircle, Leaf, Info, Camera, Image as ImageIcon } from 'lucide-react'
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogTrigger,
} from "src/components/ui/dialog"
import { cn, plantsPath } from "src/lib/utils"
import { Input } from "src/components/ui/input"
import { Label } from "src/components/ui/label"
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "src/components/ui/select"
import React from 'react';

type Plant = {
  id: number | null;
  name: string;
  image: string;
  wateringFrequency: number;
  lastWatered: Date;
  wateringHistory: Date[];
}

type PlantPost = {
  name: string;
  image: string;
  waterFrequencyDays: number;
  description: string;
}

export default function MyPlants() {
  const [plants, setPlants] = useState<Plant[]>([])
  const [selectedPlant, setSelectedPlant] = useState<Plant | null>(null)
  const [isAddPlantOpen, setIsAddPlantOpen] = useState(false)
  const [newPlant, setNewPlant] = useState<Partial<Plant>>({
    name: '',
    wateringFrequency: 7,
    image: '/placeholder.svg?height=100&width=100'
  })

  useEffect(() => {
    const fetchPlants = async () => {
      try {
        const response = await fetch(plantsPath)
        const data = await response.json()
        const transformedData: Plant[] = data.map((item: any) => ({
          id: item.plantId,
          name: item.name,
          image: item.image || '/placeholder.svg', // Set placeholder in case no image is provided
          wateringFrequency: item.wateringFrequency || 7,
          lastWatered: new Date(item.lastWatered),
          wateringHistory: item.waterings.map((date: string) => new Date(date)),
        }))
        setPlants(transformedData)
      } catch (error) {
        console.error('Error retrieving plants:', error)
      }
    }
    fetchPlants()
  }, [])

  const calculateNextWatering = (plant: Plant) => {
    const nextWatering = new Date(plant.lastWatered)
    nextWatering.setDate(nextWatering.getDate() + plant.wateringFrequency)
    return nextWatering
  }

  const formatDate = (date: Date) => {
    return date.toLocaleDateString('es-ES', { year: 'numeric', month: 'long', day: 'numeric' })
  }

  const getWateringStatus = (plant: Plant) => {
    const today = new Date()
    const nextWatering = calculateNextWatering(plant)
    const diffDays = Math.ceil((nextWatering.getTime() - today.getTime()) / (1000 * 3600 * 24))

    if (diffDays < 0) return { status: 'Necesita agua', color: 'text-red-500' }
    if (diffDays === 0) return { status: 'Regar hoy', color: 'text-yellow-500' }
    if (diffDays <= 2) return { status: 'Próximamente', color: 'text-orange-500' }
    return { status: 'Bien', color: 'text-green-500' }
  }

  const handleWaterPlant = async (plantId: number) => {
    try {
      const response = await fetch(`${plantsPath}/${plantId}/waterings`, {
        mode: 'no-cors',
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ description: "Hola" }), // Otras propiedades si son necesarias
      });
  
      if (response.ok) {
        // Actualizar el estado de la planta con el nuevo historial de riego
        setPlants(plants.map(p => {
          if (p.id === plantId) {
            return { ...p, lastWatered: new Date(), wateringHistory: [new Date(), ...p.wateringHistory] };
          }
          return p;
        }));
      } else {
        // TODO: Mostrar mensaje de error? Re vivido
        console.error('Error al registrar el riego:', response.statusText);
      }
    } catch (error) {
      console.error('Error en la solicitud:', error);
    }
  };

  const handleAddPlant = async (event: React.FormEvent<HTMLFormElement>) => {
    event.preventDefault()
    const plantToAdd: PlantPost = {
      name: newPlant.name || '',
      image: newPlant.image || '/placeholder.svg?height=100&width=100',
      description: "default",
      waterFrequencyDays: newPlant.wateringFrequency || 7
    }

    try {
      const response = await fetch(plantsPath, {
        mode: 'no-cors',
        method: 'POST',
        body: JSON.stringify(plantToAdd),
        headers: {
          'Content-Type': 'application/json',
        }
      });

      if (response.ok) {
        const data = await response.json()
        const addedPlant: Plant = {
          id: data.plantId,
          name: newPlant.name || '',
          image: newPlant.image || '/placeholder.svg?height=100&width=100',
          wateringFrequency: newPlant.wateringFrequency || 7,
          wateringHistory: [],
          lastWatered: new Date()
        }

        setPlants([...plants, addedPlant])
        setIsAddPlantOpen(false)
        setNewPlant({ name: '', wateringFrequency: 7, image: '/placeholder.svg?height=100&width=100'})
      } else {
        console.error('Error al agregar la planta:', response.statusText);
      }
    } catch (error) {
      console.error('Error en la solicitud:', error);
    }
  }

  return (
    <div className="container mx-auto p-4 bg-gradient-to-b from-green-50 to-green-100 min-h-screen">
      <header className="flex justify-between items-center mb-8">
        <h1 className="text-3xl font-bold text-green-800 flex items-center">
          <Leaf className="mr-2 h-8 w-8" />
          Mis Plantas
        </h1>
        <Dialog open={isAddPlantOpen} onOpenChange={setIsAddPlantOpen}>
          <DialogTrigger asChild>
            <Button 
              className="bg-green-600 hover:bg-green-700 text-white"
            >
              <PlusCircle className="mr-2 h-4 w-4" />
              Agregar Planta
            </Button>
          </DialogTrigger>
          <DialogContent className="sm:max-w-[425px]">
            <DialogHeader>
              <DialogTitle className="text-2xl font-bold text-green-800">Agregar Nueva Planta</DialogTitle>
            </DialogHeader>
            <form onSubmit={handleAddPlant} className="space-y-4">
              <div className="space-y-2">
                <Label htmlFor="plant-name" className="text-green-700">Nombre de la planta</Label>
                <Input 
                  id="plant-name" 
                  value={newPlant.name} 
                  onChange={(e) => setNewPlant({...newPlant, name: e.target.value})}
                  placeholder="Ingrese el nombre de la planta" 
                  required 
                  className="border-green-300 focus:border-green-500 focus:ring-green-500" 
                />
              </div>
              <div className="space-y-2">
                <Label htmlFor="watering-frequency" className="text-green-700">Periodicidad de riego</Label>
                <Select 
                  value={newPlant.wateringFrequency?.toString()} 
                  onValueChange={(value) => setNewPlant({...newPlant, wateringFrequency: parseInt(value)})}
                >
                  <SelectTrigger id="watering-frequency" className="border-green-300 focus:border-green-500 focus:ring-green-500">
                    <SelectValue placeholder="Seleccione la frecuencia de riego" />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="3">Cada 3 días</SelectItem>
                    <SelectItem value="7">Cada 7 días</SelectItem>
                    <SelectItem value="14">Cada 14 días</SelectItem>
                    <SelectItem value="30">Cada 30 días</SelectItem>
                  </SelectContent>
                </Select>
              </div>
              <div className="space-y-2">
                <Label className="text-green-700">Foto de la planta</Label>
                <div className="flex items-center space-x-2">
                  <div className="w-24 h-24 border-2 border-dashed border-green-300 rounded-lg flex items-center justify-center overflow-hidden bg-green-50">
                    {newPlant.image && (
                      <img src={newPlant.image} alt="Nueva planta" className="w-full h-full object-cover" />
                    )}
                  </div>
                  <div className="space-y-2">
                    <Button type="button" variant="outline" size="sm" className="w-full bg-green-100 text-green-700 border-green-300 hover:bg-green-200">
                      <Camera className="mr-2 h-4 w-4" />
                      Tomar foto
                    </Button>
                    <Label htmlFor="image-upload" className="w-full">
                      <Button type="button" variant="outline" size="sm" className="w-full bg-green-100 text-green-700 border-green-300 hover:bg-green-200" asChild>
                        <span>
                          <ImageIcon className="mr-2 h-4 w-4" />
                          Subir imagen
                        </span>
                      </Button>
                    </Label>
                    <Input
                      id="image-upload"
                      type="file"
                      accept="image/*"
                      className="hidden"
                      onChange={(e) => {
                        const file = e.target.files?.[0]
                        if (file) {
                          const reader = new FileReader()
                          reader.onloadend = () => {
                            setNewPlant({...newPlant, image: reader.result as string})
                          }
                          reader.readAsDataURL(file)
                        }
                      }}
                    />
                  </div>
                </div>
              </div>
              <Button type="submit" className="w-full bg-green-600 hover:bg-green-700 text-white">Guardar planta</Button>
            </form>
          </DialogContent>
        </Dialog>
      </header>
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        {plants.map((plant) => {
          const { status, color } = getWateringStatus(plant)
          return (
            <Card key={plant.id} className="overflow-hidden hover:shadow-lg transition-shadow duration-300">
              <CardContent className="p-0">
                <img src={plant.image} alt={plant.name} className="w-full h-48 object-cover" />
                <div className="p-4">
                  <h2 className="text-xl font-semibold text-green-800 mb-2">{plant.name}</h2>
                  <div className="flex justify-between items-center text-sm text-green-600 mb-4">
                    <span className="flex items-center">
                      <Droplet className="mr-1 h-4 w-4" />
                      Cada {plant.wateringFrequency} días
                    </span>
                    <span className="flex items-center">
                      <Calendar className="mr-1 h-4 w-4" />
                      {formatDate(calculateNextWatering(plant))}
                    </span>
                  </div>
                  <div className="flex justify-between items-center">
                    <div className={cn("font-medium", color)}>
                      Estado: {status}
                    </div>
                    <div className="space-x-2">
                      <Dialog>
                        <DialogTrigger asChild>
                          <Button 
                            variant="outline" 
                            size="sm"
                            className="text-green-700 border-green-300 hover:bg-green-50"
                            onClick={() => setSelectedPlant(plant)}
                          >
                            <Info className="h-4 w-4" />
                          </Button>
                        </DialogTrigger>
                        <DialogContent className="sm:max-w-[425px]">
                          <DialogHeader>
                            <DialogTitle className="text-2xl font-bold text-green-800">{selectedPlant?.name}</DialogTitle>
                          </DialogHeader>
                          <div className="mt-4">
                            <img src={selectedPlant?.image} alt={selectedPlant?.name} className="w-full h-48 object-cover rounded-lg mb-4" />
                            <div className="space-y-2 text-green-700">
                              <p className="flex items-center">
                                <Droplet className="mr-2 h-4 w-4" />
                                Riego cada {selectedPlant?.wateringFrequency} días
                              </p>
                              <p>Último riego: {selectedPlant && formatDate(selectedPlant.lastWatered)}</p>
                              <p>Próximo riego: {selectedPlant && formatDate(calculateNextWatering(selectedPlant))}</p>
                            </div>
                            <div className="mt-4">
                              <h3 className="font-semibold text-green-800 mb-2">Historial de riego</h3>
                              <ScrollArea className="h-40 w-full rounded-md border border-green-200 p-4">
                                <ul className="space-y-2">
                                  {selectedPlant?.wateringHistory.map((date, index) => (
                                    <li key={index} className="text-green-600">
                                      {formatDate(date)}
                                    </li>
                                  ))}
                                </ul>
                              </ScrollArea>
                            </div>
                          </div>
                        </DialogContent>
                      </Dialog>
                      <Button 
                        variant="outline" 
                        size="sm"
                        className="text-blue-700 border-blue-300 hover:bg-blue-50"
                        onClick={() => handleWaterPlant(plant.id!)}
                      >
                        <Droplet className="h-4 w-4" />
                      </Button>
                    </div>
                  </div>
                </div>
              </CardContent>
            </Card>
          )
        })}
      </div>
    </div>
  )
}