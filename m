Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 May 2003 23:09:10 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:7418 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8225196AbTETWJI>;
	Tue, 20 May 2003 23:09:08 +0100
Received: from zeus.mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id PAA29645
	for <linux-mips@linux-mips.org>; Tue, 20 May 2003 15:09:05 -0700
Subject: Au1x zboot
From: Pete Popov <ppopov@mvista.com>
To: Linux MIPS mailing list <linux-mips@linux-mips.org>
Content-Type: text/plain
Organization: MontaVista Software
Message-Id: <1053468620.28562.144.camel@zeus.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 20 May 2003 15:10:20 -0700
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2421
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@mvista.com
Precedence: bulk
X-list: linux-mips


I know someone was recently asking for this.  I put a zImage patch on my
directory (/pub/linux/mips/people/ppopov) called zboot_patch for the
Alchemy boards. The code was ported from PPC sometime ago so it's pretty
generic and I think it's pretty easy to add support for other boards.
The bits were just updated by Embedded Edge so I uploaded the patch and
also sent it to Ralf.  There are two new targets, one for a zImage you
load to RAM and run; the other for an image you store in flash.  The
README has some details and example uses.

Pete
