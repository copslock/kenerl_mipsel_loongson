Received:  by oss.sgi.com id <S42240AbQEYRY5>;
	Thu, 25 May 2000 10:24:57 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:5967 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S42238AbQEYRYp>;
	Thu, 25 May 2000 10:24:45 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id LAA05285; Thu, 25 May 2000 11:19:22 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id LAA08805
	for linux-list;
	Thu, 25 May 2000 11:18:20 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id LAA21770;
	Thu, 25 May 2000 11:18:17 -0700 (PDT)
	mail_from (ralf@oss.sgi.com)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id LAA03348; Thu, 25 May 2000 11:18:15 -0700 (PDT)
	mail_from (ralf@oss.sgi.com)
Received: from cacc-14.uni-koblenz.de (cacc-14.uni-koblenz.de [141.26.131.14])
	by mailhost.uni-koblenz.de (8.9.3/8.9.3) with ESMTP id UAA18623;
	Thu, 25 May 2000 20:18:10 +0200 (MET DST)
Received:  by lappi.waldorf-gmbh.de id <S1405632AbQEYSRt>;
	Thu, 25 May 2000 20:17:49 +0200
Date:   Thu, 25 May 2000 20:17:49 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Ulf Carlsson <ulfc@calypso.engr.sgi.com>
Cc:     Harald Koerfgen <Harald.Koerfgen@home.ivm.de>,
        SGI Linux <linux@cthulhu.engr.sgi.com>,
        Linux MIPS <linux-mips@fnet.fr>, Klaus Naumann <spock@mgnet.de>
Subject: Re: CVS Update@oss.sgi.com: linux
Message-ID: <20000525201749.A15789@uni-koblenz.de>
References: <20000525200021.A1226@uni-koblenz.de> <Pine.LNX.4.21.0005251100380.15277-100000@calypso.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.21.0005251100380.15277-100000@calypso.engr.sgi.com>; from ulfc@calypso.engr.sgi.com on Thu, May 25, 2000 at 11:02:52AM -0700
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Thu, May 25, 2000 at 11:02:52AM -0700, Ulf Carlsson wrote:

> > > Would you mind removing the include/asm-$(ARCH)/offset.h from the CVS
> > > repository, I get conflicts and stuff when I update.  I don't see why we
> > > need to have a dummy file there.
> > 
> > Conceptually I don't like that either.
> 
> I think my solution that I submitted yesterday was pretty good.  If add a rule
> that removes include/asm-$(ARCH)/offset.h when you make clean we will be just
> fine.  You'll have to make clean when you toggle between SMP and UP, but I
> think we can live with that.

The recent change of __SMP__ to CONFIG_SMP almost everywhere in the kernel
was intended to avoid just that.

  Ralf
