Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Jan 2005 10:11:26 +0000 (GMT)
Received: from host181-209-dsl.dols.net.pk ([IPv6:::ffff:202.147.181.209]:9387
	"EHLO 1aurora.enabtech") by linux-mips.org with ESMTP
	id <S8225212AbVAJKLR>; Mon, 10 Jan 2005 10:11:17 +0000
Received: by 1aurora.enabtech with Internet Mail Service (5.5.2448.0)
	id <C459AN21>; Mon, 10 Jan 2005 15:01:18 +0500
Message-ID: <1B701004057AF74FAFF851560087B1610646A1@1aurora.enabtech>
From: Mudeem Iqbal <mudeem@Quartics.com>
To: 'Thiemo Seufer' <ica2_ts@csv.ica.uni-stuttgart.de>
Cc: "'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Subject: RE: mipsel-linux-ld:arch/mips/kernel/vmlinux.lds:6: parse error
Date: Mon, 10 Jan 2005 15:01:16 +0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2448.0)
Content-Type: text/plain
Return-Path: <mudeem@Quartics.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6854
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mudeem@Quartics.com
Precedence: bulk
X-list: linux-mips

I ran

#make ARCh=mips CROSS_COMPILE=mipsel-linux- clean

this removed vmlinux.lds and then I again ran make by

#make ARCh=mips CROSS_COMPILE=mipsel-linux-

but again same error. could there be something wrong in vmlinux.lds.S that
vmlinux.lds is not being generated properly

Mudeem

-----Original Message-----
From: Thiemo Seufer [mailto:ica2_ts@csv.ica.uni-stuttgart.de]
Sent: Monday, January 10, 2005 2:09 PM
To: Mudeem Iqbal
Cc: 'linux-mips@linux-mips.org'
Subject: Re: mipsel-linux-ld:arch/mips/kernel/vmlinux.lds:6: parse error


Mudeem Iqbal wrote:
> hi,
> 
> I have built a toolchain using the following combination
> 
> binutils-2.15.94.0.2
> gcc-3.4.3
> glibc-2.3.3
> linux-2.6.9	(from linux-mips.org)
> 
> I am cross compiling linux kernel for mips. I think the toolchain has been
> successfully built. But when cross compiling the kernel I get the
following
> error
> 
> LD	init/built-in.o
> LD .tmp_vmlinux1
> mipsel-linux-ld:arch/mips/kernel/vmlinux.lds:6: parse error
> make: ***[.tmp_vmlinux1] Error 1
> 
> The vmlinux.lds is as follows
> 
> 1) OUPUT_ARH(mips)
> 2) Entry(kernel_entry)
> 3) jiffies = jiffies_64;
> 4) SECTION
> 5) {
> 6)	. = ;
> 7)	/* rea-only */
> 8)	_text = .; /* Text and read only data *
> 	..................................
> }

This linker script is completely garbled and unusable.

> The line indicated by the error is . = ; Any ideas

This line has to read

	. = .;

Regenerate the script from the vmlinux.lds.S file (by removing
it and running make).


Thiemo
