Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Mar 2005 22:39:56 +0000 (GMT)
Received: from 63-207-7-10.ded.pacbell.net ([IPv6:::ffff:63.207.7.10]:60299
	"EHLO cassini.enmediainc.com") by linux-mips.org with ESMTP
	id <S8227075AbVCOWjk>; Tue, 15 Mar 2005 22:39:40 +0000
Received: from [127.0.0.1] (unknown [192.168.10.203])
	by cassini.enmediainc.com (Postfix) with ESMTP id 5D3E825C95F
	for <linux-mips@linux-mips.org>; Tue, 15 Mar 2005 14:39:37 -0800 (PST)
Message-ID: <423763B9.2000907@c2micro.com>
Date:	Tue, 15 Mar 2005 14:37:45 -0800
From:	Ed Martini <martini@c2micro.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Re: initrd problem
References: <4230DB4C.7090103@c2micro.com> <20050314110101.GF7759@linux-mips.org>
In-Reply-To: <20050314110101.GF7759@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <martini@c2micro.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7438
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: martini@c2micro.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:

>On Thu, Mar 10, 2005 at 03:42:04PM -0800, Ed Martini wrote:
>  
>
>>Should I put CONFIG_EMBEDDED_RAMDISK and its ilk back into my kernel, or 
>>write an ELF version of addinitrd?  Other ideas?
>>    
>>
>
>Things vanish for a reason ...  Try CONFIG_INITRAMFS_SOURCE instead.
>
>  Ralf
>
Ok.  Then let's get rid of it completly, and provide a replacement that 
works.

There were vestiges of embedded initrd in the ld script that were 
confusing when trying to sort things out. That, in conjunction with 
Documentation/initrd.txt made it hard to discover early user space and 
initramfs when coming from the old world (2.4).

Also, unless you move the location of .init.ramfs, it gets freed twice, 
leading to a panic.

 From the documentation alone it's impossible to figure out how to build 
your initramfs.  In various places the docs refer to the initial 
executable as /linuxrc, /kinit, /init, and possibly others.  If you read 
init/main.c you see that for an initramfs, your initial process will be 
started from /init.

diff -urN linux-2.6.11-linux-mips.org/arch/mips/kernel/vmlinux.lds.S 
linux/arch/mips/kernel/vmlinux.lds.S
--- linux-2.6.11-linux-mips.org/arch/mips/kernel/vmlinux.lds.S 
2005-03-15 13:41:51.000000000 -0800
+++ linux/arch/mips/kernel/vmlinux.lds.S 2005-03-15 14:34:00.339164936 -0800
@@ -54,13 +54,6 @@

     *(.data)

-   /* Align the initial ramdisk image (INITRD) on page boundaries. */
-   . = ALIGN(4096);
-   __rd_start = .;
-   *(.initrd)
-   . = ALIGN(4096);
-   __rd_end = .;
-
     CONSTRUCTORS
   }
   _gp = . + 0x8000;
@@ -82,6 +75,13 @@

   _edata =  .;   /* End of data section */

+   /* Align the initial ramfs image on page boundaries. */
+   /* It will be freed by init/initramfs.c */
+  . = ALIGN(4096);
+  __initramfs_start = .;
+  .init.ramfs : { *(.init.ramfs) }
+  __initramfs_end = .;
+
   /* will be freed after init */
   . = ALIGN(4096);  /* Init code and data */
   __init_begin = .;
@@ -118,10 +118,6 @@
   .con_initcall.init : { *(.con_initcall.init) }
   __con_initcall_end = .;
   SECURITY_INIT
-  . = ALIGN(4096);
-  __initramfs_start = .;
-  .init.ramfs : { *(.init.ramfs) }
-  __initramfs_end = .;
   . = ALIGN(32);
   __per_cpu_start = .;
   .data.percpu  : { *(.data.percpu) }
