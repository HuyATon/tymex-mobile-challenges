class Product:
    def __init__(self, name, price, quantity):
        self.name = name
        self.price = price
        self.quantity = quantity

    def calculate_price(self):
        return self.price * self.quantity
    

def get_highest_price_product(products):
    highest_price_product = None
    highest_price = 0

    for prod in products:
        if highest_price < prod.price:
            highest_price = prod.price
            highest_price_product = prod
    
    if highest_price_product is None:
        return None
    return highest_price_product.name

def construct_database(filename):
    products = []
    with open(file_name, "r") as file:
        
        for line in file:
            if line == "Product List:\n" or line == "\n":
                continue
            s = line.strip().split(":")
            name = s[0]
            temp = s[-1]
            price = float(temp.split(",")[0].split(" ")[-1])
            quantity = int(temp.split(",")[-1].split(" ")[-1])
            new_product = Product(name, price, quantity)
            products.append(new_product)

    return products

def calculate_total(products):
    total = 0
    for prod in products:
        total += prod.calculate_price()
    
    return total

def isInStock(products, product_name):

    for prod in products:
        if prod.name == product_name:
            return prod.quantity > 0
    return False

if __name__ == "__main__":
    file_name = input("Input file name: ")
    file_name = "input.txt"
    products = construct_database(file_name)
    print("Total: ", calculate_total(products))
    print("Highest price product: ", get_highest_price_product(products))
    print("Headphone in stock: ",  "yes" if isInStock(products, "Headphone") else "no")

    