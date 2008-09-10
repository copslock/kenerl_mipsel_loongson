Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Sep 2008 12:09:00 +0100 (BST)
Received: from aux-209-217-49-36.oklahoma.net ([209.217.49.36]:54543 "EHLO
	proteus.paralogos.com") by ftp.linux-mips.org with ESMTP
	id S62083348AbYIJLI4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 10 Sep 2008 12:08:56 +0100
Received: from [127.0.0.1] ([217.109.65.213])
	by proteus.paralogos.com (8.9.3/8.9.3) with ESMTP id GAA27285;
	Wed, 10 Sep 2008 06:37:47 -0500
Message-ID: <48C7AB71.8090106@paralogos.com>
Date:	Wed, 10 Sep 2008 13:11:45 +0200
From:	"Kevin D. Kissell" <kevink@paralogos.com>
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
MIME-Version: 1.0
To:	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
CC:	ralf@linux-mips.org, ths@networkno.de, linux-mips@linux-mips.org,
	michael@free-electrons.com
Subject: Re: [PATCH 1/1] mips: clear IV bit in CP0 cause if the CPU doesn't
 support divec
References: <> <1220948125-3550-1-git-send-email-thomas.petazzoni@free-electrons.com>
In-Reply-To: <1220948125-3550-1-git-send-email-thomas.petazzoni@free-electrons.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kevink@paralogos.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20434
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@paralogos.com
Precedence: bulk
X-list: linux-mips

I think it's important to know whether it's U-Boot or Linux that's confused.
As Thomas Bogendoerfer pointed out, it's not good practice to flip bits 
whose
use is unknown to the kernel.  If in fact the CPU in question does 
support IV,
was correctly identified as such by U-Boot, but isn't recognized by the MIPS
Linux kernel, then we ought to fix Linux to recognize the CPU.  If it 
doesn't
support IV, but U-Boot thought it did, then U-Boot is broken and ought to
be fixed.  If you you're stuck with a broken U-Boot for some reason, then
there ought to be some platform-specific place to put a hack.

          Regards,

          Kevin K.

Thomas Petazzoni wrote:
> When the kernel thinks that the CPU doesn't support the divec feature
> (cpu_has_divec is false), reset the corresponding IV bit in the CP0
> cause register, so that things will work correctly if the bootloader
> had a different idea of the CPU support of the divec feature.
>
> The problem has been found while trying to boot a 2.6.24 kernel for
> the Qemu board using U-Boot inside Qemu. For the same CPU type, U-Boot
> thinks that divec is supported, and the kernel doesn't. So U-Boot sets
> the IV bit, but when the kernel boots and doesn't reset the IV bit,
> things break when the first interrupts occur. The Qemu board has been
> removed from the kernel in 2.6.25, but the problem might also occur
> with other platforms.
>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: Thiemo Seufer <ths@networkno.de>
> Cc: linux-mips@linux-mips.org
> ---
>  arch/mips/kernel/traps.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
>
> diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
> index 6bee290..8b1e507 100644
> --- a/arch/mips/kernel/traps.c
> +++ b/arch/mips/kernel/traps.c
> @@ -1467,6 +1467,9 @@ void __cpuinit per_cpu_trap_init(void)
>  		} else
>  			set_c0_cause(CAUSEF_IV);
>  	}
> +	else {
> +		clear_c0_cause(CAUSEF_IV);
> +	}
>  
>  	/*
>  	 * Before R2 both interrupt numbers were fixed to 7, so on R2 only:
>   
