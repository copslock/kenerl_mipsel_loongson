Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Aug 2002 21:46:30 +0200 (CEST)
Received: from jeeves.momenco.com ([64.169.228.99]:14 "EHLO
	host099.momenco.com") by linux-mips.org with ESMTP
	id <S1122958AbSHWTq3>; Fri, 23 Aug 2002 21:46:29 +0200
Received: from beagle (natbox.momenco.com [64.169.228.98])
	by host099.momenco.com (8.11.6/8.11.6) with SMTP id g7NJkJ604119;
	Fri, 23 Aug 2002 12:46:20 -0700
From: "Matthew Dharm" <mdharm@momenco.com>
To: "Linux-MIPS" <linux-mips@linux-mips.org>,
	"Ralf Baechle" <ralf@linux-mips.org>
Subject: PATCH: support new PROM for Ocelot boards 
Date: Fri, 23 Aug 2002 12:46:19 -0700
Message-ID: <NEBBLJGMNKKEEMNLHGAIIEIOCIAA.mdharm@momenco.com>
MIME-Version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Return-Path: <mdharm@momenco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mdharm@momenco.com
Precedence: bulk
X-list: linux-mips


The attached patch updates the startup code in the kernel to properly
interface to the new version 2 PROMs for the Ocelot boards.

They actually aren't that new.  A version of this patch was submitted
several months ago, but has yet to appear in the tree.

This patch is against the 2.4 branch.  Will someone with CVS commit
access please apply it to the tree?

Matthew Dharm

--
Matthew D. Dharm                            Senior Software Designer
Momentum Computer Inc.                      1815 Aston Ave.  Suite 107
(760) 431-8663 X-115                        Carlsbad, CA 92008-7310
Momentum Works For You                      www.momenco.com
