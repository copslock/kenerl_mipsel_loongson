Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Feb 2003 08:03:59 +0000 (GMT)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:8835
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8224939AbTBYID7>; Tue, 25 Feb 2003 08:03:59 +0000
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp (Exim 3.36 #2)
	id 18na3k-001TAV-00; Tue, 25 Feb 2003 09:03:28 +0100
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 18na3k-0000kT-00; Tue, 25 Feb 2003 09:03:28 +0100
Date: Tue, 25 Feb 2003 09:03:28 +0100
To: jeff <jeff_lee@coventive.com>
Cc: linux-mips@linux-mips.org
Subject: Re: Kernel 2.4.20
Message-ID: <20030225080327.GC25303@rembrandt.csv.ica.uni-stuttgart.de>
References: <20030225124850.32cfa6f5.yoichi_yuasa@montavista.co.jp> <LPECIADMAHLPOFOIEEFNIELPCNAA.jeff_lee@coventive.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <LPECIADMAHLPOFOIEEFNIELPCNAA.jeff_lee@coventive.com>
User-Agent: Mutt/1.4i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1542
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

jeff wrote:
> Dear All,
>     I am trying to porting NEC Vr4131 platform from 2.4.16 to 2.4.20 but I found some problem.
> In kernel 2.4.16, the kernel entry is 0x80002470 but the kernel entry in 2.4.20 is 0x801xxxxx

That's just normal, the entry is variable.

> So my problem is how to change the kernel entry from 0x801xxxxx to be 0x8000xxxx? or how 
> to test this kernel when the kernel entry is 0x801xxxxx?

The entry address is encoded in the ELF header at the beginning of vmlinux
(as it is for all other ELF executables). The header's layout can be found
e.g. in linux/include/linux/elf.h.


Thiemo
