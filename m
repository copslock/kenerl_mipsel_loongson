Received:  by oss.sgi.com id <S42240AbQEYRKH>;
	Thu, 25 May 2000 10:10:07 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:54856 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S42238AbQEYRJo>;
	Thu, 25 May 2000 10:09:44 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id LAA03009; Thu, 25 May 2000 11:04:21 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id LAA39127
	for linux-list;
	Thu, 25 May 2000 11:01:14 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id LAA96581;
	Thu, 25 May 2000 11:01:10 -0700 (PDT)
	mail_from (ralf@oss.sgi.com)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id LAA03481; Thu, 25 May 2000 11:01:08 -0700 (PDT)
	mail_from (ralf@oss.sgi.com)
Received: from cacc-14.uni-koblenz.de (cacc-14.uni-koblenz.de [141.26.131.14])
	by mailhost.uni-koblenz.de (8.9.3/8.9.3) with ESMTP id UAA16088;
	Thu, 25 May 2000 20:00:49 +0200 (MET DST)
Received:  by lappi.waldorf-gmbh.de id <S1405766AbQEYSAV>;
	Thu, 25 May 2000 20:00:21 +0200
Date:   Thu, 25 May 2000 20:00:21 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Ulf Carlsson <ulfc@calypso.engr.sgi.com>
Cc:     Harald Koerfgen <Harald.Koerfgen@home.ivm.de>,
        SGI Linux <linux@cthulhu.engr.sgi.com>,
        Linux MIPS <linux-mips@fnet.fr>, Klaus Naumann <spock@mgnet.de>
Subject: Re: CVS Update@oss.sgi.com: linux
Message-ID: <20000525200021.A1226@uni-koblenz.de>
References: <XFMail.000525191403.Harald.Koerfgen@home.ivm.de> <Pine.LNX.4.21.0005251017410.15277-100000@calypso.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.21.0005251017410.15277-100000@calypso.engr.sgi.com>; from ulfc@calypso.engr.sgi.com on Thu, May 25, 2000 at 10:19:40AM -0700
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Thu, May 25, 2000 at 10:19:40AM -0700, Ulf Carlsson wrote:

> > On 24-May-00 Ralf Baechle wrote:
> > [offset.h]
> > 
> > > A good solution is important now that we have SMP.  Toggling CONFIG_SMP
> > > affects offset.h and not for all variations of make invocations we
> > > actually have the guarantee that offset.h is being rebuilt before using
> > > it.
> > 
> > What about making offset.h to depend on $(TOPDIR)/.config?
> > 
> > This may cause unneccessary rebuilds of objects depending on offset.h after
> > configuration changes but it forces offset.h to be rebuilt when CONFIG_SMP is
> > toggled.
> 
> Would you mind removing the include/asm-$(ARCH)/offset.h from the CVS
> repository, I get conflicts and stuff when I update.  I don't see why we need
> to have a dummy file there.

Conceptually I don't like that either.

  Ralf
