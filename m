Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Mar 2015 20:34:58 +0100 (CET)
Received: from mail-ig0-f178.google.com ([209.85.213.178]:35329 "EHLO
        mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008511AbbCPTe4M7VDJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 16 Mar 2015 20:34:56 +0100
Received: by igcau2 with SMTP id au2so14407109igc.0
        for <linux-mips@linux-mips.org>; Mon, 16 Mar 2015 12:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=i9jhsdSlwKGJEK+26C9Rh6WivQKneYHPiA8QgVlf9Nc=;
        b=g93EqYyCTQhltw59YoOyi6Jqh3fl7saP0plZM4V0HCBHHtyXf1iuHttxyi5fzzCR94
         HDj0NZ2SXmZWBD2B+vL/9JlK/BUuwjmN3BnTsT0BHgaKapHxOkQQ0Zh5UdhJX1T//YPO
         vwoeBDrrj+UVR7VEoEavUtkISqTnyqsfDbioL2hstbum29U/N51Mv0xr0gTTp1BZp1wU
         l5yScXEa6sby0QTqg2Q+u6yMkyqZidHmf7NfpiRtnKQTHXN0BBA/FZZ80OQtXjFk/UN7
         ptESpuPd6PfvNAyM5bm0lgL1RYfL8qE6J0yBu3Kl60bhBSFPBit/shqJwpwrvP6nueL1
         2TTQ==
X-Received: by 10.51.17.40 with SMTP id gb8mr111955923igd.44.1426534491244;
        Mon, 16 Mar 2015 12:34:51 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.194.ptr.us.xo.net. [64.2.3.194])
        by mx.google.com with ESMTPSA id o196sm2668655ioe.26.2015.03.16.12.34.50
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 16 Mar 2015 12:34:50 -0700 (PDT)
Message-ID: <55073059.80505@gmail.com>
Date:   Mon, 16 Mar 2015 12:34:49 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Paul Martin <paul.martin@codethink.co.uk>
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH 1/7] MIPS: OCTEON: Ensure CPUs come up little endian
References: <1426529923-13340-1-git-send-email-paul.martin@codethink.co.uk> <1426529923-13340-2-git-send-email-paul.martin@codethink.co.uk>
In-Reply-To: <1426529923-13340-2-git-send-email-paul.martin@codethink.co.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46415
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

On 03/16/2015 11:18 AM, Paul Martin wrote:
> Even though the bootloader may have switched the main CPU core to
> LE mode the other CPU cores may start with endianness dictated by
> how their pins are strapped on the board.
>

This patch does at least three things, two of them are not related to 
running little-endian, but are instead HOTPLUG_CPU related.

As for the little-endian portion...


> Signed-off-by: Paul Martin <paul.martin@codethink.co.uk>
> ---
>   .../asm/mach-cavium-octeon/kernel-entry-init.h     | 68 ++++++++++++++++++++++
>   1 file changed, 68 insertions(+)
>
> diff --git a/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h b/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h
> index cf92fe7..7178243 100644
> --- a/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h
> +++ b/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h
> @@ -26,6 +26,74 @@
>   	# a3 = address of boot descriptor block
>   	.set push
>   	.set arch=octeon
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
> +#endif /* CONFIG_HOTPLUG_CPU */
> +#ifdef CONFIG_CPU_LITTLE_ENDIAN
> +	.set push
> +	.set noreorder
> +	/* Hotplugged CPUs enter in Big-Endian mode, switch here to LE */
> +	dmfc0   v0, CP0_CVMCTL_REG
> +	nop
> +	ori     v0, v0, 2
> +	nop
> +	dmtc0   v0, CP0_CVMCTL_REG	/* little-endian */
> +	nop
> +	synci	0($0)
> +	.set pop
> +#endif /* CONFIG_CPU_LITTLE_ENDIAN */

... This code in the #ifdef CONFIG_CPU_LITTLE_ENDIAN block is useless 
and should be removed.

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
>   	# Read the cavium mem control register
>   	dmfc0	v0, CP0_CVMMEMCTL_REG
>   	# Clear the lower 6 bits, the CVMSEG size
>
