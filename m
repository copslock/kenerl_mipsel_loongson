Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Sep 2002 23:15:09 +0200 (CEST)
Received: from jeeves.momenco.com ([64.169.228.99]:4881 "EHLO
	host099.momenco.com") by linux-mips.org with ESMTP
	id <S1122987AbSIPVPJ>; Mon, 16 Sep 2002 23:15:09 +0200
Received: from beagle (natbox.momenco.com [64.169.228.98])
	by host099.momenco.com (8.11.6/8.11.6) with SMTP id g8GLF0627314
	for <linux-mips@linux-mips.org>; Mon, 16 Sep 2002 14:15:01 -0700
From: "Matthew Dharm" <mdharm@momenco.com>
To: "Linux-MIPS" <linux-mips@linux-mips.org>
Subject: fs problem between 2.4.19-rc1 and tip?
Date: Mon, 16 Sep 2002 14:15:00 -0700
Message-ID: <NEBBLJGMNKKEEMNLHGAIKEPOCIAA.mdharm@momenco.com>
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
X-archive-position: 193
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mdharm@momenco.com
Precedence: bulk
X-list: linux-mips

Is anyone else seeing a problem using SCSI disks (ext2 format) that
was introduced between 2.4.19-rc1 and the tip revision?

Upon booting the 2.4.20-pre6 (tip of CVS), the root filesystem throws
an error about an "unaligned directory entry" and then cannot find
init.

2.4.19-rc1 with the _same_ hardware configuration works just fine.

Is it just me, or this this something general?

Matt

--
Matthew D. Dharm                            Senior Software Designer
Momentum Computer Inc.                      1815 Aston Ave.  Suite 107
(760) 431-8663 X-115                        Carlsbad, CA 92008-7310
Momentum Works For You                      www.momenco.com
