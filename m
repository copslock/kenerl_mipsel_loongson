Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Sep 2003 19:11:21 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:33017 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8225577AbTIXSLS>;
	Wed, 24 Sep 2003 19:11:18 +0100
Received: from zeus.mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id LAA17265
	for <linux-mips@linux-mips.org>; Wed, 24 Sep 2003 11:11:16 -0700
Subject: Au1k MMC driver
From: Pete Popov <ppopov@mvista.com>
To: Linux MIPS mailing list <linux-mips@linux-mips.org>
Content-Type: text/plain
Organization: MontaVista Software
Message-Id: <1064427330.13802.32.camel@zeus.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 24 Sep 2003 11:15:30 -0700
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3302
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@mvista.com
Precedence: bulk
X-list: linux-mips


There were are few people asking for an MMC driver for the Au1k SOC, so
FYI: I uploaded Embedded Edge's new patch that added DMA support to
ftp.linux-mips.org:/pub/linux/mips/people/ppopov. The mips tree does not
have the generic mmc code, which is why I haven't applied the patch to
the tree.

Ralf, any reason why we can't integrated the mmc bits in the tree?

Pete
