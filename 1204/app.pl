our $bill = "---BILL---\n\n";
our $total_amount = 0;

print "Billing System\n\n";

# Show Menu
sub ShowMenu{
    print "\n\n---Main Menu---\n\n";
    print "Type 1 to start billing\n";
    print "Type 2 to add a new product to the inventory\n";
    print "Type 3 to show inventory\n";
    print "Type 4 to exit from program\n\n";
}

# add new product
sub AddToInventory{

    print "\n\n---Add a new Product---\n\n";
    print "Enter Product Name\n";
    my $product_name = <STDIN>;
    print "Enter Price of the $product_name";
    my $product_price = <STDIN>;

    chomp $product_name;
    chomp $product_price;
    
    $product_name = lc $product_name;

    open DATA, ">>inventory.csv";

    print DATA "$product_name, $product_price\n";

    close DATA;
}


#show Inventory
sub ShowInventory{
    print "\n\n";
    print "---Inventory---\n\n";
    open DATA, "<inventory.csv";
    while(<DATA>){
        print "$_";
    }
    close DATA;

    print "\n\n";
}

# Billing
sub Billing{
    my $interaction = 0;

    print "\n\n---Billing Started---";

    until($interaction == 8){
        print "\n\nType 1 to enter a product to bill\n";
        print "Type 2 to show inventory\n";
        print "Type 8 to finish billing\n";

        $interaction = <STDIN>;

        if($interaction == 1){
            print "\nEnter product name: ";
            my $product_name = <STDIN>;
            $product_name = lc $product_name;
            chomp $product_name;

            open DATA, "<inventory.csv";

            while(<DATA>){
                # print "$_";
                my @item = split ', ', "$_";
                if($item[0] eq $product_name){
                    $bill .= "$item[0] : $item[1]";
                    $total_amount += $item[1];
                }
            }

        }elsif ($interaction == 2) {
            ShowInventory;
        }elsif ($interaction == 8) {
            last;
        }else{
            print "Invalid Input";
        }
    }

    print "\n\n$bill\n--------------\nTotal: $total_amount\n\n";
    open DATA, '>bill.txt';

    print DATA "\n\n$bill\n--------------\nTotal: $total_amount\n\n";

    close DATA;
}


# Program Start

my $int;

until($int == 4){

    ShowMenu;

    $int = <STDIN>;

    if($int == 1){
        Billing;
    }elsif ($int == 2) {
        AddToInventory;
    }elsif ($int == 3) {
        ShowInventory;
    }elsif ($int == 4) {
        exit 0;
    }
    else{
        print "Invalid Input\n";
    }
}