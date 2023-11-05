#! /usr/bin/env Rscript
# set python venv
# use_python("~/git/keras_r/venv/bin/python3")
library("keras")
library("tensorflow")

# set options
options(width=1000)
options(digits=3)
options(scippen=999)
par(mai=c(.001,.001,.001,.001),mar=c(.001,.001,.001,.001),oma=c(.001,.001,.001,.001))

# load dataset
mnist <- dataset_mnist()
tri<-train_images<-mnist$train$x
train_labels<-mnist$train$y
tei<-test_images<-mnist$test$x
test_labels<-mnist$test$y

# data wrangling
train_images<-array_reshape(train_images,c(60000,28*28))
train_images<-train_images/255
test_images<-array_reshape(test_images,c(10000,28*28))
test_images<-test_images/255
train_labels<-to_categorical(train_labels)
test_labels<-to_categorical(test_labels)

# set nn
network<-keras_model_sequential() %>%
  layer_dense(units=784,activation="relu",input_shape=c(28*28)) %>%
  layer_dense(units=2000,activation="relu") %>%
  layer_dense(units=2000,activation="relu") %>%
  layer_dense(units=10,activation="softmax")
network %>% compile(optimizer="adam",
                    loss="categorical_crossentropy",
                    metrics=c("accuracy"))
network %>% fit(train_images,train_labels,epochs=20,batch_size=784,verbose=1)

# train nn
# network %>% fit(train_images,train_labels,epochs=10,batch_size=784,verbose=0)
network %>% evaluate(test_images,test_labels)