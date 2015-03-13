Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Mar 2015 19:44:53 +0100 (CET)
Received: from filtteri5.pp.htv.fi ([213.243.153.188]:57591 "EHLO
        filtteri5.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008691AbbCMSovd5jOZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 13 Mar 2015 19:44:51 +0100
Received: from localhost (localhost [127.0.0.1])
        by filtteri5.pp.htv.fi (Postfix) with ESMTP id 767795A7039;
        Fri, 13 Mar 2015 20:44:41 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp4.welho.com ([213.243.153.38])
        by localhost (filtteri5.pp.htv.fi [213.243.153.188]) (amavisd-new, port 10024)
        with ESMTP id y82rnkeFggyo; Fri, 13 Mar 2015 20:44:36 +0200 (EET)
Received: from fuloong-minipc (91-145-91-118.bb.dnainternet.fi [91.145.91.118])
        by smtp4.welho.com (Postfix) with ESMTP id E56B25BC012;
        Fri, 13 Mar 2015 20:44:46 +0200 (EET)
Date:   Fri, 13 Mar 2015 20:44:46 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Paul Martin <paul.martin@codethink.co.uk>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH 2/6] MIPS: OCTEON: Ensure CPUs come up little endian
Message-ID: <20150313184446.GI587@fuloong-minipc.musicnaut.iki.fi>
References: <1426268098-1603-1-git-send-email-paul.martin@codethink.co.uk>
 <1426268098-1603-3-git-send-email-paul.martin@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1426268098-1603-3-git-send-email-paul.martin@codethink.co.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46377
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

Hi,

On Fri, Mar 13, 2015 at 05:34:54PM +0000, Paul Martin wrote:
> Even though the bootloader may have switched the main CPU core to
> LE mode the other CPU cores may start with endianness dictated by
> how their pins are strapped on the board.
> ---
>  .../asm/mach-cavium-octeon/kernel-entry-init.h     | 137 ++++++++++++++++++++-
>  1 file changed, 136 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h b/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h
> index cf92fe7..b377044 100644
> --- a/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h
> +++ b/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h
> @@ -3,7 +3,7 @@
>   * License.  See the file "COPYING" in the main directory of this archive
>   * for more details.
>   *
> - * Copyright (C) 2005-2008 Cavium Networks, Inc
> + * Copyright (C) 2005-2012 Cavium, Inc

I don't think you should touch these...

>   */
>  #ifndef __ASM_MACH_CAVIUM_OCTEON_KERNEL_ENTRY_H
>  #define __ASM_MACH_CAVIUM_OCTEON_KERNEL_ENTRY_H
> @@ -26,6 +26,141 @@
>  	# a3 = address of boot descriptor block
>  	.set push
>  	.set arch=octeon
> +#ifdef CONFIG_HOTPLUG_CPU
> +	b	7f
> +	nop
> +
> +FEXPORT(octeon_hotplug_entry)
> +	move	a0, zero
> +	move	a1, zero
> +	move	a2, zero
> +	move	a3, zero
> +7:
> +#endif	/* CONFIG_HOTPLUG_CPU */
> +#ifdef	CONFIG_CPU_LITTLE_ENDIAN

No tabs.

> +	.set push
> +	.set noreorder
> +	/* Hotpplugged CPUs enter in Big-Endian mode, switch here to LE */
              ^^
Typo.

> +	dmfc0   v0, CP0_CVMCTL_REG
> +	nop
> +	ori     v0, v0, 2
> +	nop
> +	dmtc0   v0, CP0_CVMCTL_REG	/* little-endian */
> +	nop
> +	synci	0($0)
> +	.set pop
> +#endif	/* CONFIG_CPU_LITTLE_ENDIAN */
> +	mfc0	v0, CP0_STATUS
> +	/* Force 64-bit addressing enabled */
> +	ori	v0, v0, (ST0_UX | ST0_SX | ST0_KX)
> +	mtc0	v0, CP0_STATUS
> +
> +	# Clear the TLB.
> +	mfc0	v0, $16, 1	# Config1
> +	dsrl	v0, v0, 25
> +	andi	v0, v0, 0x3f
> +	mfc0	v1, $16, 3	# Config3
> +	bgez	v1, 1f
> +	mfc0	v1, $16, 4	# Config4
> +	andi	v1, 0x7f
> +	dsll	v1, 6
> +	or	v0, v0, v1
> +1:				# Number of TLBs in v0
> +
> +	dmtc0	zero, $2, 0	# EntryLo0
> +	dmtc0	zero, $3, 0	# EntryLo1
> +	dmtc0	zero, $5, 0	# PageMask
> +	dla	t0, 0xffffffff90000000
> +10:
> +	dmtc0	t0, $10, 0	# EntryHi
> +	tlbp
> +	mfc0	t1, $0, 0	# Index
> +	bltz	t1, 1f
> +	tlbr
> +	dmtc0	zero, $2, 0	# EntryLo0
> +	dmtc0	zero, $3, 0	# EntryLo1
> +	dmtc0	zero, $5, 0	# PageMask
> +	tlbwi			# Make it a 'normal' sized page
> +	daddiu	t0, t0, 8192
> +	b	10b
> +1:
> +	mtc0	v0, $0, 0	# Index
> +	tlbwi
> +	.set	noreorder
> +	bne	v0, zero, 10b
> +	 addiu	v0, v0, -1
> +	.set	reorder
> +
> +	mtc0	zero, $0, 0	# Index
> +	dmtc0	zero, $10, 0	# EntryHi
> +
> +#ifdef CONFIG_MAPPED_KERNEL

Mainline kernel does not support MAPPED_KERNEL on OCTEON, so you should
delete all this code.

A.
