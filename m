Received:  by oss.sgi.com id <S305174AbQA2AeQ>;
	Fri, 28 Jan 2000 16:34:16 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:46679 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305169AbQA2AeA>; Fri, 28 Jan 2000 16:34:00 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id QAA05082; Fri, 28 Jan 2000 16:39:15 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id QAA39492
	for linux-list;
	Fri, 28 Jan 2000 16:25:36 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA52937
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 28 Jan 2000 16:25:30 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id QAA08869
	for <linux@cthulhu.engr.sgi.com>; Fri, 28 Jan 2000 16:25:19 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from cacc-27.uni-koblenz.de (cacc-27.uni-koblenz.de [141.26.131.27])
	by mailhost.uni-koblenz.de (8.9.3/8.9.3) with ESMTP id BAA26415;
	Sat, 29 Jan 2000 01:25:00 +0100 (MET)
Received:  by lappi.waldorf-gmbh.de id <S407894AbQA1ShZ>;
	Fri, 28 Jan 2000 19:37:25 +0100
Date:   Fri, 28 Jan 2000 19:37:25 +0100
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Charles Lepple <clepple@negativezero.org>
Cc:     Ralf Baechle <ralf@oss.sgi.com>, linux@cthulhu.engr.sgi.com,
        linux-mips@fnet.fr
Subject: Re: Embedded system with RAM Disk
Message-ID: <20000128193725.A4281@uni-koblenz.de>
References: <XFMail.000126201529.Harald.Koerfgen@home.ivm.de> <388F9ECA.DBFCED9D@negativezero.org> <20000128010301.B11868@uni-koblenz.de> <3890FE6A.B0A8B25@negativezero.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <3890FE6A.B0A8B25@negativezero.org>
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Thu, Jan 27, 2000 at 09:26:50PM -0500, Charles Lepple wrote:

> Ralf Baechle wrote:
> > On Wed, Jan 26, 2000 at 08:26:34PM -0500, Charles Lepple wrote:
> > > The PPC board that I used would not load ELF images with extra sections,
> [...]
> > In which case the PPC's ELF loader is hopless broken.  An ELF loader is
> > a quite simple thing, it only needs to process all the PT_LOAD entries
> > in the programm header table, done.
> 
> sorry to spam the lists, but I just have to clear the PPC name :-)
> 
> The boot firmware was for VxWorks, which evidently uses files which
> resemble ELF binaries down to the headers. I won't name the company who
> wrote the BSP, but it was pretty weak code (a little research in the
> Linux/PPC lists may turn stuff up though...)
> 
> Most standards-compilant (PReP, CHRP) boards do load things correctly,
> however.

On the MIPS-side the price for firmware weirdness goes to SNI's ARC firmware
which always loads programs to the address specified in the address + 8
bytes.  The really sick thing is that behaviour is even allowed by the
ARC spec even though it's truly undesired behaviour for a kernel loader.

Luckily this can be fixed with objcopy :-)

  Ralf
