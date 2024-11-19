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

def construct_database(file_name):
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

def sortProducts(products, is_ascending, option="price"):

    n = len(products)
    sort_attribute = "price" if option == "price" else "quantity"

    for i in range(n - 1):

        for j in range(i + 1, n):
            i_value = getattr(products[i], sort_attribute)
            j_value = getattr(products[j], sort_attribute)
            if is_ascending:
                if i_value > j_value:
                    products[i], products[j] = products[j], products[i]
            else:
                if i_value < j_value:
                    products[i], products[j] = products[j], products[i]

                

if __name__ == "__main__":
    file_name = "./input.txt"
    products = construct_database(file_name)
    option_1 = "price"
    option_2 = "quantity"
    print("Total: ", calculate_total(products))
    print("-" * 20)

    print("Highest price product: ", get_highest_price_product(products))
    print("-" * 20)
    print("Headphone in stock: ",  "yes" if isInStock(products, "Headphone") else "no")
    print("-" * 20)

    print("Sorted by price in ascending order: ")
    sortProducts(products, True, option_1)
    for prod in products:
        print(prod.name, prod.price, prod.quantity)
    print("-" * 20)

    print("Sorted by price in descending order: ")
    sortProducts(products, False, option_1)
    for prod in products:
        print(prod.name, prod.price, prod.quantity)
    print("-" * 20)

    print("Sorted by quantity in ascending order: ")
    sortProducts(products, True, option_2)
    for prod in products:
        print(prod.name, prod.price, prod.quantity)
    print("-" * 20)

    print("Sorted by quantity in descending order: ")
    sortProducts(products, False, option_2)
    for prod in products:
        print(prod.name, prod.price, prod.quantity)
    print("-" * 20)
    