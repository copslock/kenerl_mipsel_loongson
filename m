Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Mar 2004 23:44:53 +0000 (GMT)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:55564
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225255AbUCHXow>; Mon, 8 Mar 2004 23:44:52 +0000
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42] ident=mail)
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1B0UQU-0001DF-00
	for <linux-mips@linux-mips.org>; Tue, 09 Mar 2004 00:44:50 +0100
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1B0UQU-0008HA-00
	for <linux-mips@linux-mips.org>; Tue, 09 Mar 2004 00:44:50 +0100
Date: Tue, 9 Mar 2004 00:44:50 +0100
To: linux-mips@linux-mips.org
Subject: Re: 2.4 kernels + >=binutils-2.14.90.0.8
Message-ID: <20040308234450.GF16163@rembrandt.csv.ica.uni-stuttgart.de>
References: <404D0132.3020202@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <404D0132.3020202@gentoo.org>
User-Agent: Mutt/1.5.5.1i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4505
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Kumba wrote:
[snip]
> >> boot -f 2425x0
> 
> Cannot load scsi(0)disk(4)rdisk(0)partition(8)/2425x0.
> Text start 0x8000000, size 0x194400 doesn't fit in a FreeMemory area.

What's the output of readelf -l for this kernel?


Thiemo
