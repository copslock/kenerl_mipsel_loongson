Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Sep 2004 17:53:33 +0100 (BST)
Received: from fw01.bwg.de ([IPv6:::ffff:213.69.156.2]:34183 "EHLO fw01.bwg.de")
	by linux-mips.org with ESMTP id <S8225254AbUIPQx3>;
	Thu, 16 Sep 2004 17:53:29 +0100
Received: by fw01.bwg.de (8.11.6p2G/8.11.6) id i8GGrSX00630
	for linux-mips@linux-mips.org; Thu, 16 Sep 2004 18:53:28 +0200 (CEST)
Received: (from localhost) by fw01.bwg.de (MSCAN) id 3/fw01.bwg.de/smtp-gw/mscan; Thu Sep 16 18:53:28 2004
From: =?us-ascii?Q?Ralf_Rosch?= <ralf.roesch@rw-gmbh.de>
To: "Dan Malek" <dan@embeddededge.com>,
	"Keath Milligan" <keath@keathmilligan.net>
Cc: "Linux MIPS" <linux-mips@linux-mips.org>
Subject: AW: PCI VGA card info
Date: Thu, 16 Sep 2004 18:53:20 +0200
Message-ID: <NHBBLBCCGMJFJIKAMKLHGEDJCCAA.ralf.roesch@rw-gmbh.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <D9320BAE-07FC-11D9-BA3D-003065F9B7DC@embeddededge.com>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Return-Path: <ralf.roesch@rw-gmbh.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5853
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf.roesch@rw-gmbh.de
Precedence: bulk
X-list: linux-mips

I have running an Millennium G450 with an TX4937 processor.
This PCI card is running frame buffer and X-Windows.
Currently I use the card with Debian (unstable).
The card I have purchased for ?99,-- and can be obtained from
several distributors, for example: www.alternate.de


  --
  Ralf

> On Sep 16, 2004, at 11:54 AM, Keath Milligan wrote:
> 
> > Does anyone have (recent) links or info on getting standard VGA cards 
> > to work with Linux/MIPS?
> 
> The AMD/Alchemy folks have a Silicon Motion video adapter that will
> work in that board.  I've done the framebuffer, X-Windows runs on it.
> The standard video cards are nearly impossible to use in any kind of
> embedded environment.  Nothing PCI is available anymore, and even
> if you are able to find a way to initialize the controllers, they are 
> obsolete
> before you get any product ready for manufacturing.
> 
> 
> 	-- Dan
> 
> 
> 
