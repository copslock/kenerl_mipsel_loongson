Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 15 Jan 2005 18:55:16 +0000 (GMT)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:15704
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8224839AbVAOSzL>; Sat, 15 Jan 2005 18:55:11 +0000
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1Cpt4o-0003Q2-00; Sat, 15 Jan 2005 19:55:10 +0100
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1Cpt4n-0002si-00; Sat, 15 Jan 2005 19:55:09 +0100
Date: Sat, 15 Jan 2005 19:55:09 +0100
To: Tom =?iso-8859-1?Q?Vr=E1na?= <tom@voda.cz>
Cc: linux-mips@ftp.linux-mips.org
Subject: Re: crosscompiling and
Message-ID: <20050115185509.GO31149@rembrandt.csv.ica.uni-stuttgart.de>
References: <41E96411.90305@voda.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <41E96411.90305@voda.cz>
User-Agent: Mutt/1.5.6+20040907i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@ftp.linux-mips.org
Original-Recipient: rfc822;linux-mips@ftp.linux-mips.org
X-archive-position: 6924
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Tom Vrána wrote:
> Hi,
> 
> I'm just hopelesly stuck, trying to make a kernel 2.4.27 for mips SoC 
> ADM5120 (MIPS 4Kc). I have the code in a 2.4.18 kernel that I'm able to 
> compile. With the code merged in 2.4.27 most of the stuff works, but I 
> get the following assembler errors. Like if it doesn't recognize what's 
> C and what assembler code ? I am using gcc3.3 toolchain built with 
> uclibc with 2.4.27 kernel headers. and I do appreciate any help....
>   
>          Tom
> 
> 
> mipsel-linux-uclibc-gcc  -D__KERNEL__ 
> -I/store/devel/adm/linux-2.4.27-mipscvs-20050114/include  -c -o 
> mipsIRQ.o mipsIRQ.S

It fails to add -D__ASSEMBLY__ for some reason. I guess the cause is
some broken Makefile in your tree.


Thiemo
