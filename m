Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Jan 2005 09:09:04 +0000 (GMT)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:60272
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8224788AbVAJJJA>; Mon, 10 Jan 2005 09:09:00 +0000
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1CnvXe-000680-00; Mon, 10 Jan 2005 10:08:50 +0100
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1CnvXd-0005MC-00; Mon, 10 Jan 2005 10:08:49 +0100
Date: Mon, 10 Jan 2005 10:08:49 +0100
To: Mudeem Iqbal <mudeem@Quartics.com>
Cc: "'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Subject: Re: mipsel-linux-ld:arch/mips/kernel/vmlinux.lds:6: parse error
Message-ID: <20050110090849.GA15344@rembrandt.csv.ica.uni-stuttgart.de>
References: <1B701004057AF74FAFF851560087B1610646A0@1aurora.enabtech>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1B701004057AF74FAFF851560087B1610646A0@1aurora.enabtech>
User-Agent: Mutt/1.5.6+20040907i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6853
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

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
> successfully built. But when cross compiling the kernel I get the following
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
