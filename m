Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 14 Jul 2013 21:10:06 +0200 (CEST)
Received: from filtteri5.pp.htv.fi ([213.243.153.188]:39407 "EHLO
        filtteri5.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6816847Ab3GNTKEe5IqM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 14 Jul 2013 21:10:04 +0200
Received: from localhost (localhost [127.0.0.1])
        by filtteri5.pp.htv.fi (Postfix) with ESMTP id 58C135A7218;
        Sun, 14 Jul 2013 22:10:01 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp5.welho.com ([213.243.153.39])
        by localhost (filtteri5.pp.htv.fi [213.243.153.188]) (amavisd-new, port 10024)
        with ESMTP id 9iUIh+dyHYAv; Sun, 14 Jul 2013 22:09:56 +0300 (EEST)
Received: from musicnaut.iki.fi (cs181064211.pp.htv.fi [82.181.64.211])
        by smtp5.welho.com (Postfix) with SMTP id 6534C5BC003;
        Sun, 14 Jul 2013 22:09:55 +0300 (EEST)
Received: by musicnaut.iki.fi (sSMTP sendmail emulation); Sun, 14 Jul 2013 22:09:57 +0300
Date:   Sun, 14 Jul 2013 22:09:57 +0300
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Faidon Liambotis <paravoid@debian.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: octeon: fix DT pruning bug with pip ports
Message-ID: <20130714190957.GA3296@blackmetal.musicnaut.iki.fi>
References: <1373580489-23142-1-git-send-email-paravoid@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1373580489-23142-1-git-send-email-paravoid@debian.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37289
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Fri, Jul 12, 2013 at 01:08:09AM +0300, Faidon Liambotis wrote:
> During the pruning of the device tree octeon_fdt_pip_iface() is called
> for each PIP interface and every port up to the port count is removed
> from the device tree. However, the count was set to the return value of
> cvmx_helper_interface_enumerate() which doesn't actually return the
> count but just returns zero on success. This effectively removed *all*
> ports from the tree.
> 
> Use cvmx_helper_ports_on_interface() instead to fix this. This
> successfully restores the 3 ports of my ERLite-3 and fixes the "kernel
> assigns random MAC addresses" issue.
> 
> Signed-off-by: Faidon Liambotis <paravoid@debian.org>

Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>

Thanks,

A.

> ---
>  arch/mips/cavium-octeon/octeon-platform.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/mips/cavium-octeon/octeon-platform.c b/arch/mips/cavium-octeon/octeon-platform.c
> index 389512e..250eb20 100644
> --- a/arch/mips/cavium-octeon/octeon-platform.c
> +++ b/arch/mips/cavium-octeon/octeon-platform.c
> @@ -334,9 +334,10 @@ static void __init octeon_fdt_pip_iface(int pip, int idx, u64 *pmac)
>  	char name_buffer[20];
>  	int iface;
>  	int p;
> -	int count;
> +	int count = 0;
>  
> -	count = cvmx_helper_interface_enumerate(idx);
> +	if (cvmx_helper_interface_enumerate(idx) == 0)
> +		count = cvmx_helper_ports_on_interface(idx);
>  
>  	snprintf(name_buffer, sizeof(name_buffer), "interface@%d", idx);
>  	iface = fdt_subnode_offset(initial_boot_params, pip, name_buffer);
> -- 
> 1.8.3.2
> 
> 
