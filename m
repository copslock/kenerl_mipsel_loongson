Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Aug 2004 18:49:09 +0100 (BST)
Received: from nevyn.them.org ([IPv6:::ffff:66.93.172.17]:3297 "EHLO
	nevyn.them.org") by linux-mips.org with ESMTP id <S8225004AbUHRRtC>;
	Wed, 18 Aug 2004 18:49:02 +0100
Received: from drow by nevyn.them.org with local (Exim 4.34 #1 (Debian))
	id 1BxUYR-00064z-Ux; Wed, 18 Aug 2004 13:48:56 -0400
Date: Wed, 18 Aug 2004 13:48:55 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	binutils@sources.redhat.com
Subject: Re: Branch bug in gas on MIPS
Message-ID: <20040818174855.GA23199@nevyn.them.org>
Mail-Followup-To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	binutils@sources.redhat.com
References: <20040817160110.GA32594@linux-mips.org> <20040818155819.GJ23756@rembrandt.csv.ica.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040818155819.GJ23756@rembrandt.csv.ica.uni-stuttgart.de>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Return-Path: <drow@nevyn.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5682
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Wed, Aug 18, 2004 at 05:58:19PM +0200, Thiemo Seufer wrote:
> Ralf Baechle wrote:
> > Below little test case demonstrates a gas bug that results in swapping
> > of the two branch instructions and use of bogus destination addresses
> > for the first of the two branches.
> > 
> > [ralf@lappi tmp]$ cat s.s
> > 1:      beqzl   $2, 1b
> >         beq     $4, $5, 1b
> > [ralf@lappi tmp]$ mips-linux-as -mips2 -o s.o s.s
> > [ralf@lappi tmp]$ mips-linux-objdump -d s.o
> >  
> > s.o:     file format elf32-tradbigmips
> >  
> > Disassembly of section .text:
> >  
> > 00000000 <.text>:
> >    0:   1085ffff        beq     a0,a1,0x0
> >    4:   00000000        nop
> >    8:   50400000        beqzl   v0,0xc
> >    c:   00000000        nop
> 
> I applied the appended patch. Daniel, I think this should also go
> in the branch.

OK.

-- 
Daniel Jacobowitz
