Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Sep 2002 23:35:46 +0200 (CEST)
Received: from jeeves.momenco.com ([64.169.228.99]:7697 "EHLO
	host099.momenco.com") by linux-mips.org with ESMTP
	id <S1122987AbSIPVfq>; Mon, 16 Sep 2002 23:35:46 +0200
Received: from beagle (natbox.momenco.com [64.169.228.98])
	by host099.momenco.com (8.11.6/8.11.6) with SMTP id g8GLZd627435
	for <linux-mips@linux-mips.org>; Mon, 16 Sep 2002 14:35:39 -0700
From: "Matthew Dharm" <mdharm@momenco.com>
To: "Linux-MIPS" <linux-mips@linux-mips.org>
Subject: bug with 512MB of RAM?
Date: Mon, 16 Sep 2002 14:35:39 -0700
Message-ID: <NEBBLJGMNKKEEMNLHGAIAEPPCIAA.mdharm@momenco.com>
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
X-archive-position: 194
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mdharm@momenco.com
Precedence: bulk
X-list: linux-mips

A long time ago, there was a bug somewhere that only affected boards
with 512MB of memory with RM7000 processors.  Apparently, there were
problems in the cache-managment code causing a problem working with
memory near the end of kseg0.  I don't recall all the details -- by
the time I got to looking at it the first time, someone already had a
fix.

I was told this was fixed... but I'm seeing some symptoms that this
was not fixed.  Does anyone actually recall if this was fixed or not?
If it was, I need to look elsewhere.  But, if it wasn't actually
fixed....

Matt

--
Matthew D. Dharm                            Senior Software Designer
Momentum Computer Inc.                      1815 Aston Ave.  Suite 107
(760) 431-8663 X-115                        Carlsbad, CA 92008-7310
Momentum Works For You                      www.momenco.com
