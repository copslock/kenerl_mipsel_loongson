Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Jun 2005 17:07:08 +0100 (BST)
Received: from mail.alphastar.de ([IPv6:::ffff:194.59.236.179]:41999 "EHLO
	mail.alphastar.de") by linux-mips.org with ESMTP
	id <S8225233AbVFQQGt>; Fri, 17 Jun 2005 17:06:49 +0100
Received: from Snailmail (217.249.197.192)
          by mail.alphastar.de with MERCUR Mailserver (v4.02.28 MTIxLTIxODAtNjY2OA==)
          for <linux-mips@linux-mips.org>; Fri, 17 Jun 2005 18:04:22 +0200
Received: from Opal.Peter (pf@Opal.Peter [192.168.1.1])
	by SNaIlmail.Peter (8.12.6/8.12.6/Sendmail/Linux 2.0.32) with ESMTP id j5HG609J000549
	for <linux-mips@linux-mips.org>; Fri, 17 Jun 2005 18:06:01 +0200
Received: from localhost (pf@localhost)
	by Opal.Peter (8.9.3/8.9.3/Sendmail/Linux 2.2.5-15) with ESMTP id SAA00798
	for <linux-mips@linux-mips.org>; Fri, 17 Jun 2005 18:05:47 +0200
Date:	Fri, 17 Jun 2005 18:05:47 +0200 (CEST)
From:	peter fuerst <pf@net.alphadv.de>
To:	linux-mips@linux-mips.org
Subject: Updated Indigo2 IP28 patches.
Message-ID: <Pine.LNX.4.21.0506171746001.786-100000@Opal.Peter>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Reply-To: pf@net.alphadv.de
Return-Path: <pf@net.alphadv.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8103
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pf@net.alphadv.de
Precedence: bulk
X-list: linux-mips



Hello !

There are updated patches for SGI Indigo2 IP28 available at
"http://home.alphastar.de/fuerst/download.html":

1) An extended bus error handler, which allows to avoid the too many
   cache-barriers (introduced with the last compiler-patch) before
   critical load instructions.

2) Stanislaw Skowronek's ImpactSR-graphics driver (many thanks...) could
   be adapted to IP28 Impact-graphics.

kind regards

pf
