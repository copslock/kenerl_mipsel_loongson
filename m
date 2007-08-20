Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Aug 2007 14:58:20 +0100 (BST)
Received: from bobafett.staff.proxad.net ([213.228.1.121]:32959 "EHLO
	bobafett.staff.proxad.net") by ftp.linux-mips.org with ESMTP
	id S20021678AbXHTN6M (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 20 Aug 2007 14:58:12 +0100
Received: from localhost (localhost [127.0.0.1])
	by bobafett.staff.proxad.net (Postfix) with ESMTP id 6C76F28653;
	Mon, 20 Aug 2007 15:57:40 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at staff.proxad.net
Received: from bobafett.staff.proxad.net ([127.0.0.1])
	by localhost (bobafett.staff.proxad.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id z10if-CYFrqr; Mon, 20 Aug 2007 15:57:38 +0200 (CEST)
Received: from nschichan.priv.staff.proxad.net (nschichan.priv.staff.proxad.net [172.18.3.120])
	by bobafett.staff.proxad.net (Postfix) with ESMTP id C58A21D506;
	Mon, 20 Aug 2007 15:57:38 +0200 (CEST)
From:	Nicolas Schichan <nschichan@freebox.fr>
Organization: Freebox
To:	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: kexec - not happening on mipsel?
Date:	Mon, 20 Aug 2007 15:57:38 +0200
User-Agent: KMail/1.9.6
Cc:	Andrew Sharp <andy.sharp@onstor.com>, linux-mips@linux-mips.org
References: <20070808170846.7d395891@ripper.onstor.net> <200708101857.15567.nschichan@freebox.fr> <20070814094738.GC16958@linux-mips.org>
In-Reply-To: <20070814094738.GC16958@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200708201557.38810.nschichan@freebox.fr>
Return-Path: <nschichan@freebox.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16224
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nschichan@freebox.fr
Precedence: bulk
X-list: linux-mips

On Tuesday 14 August 2007 11:47:38 Ralf Baechle wrote:

Hi,

> flush_icache_all() is a nop except on VIVT caches.  Anyway, following a
> __flush_cache_all it's pointless unless you want to flush caches a little
> harder.

The updated patch only uses __flush_cache_all().

> > -	printk("Will call new kernel at %08x\n", image->start);
> > -	printk("Bye ...\n");
> > -	flush_cache_all();
> > +	/*
> > +	 * avoid cache operation related headache in
> > +	 * relocate_kernel.S: disable caches in kseg0, the new kernel
> > +	 * will take care to re-enable cache in kseg0.
> > +	 */
> > +	change_c0_config(CONF_CM_CMASK, CONF_CM_UNCACHED);
>
> And that line is the kernel's one way ticket to hell on some platforms.
>
> There is a hazard barrier missing here.

Just for my culture, could you please specify which kind of barrier macro 
should I use here ? should it be a back_to_back_c0_hazard() ?

> Only KSEG0 (or CKSEG0 in 64-bit parlance) is affected by changing Config.K0
> field.  But 64-bit kernels do not necessarily run in one of the 32-bit
> compatibility segments (R8000 doesn't but that's an academic counter
> example) - if they exist at all there is no guarantee that there is any RAM
> mapped in them (IP30 and others).
>
> On IP27 the kernel will run in CKSEG0 and if you switch that to 0 it'll
> mean BRIDGE ASIC will start looking at the uncached attribute which will be
> defaulted to 0 meaning that in CKSEG0 the CPU will no longer address RAM
> but the ECC and Backdoor Directory information.
>
> Basically it boils down to be very, very careful about cache modes
> on MIPS.  What the kernel does on bootup only happens to work because for
> all the platforms that have potencial issues with the change of the CCA
> for KSEG0 we know that Linux will set the CCA to the same value that is
> already in that field.  So that mode switch is sort of useless for most
> platforms except a few where firmware doesn't initialize Config0.K0.

Ok, updated patch does not try to disable caching in KSEG0 using Config0.K0. 

Hoewever I so feel a bit unsafe now because D-Cache is not wrote-back and 
I-Cache is not invalidated in relocate_kernel.S, before jumping to the new 
kernel. This happens to work on my board, but I think that it is mostly 
because of luck. Maybe using KSEG1 or XKPHYS (not sure about this one, I am 
not familiar with 64bit mips) when fixing the indirection list addresses 
should be safer.

However, updated patch follows.

Regards.

Signed-off-by: Nicolas Schichan <nschichan@freebox.fr>

--- linux/arch/mips/kernel/machine_kexec.c	(revision 5975)
+++ linux/arch/mips/kernel/machine_kexec.c	(revision 5976)
@@ -78,11 +78,8 @@
 	 */
 	local_irq_disable();
 
-	flush_icache_range(reboot_code_buffer,
-			   reboot_code_buffer + KEXEC_CONTROL_CODE_SIZE);
-
 	printk("Will call new kernel at %08lx\n", image->start);
 	printk("Bye ...\n");
-	flush_cache_all();
+	__flush_cache_all();
 	((noretfun_t) reboot_code_buffer)();
 }

-- 
Nicolas Schichan
