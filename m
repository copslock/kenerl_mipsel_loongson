Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id RAA44379 for <linux-archive@neteng.engr.sgi.com>; Wed, 21 Oct 1998 17:47:39 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id RAA93342
	for linux-list;
	Wed, 21 Oct 1998 17:47:07 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id RAA79604
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 21 Oct 1998 17:47:04 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id RAA08209
	for <linux@cthulhu.engr.sgi.com>; Wed, 21 Oct 1998 17:47:03 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (pmport-23.uni-koblenz.de [141.26.249.23])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id CAA15693
	for <linux@cthulhu.engr.sgi.com>; Thu, 22 Oct 1998 02:46:53 +0200 (MET DST)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.8.7/8.8.7) id CAA00469;
	Thu, 22 Oct 1998 02:44:08 +0200
Message-ID: <19981022024408.A360@uni-koblenz.de>
Date: Thu, 22 Oct 1998 02:44:08 +0200
From: ralf@uni-koblenz.de
To: "David S. Miller" <davem@dm.cobaltmicro.com>
Cc: linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: Re: Haifa scheduler bug in egcs 1.0.2
References: <19981021015047.G1830@uni-koblenz.de> <199810210139.SAA22458@dm.cobaltmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91.1
In-Reply-To: <199810210139.SAA22458@dm.cobaltmicro.com>; from David S. Miller on Tue, Oct 20, 1998 at 06:39:21PM -0700
X-Mutt-References: <199810210139.SAA22458@dm.cobaltmicro.com>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Tue, Oct 20, 1998 at 06:39:21PM -0700, David S. Miller wrote:

>    Relocating the code generated from this source later on will not be
>    possible for ld.  As knows this and dies ungracefully.
> 
> Then why is this a supposed bug in Haifa?  It looks to me there is a
> problem with how %hi relocs are assosciated with %lo ones in binutils.

It's not necessarily a bug in Haida itself but it gets visible when Haifa
is enabled.  I haven't looked closely at the involved egcs code yet.

> The code you showed me looks perfectly legal.

For ECOFF and ELF, relocations against symbols are done in two parts, with
a hi16 relocation and a lo16 relocation.  Each relocation has only 16 bits of
space to store an addend and a carry may have to be propagated between
the two.  This means that in order for the linker to handle carries
correctly, it must be able to locate both the hi16 and the lo16 relocation.
Object files which don't contain any other information except the order in
the relocation table which could be used to find the hi16 / lo16 relocs which
belong together.

The code I showed cannot be represented in a ELF or ECOFF object such that
the linker still knows which hi16 and which lo16 relocations are associated
with each other.  Therefore it is not possible for the linker to correctly
do the hi16 relocations.  Btw, all MIPS assemblers I know of will warn or
even error about that fragment.

The ABI is quite strict in that aspect, it wants one lo16 per hi16 for the
same symbol.  Binutils relax that by allowing an arbitrary number of hi16
and one lo16 for the same symbol.

  Ralf
