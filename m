Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Sep 2007 19:53:00 +0100 (BST)
Received: from mail.gmx.net ([213.165.64.20]:20426 "HELO mail.gmx.net")
	by ftp.linux-mips.org with SMTP id S20021342AbXIXSwu (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 24 Sep 2007 19:52:50 +0100
Received: (qmail invoked by alias); 24 Sep 2007 18:51:44 -0000
Received: from p548B3B85.dip0.t-ipconnect.de (EHLO [192.168.120.22]) [84.139.59.133]
  by mail.gmx.net (mp058) with SMTP; 24 Sep 2007 20:51:44 +0200
X-Authenticated: #16080105
X-Provags-ID: V01U2FsdGVkX1/0zwlVH0j0g1332VRHqOHcuY+Li+dwvEz87u7pz4
	k6M6FPElAG/pN5
Message-ID: <46F8079F.40108@gmx.de>
Date:	Mon, 24 Sep 2007 20:53:19 +0200
From:	Johannes Dickgreber <tanzy@gmx.de>
User-Agent: Thunderbird 1.5.0.12 (X11/20060911)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Question:  sighand_cache is bigger than a page ( it has 4120 byte)
 on MIPS64
X-Enigmail-Version: 0.95.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Return-Path: <tanzy@gmx.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16645
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tanzy@gmx.de
Precedence: bulk
X-list: linux-mips


Hi

im running MIPS64 kernel on a SGI Octane with 1GByte.

The cache is that big, because _NSIG on Mips is set to 128.
On all other arch it is only set to 64.
Could MIPS use the lower Value ?


bye tanzy
