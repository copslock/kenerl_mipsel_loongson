Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 May 2003 22:51:26 +0100 (BST)
Received: from ws1.transfinity.com ([IPv6:::ffff:63.99.219.193]:15014 "EHLO
	ws1.transfinity.com") by linux-mips.org with ESMTP
	id <S8225205AbTEUVuy>; Wed, 21 May 2003 22:50:54 +0100
Received: from transfinity.com (adsl-216-61-82-33.dsl.rcsntx.swbell.net [216.61.82.33])
	by ws1.transfinity.com (Postfix) with ESMTP id 197F0681A1
	for <linux-mips@linux-mips.org>; Wed, 21 May 2003 16:50:53 -0500 (CDT)
Message-ID: <3ECBF4BC.24E5FFE6@transfinity.com>
Date: Wed, 21 May 2003 16:50:52 -0500
From: Bob Dempsey <bdempsey@transfinity.com>
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.4.18-27.7.x i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: Cobalt RAQ 2 woes
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <bdempsey@transfinity.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2429
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bdempsey@transfinity.com
Precedence: bulk
X-list: linux-mips

Okay, I've been trying on and off for weeks now to get ANY 2.4 kernel to run on my Cobalt RAQ 2 recently aquired on EBay for $250. It runs Cobalt's 2.0 kernel just fine, and I've managed to upgrade gcc and binutils to 2.95.4 and 2.13.2.1 respectively. I can build the 2.5.47 kernel out of cvs cleanly, but when it boots I get swap errors like:

swap_dup: Bad swap file entry 4081004e

over and over and over.

The latest 2.4 kernel source from cvs also compiles cleanly, but just hangs.

Both of these kernels die in the execve() call at the end of init/main.c.

My debugging has lead me to believe there is some problem with the tlb, but I could certainly be wrong. Any suggestions?

--
------------------------------------------------------------------------
Bob Dempsey                                     972-866-9199x104(V)
Vice President R&D                              972-866-0179(F)
Transfinity Corp                                bdempsey@transfinity.com
4851 LBJ Freeway                                Dallas, TX 75244
