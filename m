Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Sep 2002 02:55:02 +0200 (CEST)
Received: from jeeves.momenco.com ([64.169.228.99]:12555 "EHLO
	host099.momenco.com") by linux-mips.org with ESMTP
	id <S1122961AbSI1AzB>; Sat, 28 Sep 2002 02:55:01 +0200
Received: from beagle (natbox.momenco.com [64.169.228.98])
	by host099.momenco.com (8.11.6/8.11.6) with SMTP id g8S0sr617800;
	Fri, 27 Sep 2002 17:54:53 -0700
From: "Matthew Dharm" <mdharm@momenco.com>
To: "Ralf Baechle" <ralf@linux-mips.org>
Cc: "Linux-MIPS" <linux-mips@linux-mips.org>
Subject: PATCH: Momentum Computer Ocelot-G: fix memory and reset
Date: Fri, 27 Sep 2002 17:54:53 -0700
Message-ID: <NEBBLJGMNKKEEMNLHGAIKEECCJAA.mdharm@momenco.com>
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
X-archive-position: 297
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mdharm@momenco.com
Precedence: bulk
X-list: linux-mips

Ralf --

The attached patch fixes kernels on boards with 512MByte of memory.
It also allows software reboot to work.

Please apply to the 2.4 and 2.5 branches.

Matthew Dharm

--
Matthew D. Dharm                            Senior Software Designer
Momentum Computer Inc.                      1815 Aston Ave.  Suite 107
(760) 431-8663 X-115                        Carlsbad, CA 92008-7310
Momentum Works For You                      www.momenco.com
