Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Jan 2005 14:04:41 +0000 (GMT)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:31348
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225305AbVAJOEd>; Mon, 10 Jan 2005 14:04:33 +0000
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1Co09m-0008UR-00; Mon, 10 Jan 2005 15:04:30 +0100
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1Co09l-00065l-00; Mon, 10 Jan 2005 15:04:29 +0100
Date: Mon, 10 Jan 2005 15:04:29 +0100
To: Rojhalat Ibrahim <ibrahim@schenk.isar.de>
Cc: linux-mips@linux-mips.org
Subject: Re: [PATCH] Further TLB handler optimizations
Message-ID: <20050110140429.GC15344@rembrandt.csv.ica.uni-stuttgart.de>
References: <20041223202526.GA2254@deprecation.cyrius.com> <20041224040051.93587.qmail@web52806.mail.yahoo.com> <20041224085645.GJ3539@rembrandt.csv.ica.uni-stuttgart.de> <20050107190605.GG31335@rembrandt.csv.ica.uni-stuttgart.de> <41E27A6A.5060204@schenk.isar.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41E27A6A.5060204@schenk.isar.de>
User-Agent: Mutt/1.5.6+20040907i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6859
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Rojhalat Ibrahim wrote:
> Thiemo Seufer wrote:
> >
> >I updated the patch now and checked it in. Please test, especially
> >for cases I couldn't do, like R3000-style TLB handling and MIPS32
> >CPUs with 64bit physaddr.
> >
> 
> My Yosemite board (RM9000 processor) does not boot anymore with
> CONFIG_64BIT_PHYS_ADDR. Without that option it seems to be working
> as before. I tried to define cpu_has_64bit_gp_regs.

Correct, this should always be defined for 64bit capable CPUs.

> With that it boots partly.

Where does it fail?

> When I also define cpu_has_64bit_addresses it stops working again.

cpu_has_64bit_addresses is roughly the same as CONFIG_MIPS64,
so it's unsurprising that it breaks 32bit kernels.


Thiemo
