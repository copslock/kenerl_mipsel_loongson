Received:  by oss.sgi.com id <S305177AbQERL6z>;
	Thu, 18 May 2000 11:58:55 +0000
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:3112 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305154AbQERL6g>; Thu, 18 May 2000 11:58:36 +0000
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id FAA09357; Thu, 18 May 2000 05:03:08 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id EAA98591; Thu, 18 May 2000 04:58:04 -0700 (PDT)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id EAA54854
	for linux-list;
	Thu, 18 May 2000 04:48:22 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id EAA35395
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 18 May 2000 04:48:20 -0700 (PDT)
	mail_from (ralf@oss.sgi.com)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id EAA06108
	for <linux@cthulhu.engr.sgi.com>; Thu, 18 May 2000 04:48:18 -0700 (PDT)
	mail_from (ralf@oss.sgi.com)
Received: from cacc-5.uni-koblenz.de (cacc-5.uni-koblenz.de [141.26.131.5])
	by mailhost.uni-koblenz.de (8.9.3/8.9.3) with ESMTP id NAA22784;
	Thu, 18 May 2000 13:48:19 +0200 (MET DST)
Received:  by lappi.waldorf-gmbh.de id <S1405589AbQERLrf>;
	Thu, 18 May 2000 13:47:35 +0200
Date:   Thu, 18 May 2000 13:47:35 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Florian Lohoff <flo@rfc822.org>
Cc:     "Soren S. Jorvang" <soren@wheel.dk>, linux@cthulhu.engr.sgi.com
Subject: Re: O2 ARCS
Message-ID: <20000518134735.A1078@uni-koblenz.de>
References: <20000517051524.A21067@gnyf.wheel.dk> <20000517215310.F779@uni-koblenz.de> <20000518011656.A721@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20000518011656.A721@paradigm.rfc822.org>; from flo@rfc822.org on Thu, May 18, 2000 at 01:16:56AM +0200
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Thu, May 18, 2000 at 01:16:56AM +0200, Florian Lohoff wrote:

> On Wed, May 17, 2000 at 09:53:11PM +0200, Ralf Baechle wrote:
> > The ARCS firmware isn't the big deal but the R10000 support for this
> > system or any other non-cachecoherent system.  Harald Koerfgen has
> > started poking at an O2 port and he's got first success.
> 
> BTW: Is there any Documentation for the ARC Firmware of the SGIs ?

I've got various dead tree document which document ARC.
First there is the ARC standard, a document which is Microsoft and ACE
copyrighted.  This also defines various hardware properties like plugs,
screen resolution, audio etc.  These were already fairly lowend by '94
when I first saw the document.  Consequentially a new standard was
named ``Microsoft Portable Bootloader Standard'' was created which
essentially is just most of the software parts from the full ARC
standard.  Both documents are completly NT centric.  In the meantime I
somewhere saw a newer version of the ARC standard which afair is
copyrighted by some publishing company (Addison Wesley?).  Not sure if
it was actually published as a book.  Finally there is SGI's variant
ARCS which is big endian and has various other minor changes from the
Portable Bootloader Standard.  I don't know of any documentation.

Not all SGI machines do even use ARCS.  The older ones have a MIPS-style
firmware, more current ones like the Origin have a ``enhanced subset''
of ARCS.  Look into include/asm-mips64/sn/kl{config,dir}.h to find
how those datastructures look.  On the Origin for example quering the
ARCS configuration tree doesn't work at all.  For this new style
configuration information there is not much more documentatin available
than these IRIX header files.

  Ralf
