Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Apr 2003 19:53:22 +0100 (BST)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:11364
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225208AbTDXSxP>; Thu, 24 Apr 2003 19:53:15 +0100
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp (Exim 3.36 #2)
	id 198lqL-000jIJ-00
	for linux-mips@linux-mips.org; Thu, 24 Apr 2003 20:53:13 +0200
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 198lqL-0001sT-00
	for <linux-mips@linux-mips.org>; Thu, 24 Apr 2003 20:53:13 +0200
Date: Thu, 24 Apr 2003 20:53:13 +0200
To: linux-mips@linux-mips.org
Subject: Re: [patch] wait instruction on vr4181
Message-ID: <20030424185313.GA19131@rembrandt.csv.ica.uni-stuttgart.de>
References: <078a01c30a8c$a4cb9350$3501a8c0@wssseeger> <Pine.GSO.3.96.1030424202042.24567D-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.3.96.1030424202042.24567D-100000@delta.ds2.pg.gda.pl>
User-Agent: Mutt/1.4i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2172
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:
> On Thu, 24 Apr 2003, Steven Seeger wrote:
> 
> > Hey, when I try to patch in standby, it says that opcode isn't available for
> > the R6000. Why does arch/mips/Makefile use -mcpu=r4600 for the VR41XX?

Probably because it is the closest match for very old toolchains.

>  I fear you need to handcode the instruction until gas supports some sort
> of a CPU override, similar to ".set mips".  Using "-mcpu" or "-march" 
> won't help as the code wants to be compiled regardless of the CPU
> selection.  Currently gas supports the opcode for VR4100, VR4111 and
> VR4120, but there is no way to select any of them except on the command
> line. 

Huh? Current CVS GAS has command line options for
-march=vr{4100,4111,4120,4130,4181,4300}, and even rather old
GAS versions have -4100. Current CVS gcc supports
-march=vr{4100,4111,4120,4300}.


Thiemo
