Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Mar 2004 00:34:51 +0000 (GMT)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:21773
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225299AbUCIAes>; Tue, 9 Mar 2004 00:34:48 +0000
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42] ident=mail)
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1B0VCp-0001is-00
	for <linux-mips@linux-mips.org>; Tue, 09 Mar 2004 01:34:47 +0100
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1B0VCp-0008Ua-00
	for <linux-mips@linux-mips.org>; Tue, 09 Mar 2004 01:34:47 +0100
Date: Tue, 9 Mar 2004 01:34:47 +0100
To: linux-mips@linux-mips.org
Subject: Re: 2.4 kernels + >=binutils-2.14.90.0.8
Message-ID: <20040309003447.GH16163@rembrandt.csv.ica.uni-stuttgart.de>
References: <404D0132.3020202@gentoo.org> <20040308234450.GF16163@rembrandt.csv.ica.uni-stuttgart.de> <404D0A18.6050802@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <404D0A18.6050802@gentoo.org>
User-Agent: Mutt/1.5.5.1i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4507
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Kumba wrote:
> Thiemo Seufer wrote:
> 
> >What's the output of readelf -l for this kernel?
> 
> # mips-unknown-linux-gnu-readelf -l vmlinux
> 
> Elf file type is EXEC (Executable file)
> Entry point 0x88144040
> There are 3 program headers, starting at offset 52
> 
> Program Headers:
>   Type           Offset   VirtAddr   PhysAddr   FileSiz MemSiz  Flg Align
>   REGINFO        0x1573c0 0x881573c0 0x881573c0 0x00018 0x00018 R   0x4
>   LOAD           0x000000 0x88000000 0x88000000 0x16d000 0x194400 RWE 0x10000

The REGINFO looks weird, pointing in the load segment. Maybe readelf -S
tells more (especially if compared wit an earlier working version).

>   PAX_FLAGS      0x000000 0x00000000 0x00000000 0x00000 0x00000     0x4

PAX_FLAGS?


Thiemo
