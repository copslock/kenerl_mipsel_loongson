Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Mar 2004 02:37:40 +0000 (GMT)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:53518
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225322AbUCIChj>; Tue, 9 Mar 2004 02:37:39 +0000
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42] ident=mail)
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1B0X7i-00036J-00
	for <linux-mips@linux-mips.org>; Tue, 09 Mar 2004 03:37:38 +0100
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1B0X7i-0000h8-00
	for <linux-mips@linux-mips.org>; Tue, 09 Mar 2004 03:37:38 +0100
Date: Tue, 9 Mar 2004 03:37:37 +0100
To: linux-mips@linux-mips.org
Subject: Re: 2.4 kernels + >=binutils-2.14.90.0.8
Message-ID: <20040309023737.GJ16163@rembrandt.csv.ica.uni-stuttgart.de>
References: <404D0132.3020202@gentoo.org> <20040308234450.GF16163@rembrandt.csv.ica.uni-stuttgart.de> <404D0A18.6050802@gentoo.org> <20040309003447.GH16163@rembrandt.csv.ica.uni-stuttgart.de> <404D1909.1020005@gentoo.org> <20040309013841.GI16163@rembrandt.csv.ica.uni-stuttgart.de> <404D28B1.4010608@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <404D28B1.4010608@gentoo.org>
User-Agent: Mutt/1.5.5.1i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4511
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Kumba wrote:
> Thiemo Seufer wrote:
> 
> >It looks like that pax patch makes the difference.
> >
> >Speculation:
> >With this large alignment, the load would overwrite the exception
> >handlers at 0x80000000 if the firmware wouldn't recognize this area
> >as already in use. Reducing the alignment to 4k may improve things.
> >
> >Btw, an empty segment with no section assigned looks like a bug to me.
> >
> >Btw2, converting the non-writable segment into a writeable one
> >doesn't look like an improvement (but doesn't matter much).
> 
> Well, I re-generated my cross-compiler w/o the patch, doesn't seem to 
> have affected much.
> 
> I'll strip the remaining patches out, and see what the outcome is 
> (although the remaining patches have been in gentoo's binutils since 
> 2.13.* and haven't had issues).
[snip]
>   Type           Offset   VirtAddr   PhysAddr   FileSiz MemSiz  Flg Align
>   REGINFO        0x1573c0 0x881573c0 0x881573c0 0x00018 0x00018 R   0x4
>   LOAD           0x000000 0x88000000 0x88000000 0x16d000 0x194400 RWE 0x10000

Well, then the effects I wrote about were not caused by that patch
but by a broken linker. Re-doing the final link with the old linker
should be enough to prove that.

From the different alignment, this _might_ be related to Maciej's
binutils patch for PAGE_SIZE != 4k.
http://sources.redhat.com/ml/binutils/2003-12/msg00380.html

[snip]
> >> boot -f 2425x1
> 
> Cannot load scsi(0)disk(4)rdisk(0)partition(8)/2425x1.
> Text start 0x8000000, size 0x194400 doesn't fit in a FreeMemory area.

The text start should be at 0x8002000 or higher, else it will fail.


Thiemo
