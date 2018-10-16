% Script to compare current model output to original (expected) output

DataLog.unpack('all');   %  Unpack output datalog from current model

load benchmark_HeatTransfer;  %  Load original (expected) output

subplot(2,1,1);plot(benchmark_HeatTransfer)   %  Plot original output
subplot(2,1,2);plot(HeatTransfer)             %  Plot current output