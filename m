Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Jul 2006 17:37:35 +0100 (BST)
Received: from s2.ukfsn.org ([217.158.120.143]:34265 "EHLO mail.ukfsn.org")
	by ftp.linux-mips.org with ESMTP id S3561366AbWGLQh0 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 12 Jul 2006 17:37:26 +0100
Received: from [10.0.1.63] (84-45-236-142.no-dns-yet.enta.net [84.45.236.142])
	by mail.ukfsn.org (Postfix) with ESMTP id C963CE6DC9
	for <linux-mips@linux-mips.org>; Wed, 12 Jul 2006 17:34:46 +0100 (BST)
From:	David Goodenough <david.goodenough@btconnect.com>
To:	linux-mips@linux-mips.org
Subject: RouterBoard 532 NAND support
Date:	Wed, 12 Jul 2006 17:37:18 +0100
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607121737.18866.david.goodenough@btconnect.com>
Return-Path: <david.goodenough@btconnect.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11977
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.goodenough@btconnect.com
Precedence: bulk
X-list: linux-mips

Does anyone have a patch for 2.6.17 to add NAND support for a Routerboard
532?  I have the bits that add Yaffs, and I have some code that was a patch
to 2.6.17-rc5 but I can not get it to work on 2.6.17 (it compiles but it 
seems to be looking in the wrong place for the NAND as it gets back 0xff
as the manufacturer and device id file in drivers/mtd/nand/nand_base.c in
the routine nand_scan.  

Any help gratefully received

David
