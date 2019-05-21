using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Azure.WebJobs;
using Microsoft.Azure.WebJobs.Extensions.Http;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Logging;
using System;
using Anug.Pipeline.NugetPackage;

namespace AnugFunc
{
    public static class HalloWorld
    {
        [FunctionName("HalloWorld")]
        public static async Task<IActionResult> Run(
            [HttpTrigger(AuthorizationLevel.Anonymous, "get", "post", Route = null)] HttpRequest req,
            ILogger log)
        {
            var demo = new Demo();
            return new OkObjectResult(new
            {
                message = demo.Hallo(),
                deploymentId = Environment.GetEnvironmentVariable("deploymentId") ?? "I don't know who I am?",
                environmentNmae = Environment.GetEnvironmentVariable("environmentName") ?? "I don't know where I am!"
            });
        }
    }
}