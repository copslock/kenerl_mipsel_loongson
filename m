Received:  by oss.sgi.com id <S305165AbQEPRlZ>;
	Tue, 16 May 2000 17:41:25 +0000
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:43129 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305154AbQEPRlD>; Tue, 16 May 2000 17:41:03 +0000
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id KAA02255; Tue, 16 May 2000 10:45:33 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id KAA77835; Tue, 16 May 2000 10:40:32 -0700 (PDT)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id KAA00955
	for linux-list;
	Tue, 16 May 2000 10:33:05 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from virgil.engr.sgi.com (virgil.engr.sgi.com [163.154.5.20])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id KAA34634
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 16 May 2000 10:33:03 -0700 (PDT)
	mail_from (bigham@cthulhu.engr.sgi.com)
Received: from engr.sgi.com (localhost [127.0.0.1]) by virgil.engr.sgi.com (980427.SGI.8.8.8/960327.SGI.AUTOCF) via ESMTP id KAA91685 for <linux@relay.engr.sgi.com>; Tue, 16 May 2000 10:33:02 -0700 (PDT)
Message-ID: <3921864E.95ECC46B@engr.sgi.com>
Date:   Tue, 16 May 2000 10:33:02 -0700
From:   Nancy Bigham <bigham@cthulhu.engr.sgi.com>
Organization: Linux
X-Mailer: Mozilla 4.7C-SGI [en] (X11; I; IRIX 6.5 IP22)
X-Accept-Language: en
MIME-Version: 1.0
To:     linux@cthulhu.engr.sgi.com
Subject: [Fwd: BOUNCE linux@relay.engr.sgi.com:    Non-member submission from 
 [Jun Sun <jsun@mvista.com>]]
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

resending bounced mail.

-------- Original Message --------
Subject: BOUNCE linux@relay.engr.sgi.com:    Non-member submission from
[Jun Sun <jsun@mvista.com>]
Date: Tue, 16 May 2000 10:13:23 -0700 (PDT)
From: owner-linux@cthulhu
To: owner-linux@cthulhu



Ralf Baechle wrote:
> 
> On Mon, May 15, 2000 at 06:07:49PM -0700, Jun Sun wrote:
> 
> > I found
> > ftp://oss.sgi.com/pub/linux/mips/src/kernel/v2.3/linux-19991209.tar.gz,
> > but that is version 2.3.21.  Have all the patches been taken into the
> > latest standard linux release?  Just to make sure ...
> 
> We only occasionally generate snapshots.  If you want a current source
> tree then please see the MIPS FAQ at http://oss.sgi.com/mips/ for how to
> use anonymous CVS.  CVS is currently at version 2.3.99-pre8.
> 
>   Ralf

I see.

Is the intention to merge MIPS work back to the standard Linux tree?  If
yes, do we have an idea when?  If no, I assume the MIPS branch has to
keep getting forward merges from the standard tree.  That will be a
pain.

Jun
