Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Apr 2003 12:43:53 +0100 (BST)
Received: from p508B7959.dip.t-dialin.net ([IPv6:::ffff:80.139.121.89]:60608
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225193AbTDALnw>; Tue, 1 Apr 2003 12:43:52 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h31BgwL07672;
	Tue, 1 Apr 2003 13:42:58 +0200
Date: Tue, 1 Apr 2003 13:42:58 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: "Neeraj  Garg, Noida" <ngarg@noida.hcltech.com>
Cc: linux-mips@linux-mips.org
Subject: Re: Linux-MIPS compilation
Message-ID: <20030401134258.A7618@linux-mips.org>
References: <E04CF3F88ACBD5119EFE00508BBB2121086ED859@exch-01.noida.hcltech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E04CF3F88ACBD5119EFE00508BBB2121086ED859@exch-01.noida.hcltech.com>; from ngarg@noida.hcltech.com on Tue, Apr 01, 2003 at 12:05:18PM +0530
Return-Path: <ralf@linux-mips.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1884
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Apr 01, 2003 at 12:05:18PM +0530, Neeraj  Garg, Noida wrote:

> Using compilation options:
> mips-linux-gcc -D__KERNEL__ -D__linux__ -D_MIPS_SZLONG=32
> -I/usr/emb_linux/linux-2.4.20/include -D__linux__ -Wall -Wstrict-prototypes
> -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -I
> /usr/emb_linux/linux-2.4.20/include/asm/gcc -G 0 -mno-abicalls -fno-pic
> -pipe -g -mcpu=r4600 -mips2 -Wa,--trap  -DUTS_MACHINE='"mips"'
> 
> I have got a tons of warnings named as:
> {standard input}: Assembler messages:
> {standard input}:784: Warning: Macro instruction expanded into multiple
> instructions
> {standard input}:784: Warning: No .cprestore pseudo-op used in PIC code
> 
> Can anybody help out to remove these warnings?

The options -D__linux__ -D_MIPS_SZLONG=32 and the error messages make it
look like you're forcing a non-Linux toolchain into building a kernel.

  Ralf
