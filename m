Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Mar 2004 01:38:44 +0000 (GMT)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:63245
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225310AbUCIBin>; Tue, 9 Mar 2004 01:38:43 +0000
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42] ident=mail)
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1B0WCg-0002N5-00
	for <linux-mips@linux-mips.org>; Tue, 09 Mar 2004 02:38:42 +0100
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1B0WCg-0000Q6-00
	for <linux-mips@linux-mips.org>; Tue, 09 Mar 2004 02:38:42 +0100
Date: Tue, 9 Mar 2004 02:38:42 +0100
To: linux-mips@linux-mips.org
Subject: Re: 2.4 kernels + >=binutils-2.14.90.0.8
Message-ID: <20040309013841.GI16163@rembrandt.csv.ica.uni-stuttgart.de>
References: <404D0132.3020202@gentoo.org> <20040308234450.GF16163@rembrandt.csv.ica.uni-stuttgart.de> <404D0A18.6050802@gentoo.org> <20040309003447.GH16163@rembrandt.csv.ica.uni-stuttgart.de> <404D1909.1020005@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <404D1909.1020005@gentoo.org>
User-Agent: Mutt/1.5.5.1i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4509
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Kumba wrote:
[snip]
>   Type           Offset   VirtAddr   PhysAddr   FileSiz MemSiz  Flg Align
>   REGINFO        0x1563c0 0x881573c0 0x881573c0 0x00018 0x00018 R   0x4
>   LOAD           0x001000 0x88002000 0x88002000 0x13ffc0 0x13ffc0 R E 0x1000
>   LOAD           0x141000 0x88142000 0x88142000 0x2b000 0x52400 RWE 0x1000
[snip]
>   Type           Offset   VirtAddr   PhysAddr   FileSiz MemSiz  Flg Align
>   REGINFO        0x1573c0 0x881573c0 0x881573c0 0x00018 0x00018 R   0x4
>   LOAD           0x000000 0x88000000 0x88000000 0x16d000 0x194400 RWE 0x10000
>   PAX_FLAGS      0x000000 0x00000000 0x00000000 0x00000 0x00000     0x4

It looks like that pax patch makes the difference.

Speculation:
With this large alignment, the load would overwrite the exception
handlers at 0x80000000 if the firmware wouldn't recognize this area
as already in use. Reducing the alignment to 4k may improve things.

Btw, an empty segment with no section assigned looks like a bug to me.

Btw2, converting the non-writable segment into a writeable one
doesn't look like an improvement (but doesn't matter much).


Thiemo
