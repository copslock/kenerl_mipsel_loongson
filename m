Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Sep 2004 17:22:23 +0100 (BST)
Received: from embeddededge.com ([IPv6:::ffff:209.113.146.155]:9479 "EHLO
	penguin.netx4.com") by linux-mips.org with ESMTP
	id <S8225251AbUIPQWR>; Thu, 16 Sep 2004 17:22:17 +0100
Received: from [192.168.2.27] (x1000-57.tellink.net [63.161.110.249])
	by penguin.netx4.com (8.12.8/8.12.9) with ESMTP id i8GGIeai013187;
	Thu, 16 Sep 2004 12:18:41 -0400
In-Reply-To: <4149B71C.7020705@keathmilligan.net>
References: <4149B71C.7020705@keathmilligan.net>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <D9320BAE-07FC-11D9-BA3D-003065F9B7DC@embeddededge.com>
Content-Transfer-Encoding: 7bit
Cc: Linux MIPS <linux-mips@linux-mips.org>
From: Dan Malek <dan@embeddededge.com>
Subject: Re: PCI VGA card info
Date: Thu, 16 Sep 2004 12:24:14 -0400
To: Keath Milligan <keath@keathmilligan.net>
X-Mailer: Apple Mail (2.619)
Return-Path: <dan@embeddededge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5850
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@embeddededge.com
Precedence: bulk
X-list: linux-mips


On Sep 16, 2004, at 11:54 AM, Keath Milligan wrote:

> Does anyone have (recent) links or info on getting standard VGA cards 
> to work with Linux/MIPS?

The AMD/Alchemy folks have a Silicon Motion video adapter that will
work in that board.  I've done the framebuffer, X-Windows runs on it.
The standard video cards are nearly impossible to use in any kind of
embedded environment.  Nothing PCI is available anymore, and even
if you are able to find a way to initialize the controllers, they are 
obsolete
before you get any product ready for manufacturing.


	-- Dan
