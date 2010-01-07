Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Jan 2010 21:36:33 +0100 (CET)
Received: from gateway-1237.mvista.com ([206.112.117.35]:1957 "HELO
        imap.sh.mvista.com" rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org
        with SMTP id S1492768Ab0AGUg2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 7 Jan 2010 21:36:28 +0100
Received: from [127.0.0.1] (unknown [10.150.0.9])
        by imap.sh.mvista.com (Postfix) with SMTP
        id 19E7D3ECA; Thu,  7 Jan 2010 12:36:12 -0800 (PST)
Message-ID: <4B4645A3.30401@ru.mvista.com>
Date:   Thu, 07 Jan 2010 23:35:47 +0300
From:   Sergei Shtylyov <sshtylyov@ru.mvista.com>
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
MIME-Version: 1.0
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        linux-i2c@vger.kernel.org, ben-linux@fluff.org, khali@linux-fr.org,
        rade.bozic.ext@nsn.com
Subject: Re: [PATCH 1/3] MIPS: Octeon: Add I2C platform driver.
References: <4B463B1F.6000404@caviumnetworks.com> <1262894061-32613-1-git-send-email-ddaney@caviumnetworks.com>
In-Reply-To: <1262894061-32613-1-git-send-email-ddaney@caviumnetworks.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 25541
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 5218

Hello.

David Daney wrote:

> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
> CC: Rade Bozic <rade.bozic.ext@nsn.com>
>   
[...]
> diff --git a/arch/mips/cavium-octeon/octeon-platform.c b/arch/mips/cavium-octeon/octeon-platform.c
> index 20698a6..f2c0602 100644
> --- a/arch/mips/cavium-octeon/octeon-platform.c
> +++ b/arch/mips/cavium-octeon/octeon-platform.c
> @@ -165,6 +165,78 @@ out:
>  }
>  device_initcall(octeon_rng_device_init);
>  
> +
> +#define OCTEON_I2C_IO_BASE 0x1180000001000ull
> +#define OCTEON_I2C_IO_UNIT_OFFSET 0x200
> +
> +static struct octeon_i2c_data octeon_i2c_data[2];
> +
> +static int __init octeon_i2c_device_init(void)
> +{
> +	struct platform_device *pd;
> +	int ret = 0;
> +	int port, num_ports;
> +
> +	struct resource i2c_resources[] = {
> +		{
> +			.flags	= IORESOURCE_MEM,
> +		}, {
> +			.flags	= IORESOURCE_IRQ,
> +		}
> +	};
> +
> +	if (OCTEON_IS_MODEL(OCTEON_CN56XX) || OCTEON_IS_MODEL(OCTEON_CN52XX))
> +		num_ports = 2;
> +	else
> +		num_ports = 1;
> +
> +	for (port = 0; port < num_ports; port++) {
> +		octeon_i2c_data[port].sys_freq = octeon_get_clock_rate();
> +		/*FIXME: should be examined. At the moment is set for 100Khz */
> +		octeon_i2c_data[port].i2c_freq = 100000;
> +
> +		pd = platform_device_alloc("i2c-octeon", port);
> +		if (!pd) {
> +			ret = -ENOMEM;
> +			goto out;
> +		}
> +
> +		pd->dev.platform_data = octeon_i2c_data + port;
> +
> +		i2c_resources[0].start =
> +			OCTEON_I2C_IO_BASE + (port * OCTEON_I2C_IO_UNIT_OFFSET);
> +		i2c_resources[0].end = i2c_resources[0].start + 0x20;
>   

   Not 0x1F?

WBR, Sergei
