Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Mar 2004 14:21:19 +0000 (GMT)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:19997
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225255AbUCZOVT>; Fri, 26 Mar 2004 14:21:19 +0000
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42] ident=mail)
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1B6sCy-0001UX-00; Fri, 26 Mar 2004 15:21:16 +0100
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1B6sCy-0006hK-00; Fri, 26 Mar 2004 15:21:16 +0100
Date: Fri, 26 Mar 2004 15:21:16 +0100
To: Thomas Koeller <thomas.koeller@baslerweb.com>
Cc: linux-mips@linux-mips.org
Subject: Re: linker script problem
Message-ID: <20040326142116.GH9524@rembrandt.csv.ica.uni-stuttgart.de>
References: <200403261349.41783.thomas.koeller@baslerweb.com> <20040326125704.GF9524@rembrandt.csv.ica.uni-stuttgart.de> <200403261455.38960.thomas.koeller@baslerweb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403261455.38960.thomas.koeller@baslerweb.com>
User-Agent: Mutt/1.5.5.1i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4658
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Thomas Koeller wrote:
> Thiemo Seufer wrote:
> > You haven't told what target you are compiling for. LOADADDR should
> > be defined in arch/mips*/Makefile for every subarchitecture.
> 
> Thanks for the hint. My target is the PMC-Sierra Yosemite evaluation
> board. I found that this board has no entry in arch/mips/Makefile,
> which explains why LOADADDR is unset. Can you point me at some useful
> information about how to choose a sensible load address? Will the RAM
> base address do?

The documentation of the board should tell. Usually the first few pages
are already in use by exception handlers and firmware.

> Btw. if I get this right and want to contribute a patch, what are the
> rules for doing so? Would I need to provide some legal stuff (copyright
> assignment) first?

For the linux kernel there is no central instance holding the copyrights,
so no assignment is necessary. Of course, the patch must be licensed
under the same terms as Linux itself, which is GPL v2.


Thiemo
