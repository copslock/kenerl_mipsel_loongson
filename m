Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Sep 2002 03:59:08 +0200 (CEST)
Received: from jeeves.momenco.com ([64.169.228.99]:54286 "EHLO
	host099.momenco.com") by linux-mips.org with ESMTP
	id <S1122961AbSIMB7I>; Fri, 13 Sep 2002 03:59:08 +0200
Received: from beagle (natbox.momenco.com [64.169.228.98])
	by host099.momenco.com (8.11.6/8.11.6) with SMTP id g8D1wv628745
	for <linux-mips@linux-mips.org>; Thu, 12 Sep 2002 18:58:58 -0700
From: "Matthew Dharm" <mdharm@momenco.com>
To: "Linux-MIPS" <linux-mips@linux-mips.org>
Subject: When to #ifdef on CPUs?
Date: Thu, 12 Sep 2002 18:58:57 -0700
Message-ID: <NEBBLJGMNKKEEMNLHGAIMEPBCIAA.mdharm@momenco.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Return-Path: <mdharm@momenco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 164
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mdharm@momenco.com
Precedence: bulk
X-list: linux-mips

I'm basically done with my task of porting linux to our SR71000-based
board.  I'm getting ready to start feeding patches to Ralf, and
something occured to me....

Sometimes, in some places, we use CONFIG_ options to select the
apropriate CPU.  Other places, we probe for the CPU based on the PRID
register.

In some places, the reason for the choice is clear -- it's just much
easier to select the cache library based on a CONFIG_ option in a
Makefile than trying to do run-time assignment of many function
pointers.

However, is some places, the choice is not clear.  In cpu-probe.c, for
example, several of the CPU identification routines are wrapped in
#ifdef's -- odd, since the wrong 'case' of the switch statements
should never get executed, even if compiled in....

So, what's the rule here?  When do I used #ifdef and when do I just
let the PRID stuff work it's magic?

I mean, heck... it might be nice to put a check to see if the detected
CPU matches what the kernel was compiled for...

Matt

--
Matthew D. Dharm                            Senior Software Designer
Momentum Computer Inc.                      1815 Aston Ave.  Suite 107
(760) 431-8663 X-115                        Carlsbad, CA 92008-7310
Momentum Works For You                      www.momenco.com
