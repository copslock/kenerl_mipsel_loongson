Received:  by oss.sgi.com id <S42240AbQEYRMr>;
	Thu, 25 May 2000 10:12:47 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:44552 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S42238AbQEYRMV>; Thu, 25 May 2000 10:12:21 -0700
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id LAA02185; Thu, 25 May 2000 11:16:31 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id LAA13519; Thu, 25 May 2000 11:11:20 -0700 (PDT)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id LAA42217
	for linux-list;
	Thu, 25 May 2000 11:04:13 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from calypso.engr.sgi.com (calypso.engr.sgi.com [163.154.5.113])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id LAA21009;
	Thu, 25 May 2000 11:03:55 -0700 (PDT)
	mail_from (ulfc@calypso.engr.sgi.com)
Received: from localhost (localhost [127.0.0.1])
	by calypso.engr.sgi.com (Postfix) with ESMTP
	id 45B27A78D7; Thu, 25 May 2000 11:02:52 -0700 (PDT)
Date:   Thu, 25 May 2000 11:02:52 -0700 (PDT)
From:   Ulf Carlsson <ulfc@calypso.engr.sgi.com>
To:     Ralf Baechle <ralf@oss.sgi.com>
Cc:     Harald Koerfgen <Harald.Koerfgen@home.ivm.de>,
        SGI Linux <linux@cthulhu.engr.sgi.com>,
        Linux MIPS <linux-mips@fnet.fr>, Klaus Naumann <spock@mgnet.de>
Subject: Re: CVS Update@oss.sgi.com: linux
In-Reply-To: <20000525200021.A1226@uni-koblenz.de>
Message-ID: <Pine.LNX.4.21.0005251100380.15277-100000@calypso.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

> > Would you mind removing the include/asm-$(ARCH)/offset.h from the CVS
> > repository, I get conflicts and stuff when I update.  I don't see why we
> > need to have a dummy file there.
> 
> Conceptually I don't like that either.

I think my solution that I submitted yesterday was pretty good.  If add a rule
that removes include/asm-$(ARCH)/offset.h when you make clean we will be just
fine.  You'll have to make clean when you toggle between SMP and UP, but I
think we can live with that.

Ulf
