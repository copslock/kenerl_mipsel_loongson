Received:  by oss.sgi.com id <S42240AbQEYQbH>;
	Thu, 25 May 2000 09:31:07 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:23868 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S42238AbQEYQas>;
	Thu, 25 May 2000 09:30:48 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id KAA27382; Thu, 25 May 2000 10:25:56 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id KAA70872
	for linux-list;
	Thu, 25 May 2000 10:21:02 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from calypso.engr.sgi.com (calypso.engr.sgi.com [163.154.5.113])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id KAA15788;
	Thu, 25 May 2000 10:20:43 -0700 (PDT)
	mail_from (ulfc@calypso.engr.sgi.com)
Received: from localhost (localhost [127.0.0.1])
	by calypso.engr.sgi.com (Postfix) with ESMTP
	id CD6CBA78D7; Thu, 25 May 2000 10:19:40 -0700 (PDT)
Date:   Thu, 25 May 2000 10:19:40 -0700 (PDT)
From:   Ulf Carlsson <ulfc@calypso.engr.sgi.com>
To:     Harald Koerfgen <Harald.Koerfgen@home.ivm.de>
Cc:     Ralf Baechle <ralf@oss.sgi.com>,
        SGI Linux <linux@cthulhu.engr.sgi.com>,
        Linux MIPS <linux-mips@fnet.fr>, Klaus Naumann <spock@mgnet.de>
Subject: Re: CVS Update@oss.sgi.com: linux
In-Reply-To: <XFMail.000525191403.Harald.Koerfgen@home.ivm.de>
Message-ID: <Pine.LNX.4.21.0005251017410.15277-100000@calypso.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Thu, 25 May 2000, Harald Koerfgen wrote:

> 
> On 24-May-00 Ralf Baechle wrote:
> [offset.h]
> 
> > A good solution is important now that we have SMP.  Toggling CONFIG_SMP
> > affects offset.h and not for all variations of make invocations we
> > actually have the guarantee that offset.h is being rebuilt before using
> > it.
> 
> What about making offset.h to depend on $(TOPDIR)/.config?
> 
> This may cause unneccessary rebuilds of objects depending on offset.h after
> configuration changes but it forces offset.h to be rebuilt when CONFIG_SMP is
> toggled.

Would you mind removing the include/asm-$(ARCH)/offset.h from the CVS
repository, I get conflicts and stuff when I update.  I don't see why we need
to have a dummy file there.

Ulf
