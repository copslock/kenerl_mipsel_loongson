Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id LAA94446 for <linux-archive@neteng.engr.sgi.com>; Fri, 4 Sep 1998 11:52:20 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id LAA16071
	for linux-list;
	Fri, 4 Sep 1998 11:51:40 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id LAA05314
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 4 Sep 1998 11:51:38 -0700 (PDT)
	mail_from (grim@zigzegv.ml.org)
Received: from ruvild.bun.falkenberg.se ([194.236.80.7]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id LAA09364
	for <linux@cthulhu.engr.sgi.com>; Fri, 4 Sep 1998 11:51:33 -0700 (PDT)
	mail_from (grim@zigzegv.ml.org)
Received: from calypso.saturn (really [130.244.184.244]) by bun.falkenberg.se
	via in.smtpd with esmtp (ident grim using rfc1413)
	id <m0zF0z5-002vFwC@ruvild.bun.falkenberg.se> (Debian Smail3.2.0.101)
	for <linux@cthulhu.engr.sgi.com>; Fri, 4 Sep 1998 20:53:23 +0200 (CEST) 
Received: from localhost (grim@localhost)
	by calypso.saturn (8.8.8/8.8.8/Debian/GNU) with SMTP id UAA07543;
	Fri, 4 Sep 1998 20:51:47 +0200
X-Authentication-Warning: calypso.saturn: grim owned process doing -bs
Date: Fri, 4 Sep 1998 20:51:47 +0200 (CEST)
From: Ulf Carlsson <grim@zigzegv.ml.org>
X-Sender: grim@calypso.saturn
To: Ralf Baechle <ralf@uni-koblenz.de>
cc: linux@cthulhu.engr.sgi.com
Subject: Bug
Message-ID: <Pine.LNX.3.96.980904204616.7535A-100000@calypso.saturn>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi,

I think you forgot a break in the middle of a switch statement, setting
order to 3 is pretty nonsense otherwise.
I compiled a new kernel with my patch, and I couldn't see any changes. The
VCED is probably handled correctly by the interrupt anyway.

patch applies to arch/mips/mm/init.c

--- init.c.org  Fri Sep  4 20:34:11 1998
+++ init.c      Fri Sep  4 20:45:40 1998
@@ -126,6 +126,7 @@
        case CPU_R4400SC:
        case CPU_R4400MC:
                order = 3;
+               break;
        default:
                order = 0;
        }

- Ulf
