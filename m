Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id KAA07455 for <linux-archive@neteng.engr.sgi.com>; Mon, 10 May 1999 10:38:10 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id KAA65509
	for linux-list;
	Mon, 10 May 1999 10:36:18 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from deliverator.sgi.com (deliverator.sgi.com [150.166.91.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id KAA67937
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 10 May 1999 10:36:16 -0700 (PDT)
	mail_from (ulfc@thepuffingroup.com)
Received: from calypso (dialup117-1-42.swipnet.se [130.244.117.42]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id KAA11387
	for <linux@cthulhu.engr.sgi.com>; Mon, 10 May 1999 10:35:43 -0700 (PDT)
	mail_from (ulfc@thepuffingroup.com)
Received: by calypso (Linux Smail3.2.0.101 #1)
	id m10gvEG-003LodC; Mon, 10 May 1999 20:56:40 +0200 (CEST)
Date: Mon, 10 May 1999 20:56:40 +0200
From: Ulf Carlsson <ulfc@thepuffingroup.com>
To: Linux SGI <linux@cthulhu.engr.sgi.com>
Subject: Indy SC bug
Message-ID: <19990510205640.A11145@thepuffingroup.com>
Mail-Followup-To: Linux SGI <linux@cthulhu.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4i
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi all,

I've found a silly bug in the R4600SC caching routines. It wiped the whole cache
at wrap arounds even if you just tried to write back two cache lines (for
example the last cache line and the first cache line).

I can't understand how this bug has lasted so long in the kernel. Well, now that
I've sorted it out, your R4600SC machine be A LOT faster.

- Ulf
