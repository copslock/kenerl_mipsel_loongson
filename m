Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id PAA76958 for <linux-archive@neteng.engr.sgi.com>; Tue, 20 Oct 1998 15:39:08 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA88137
	for linux-list;
	Tue, 20 Oct 1998 15:38:30 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA87304
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 20 Oct 1998 15:38:27 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA00687
	for <linux@cthulhu.engr.sgi.com>; Tue, 20 Oct 1998 15:38:10 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (pmport-24.uni-koblenz.de [141.26.249.24])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id AAA20734
	for <linux@cthulhu.engr.sgi.com>; Wed, 21 Oct 1998 00:38:06 +0200 (MET DST)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.8.7/8.8.7) id TAA01121;
	Tue, 20 Oct 1998 19:31:16 +0200
Message-ID: <19981020193116.C478@uni-koblenz.de>
Date: Tue, 20 Oct 1998 19:31:16 +0200
From: ralf@uni-koblenz.de
To: Warner Losh <imp@village.org>
Cc: linux-mips@fnet.fr, linux@cthulhu.engr.sgi.com
Subject: Re: get_mmu_context()
References: <19981019121804.F387@uni-koblenz.de> <Pine.SV4.3.91.981016185136.876A-100000@mech.math.msu.su> <XFMail.981018215318.harald.koerfgen@netcologne.de> <19981019121804.F387@uni-koblenz.de> <199810200407.WAA03233@harmony.village.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91.1
In-Reply-To: <199810200407.WAA03233@harmony.village.org>; from Warner Losh on Mon, Oct 19, 1998 at 10:07:26PM -0600
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Mon, Oct 19, 1998 at 10:07:26PM -0600, Warner Losh wrote:

> Wouldn't it be easier to have ld to have variant fixup records?  That
> way you could patch all instances at run time, much like we do when we
> load stuff now...
> 
> You are basically duplicating the functionality of the linker here for
> no good reason.  Actually, besides the non-standard aspect of it,
> there is a good reason: it is easier to hack like this than to do
> battle with the bfd and/or boot blocks to get this to happen. :-)
> 
> It is a way cool hack, don't get me wrong, but it just seems that it
> would be more useful to be generic like that.

Neither compiler, assembler nor linker can solve the problem for us
because it requires knowledge of facts which we usually don't know before
running on the target machine.  On the other side as soon as we run on
the machine we know these details.  They're constants, so why not making
optimal use of them?

As alternative to achieve the same level of efficience imagine the
following configuration dialogue:

#
# Cache configuration
#
Does your machine have a second level cache (CONFIG_L2_CACHE) [N/y] y
  Is your CPU an Indy R4600SC or R5000SC (CONFIG_L2_INDY) [N/y]
  l2 linesize (16, 32, 64, 128) [128]
  Split Scache (CONFIG_L2_SPLIT) [N/y] 
  Do your VCE exceptions work (CONFIG_R4000SC_V2) [N/y]
Primary instruction cache linesize (16, 32) [16]
Primary data cache linesize (16, 32) [16]

Oh, there is more fun we'd need to ask for like DRAM controller versions
for Magnums etc.  Cool vomit bag, isn't it ;-)

Things look different for fixed configuration systems like for example
the Cobalt Qube.  But we have to deal with zillion of system variants.

You're right in that things should become more generic and I have ideas
to make them more generic.  For the moment being I don't want to continue
on that since 2.2 is coming soon and more important things are still to do.
That's should however be an interesting 2.3 project.

  Ralf
