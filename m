Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Aug 2007 17:57:56 +0100 (BST)
Received: from bobafett.staff.proxad.net ([213.228.1.121]:45490 "EHLO
	bobafett.staff.proxad.net") by ftp.linux-mips.org with ESMTP
	id S20026912AbXHJQ5s (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 10 Aug 2007 17:57:48 +0100
Received: from localhost (localhost [127.0.0.1])
	by bobafett.staff.proxad.net (Postfix) with ESMTP id 04D952865F;
	Fri, 10 Aug 2007 18:57:17 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at staff.proxad.net
Received: from bobafett.staff.proxad.net ([127.0.0.1])
	by localhost (bobafett.staff.proxad.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 0kmIT3vNSIoK; Fri, 10 Aug 2007 18:57:15 +0200 (CEST)
Received: from nschichan.priv.staff.proxad.net (nschichan.priv.staff.proxad.net [172.18.3.120])
	by bobafett.staff.proxad.net (Postfix) with ESMTP id B4C3CCF03;
	Fri, 10 Aug 2007 18:57:15 +0200 (CEST)
From:	Nicolas Schichan <nschichan@freebox.fr>
Organization: Freebox
To:	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: kexec - not happening on mipsel?
Date:	Fri, 10 Aug 2007 18:57:15 +0200
User-Agent: KMail/1.9.6
Cc:	Andrew Sharp <andy.sharp@onstor.com>, linux-mips@linux-mips.org
References: <20070808170846.7d395891@ripper.onstor.net> <20070808184120.40b6b5d5@ripper.onstor.net> <20070809123530.GA14183@linux-mips.org>
In-Reply-To: <20070809123530.GA14183@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200708101857.15567.nschichan@freebox.fr>
Return-Path: <nschichan@freebox.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16157
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nschichan@freebox.fr
Precedence: bulk
X-list: linux-mips

On Thursday 09 August 2007 14:35:30 Ralf Baechle wrote:

Hi,

> I recently noticed the kernel part was fairly broken, did (if ever) only
> work for 32-bit machines.  I fixed what I could but I don't have the
> necessary test setup.  See
> 
> http://www.linux-mips.org/git?p=linux.git;a=commit;h=bb73f9d8ee3133800da546
>832ca7f09d3f27695e

My appologies for this, I should have taken more care about 64 bit portability 
when writing this code.

I have also been trying to address the cache problem in the kexec code. please 
see the attached patch.

I now use __flush_cache_all(), since flush_cache_all() is mostly a noop on r4k 
if cpu_has_dc_aliases evaluates to 0 (and it is the case on the MIPS cpu I 
have access to). To avoid caching problem in the relocation code, I disable 
the cache in KSEG0 (using the K0 field in CP0 CONFIG register) before jumping 
to the relocation code. I don't know how clean this solution is, but this 
avoids having to add non-portable cache flush code to relocate_kernel.S.

Regards,

Signed-off-by: Nicolas Schichan <nschichan@freebox.fr>

--- linux/arch/mips/kernel/machine_kexec.c	(revision 5939)
+++ linux/arch/mips/kernel/machine_kexec.c	(revision 5941)
@@ -50,8 +50,10 @@
 	reboot_code_buffer =
 	  (unsigned long)page_address(image->control_code_page);
 
+	printk(KERN_INFO "reboot code is at %08lx\n", reboot_code_buffer);
+
 	kexec_start_address = image->start;
-	kexec_indirection_page = phys_to_virt(image->head & PAGE_MASK);
+	kexec_indirection_page = (long)phys_to_virt(image->head & PAGE_MASK);
 
 	memcpy((void*)reboot_code_buffer, relocate_new_kernel,
 	       relocate_new_kernel_size);
@@ -75,11 +77,17 @@
 	 */
 	local_irq_disable();
 
-	flush_icache_range(reboot_code_buffer,
-			   reboot_code_buffer + KEXEC_CONTROL_CODE_SIZE);
+	__flush_cache_all();
+	flush_icache_all();
 
-	printk("Will call new kernel at %08x\n", image->start);
-	printk("Bye ...\n");
-	flush_cache_all();
+	/*
+	 * avoid cache operation related headache in
+	 * relocate_kernel.S: disable caches in kseg0, the new kernel
+	 * will take care to re-enable cache in kseg0.
+	 */
+	change_c0_config(CONF_CM_CMASK, CONF_CM_UNCACHED);
+
+	printk(KERN_INFO "Will call new kernel at %08lx\n", image->start);
+	printk(KERN_INFO "Bye ...\n");
 	((void (*)(void))reboot_code_buffer)();
 }

-- 
Nicolas Schichan
