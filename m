Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Dec 2005 23:09:31 +0000 (GMT)
Received: from mail.alphastar.de ([194.59.236.179]:36370 "EHLO
	mail.alphastar.de") by ftp.linux-mips.org with ESMTP
	id S8133455AbVLWXJL (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 23 Dec 2005 23:09:11 +0000
Received: by mail.alphastar.de with MERCUR Mailserver (v4.02.28 MTIxLTIxODAtNjY2OA==) for <linux-mips@linux-mips.org>; Sat, 24 Dec 2005 00:07:14 +0100
Received: from Indigo2.Peter (Indigo2.Peter [192.168.1.28])
	by SNaIlmail.Peter (8.12.6/8.12.6/Sendmail/Linux 2.0.32) with ESMTP id jBNMC8Im000156
	for <linux-mips@linux-mips.org>; Fri, 23 Dec 2005 23:12:09 +0100
Received: from Indigo2.Peter (localhost [127.0.0.1])
	by Indigo2.Peter (8.12.6/8.12.6/Sendmail/Linux 2.6.11-rc3-ip28) with ESMTP id jBNLgHZn000393
	for <linux-mips@linux-mips.org>; Fri, 23 Dec 2005 22:42:17 +0100
Received: from localhost (pf@localhost)
	by Indigo2.Peter (8.12.6/8.12.6/Submit) with ESMTP id jBNLgHkC000390
	for <linux-mips@linux-mips.org>; Fri, 23 Dec 2005 22:42:17 +0100
Date:	Fri, 23 Dec 2005 22:42:17 +0100 (CET)
From:	peter fuerst <pf@net.alphadv.de>
To:	linux-mips@linux-mips.org
Subject: IP28 patches
In-Reply-To: <Pine.LNX.4.21.0510172008340.2374-100000@Opal.Peter>
Message-ID: <Pine.LNX.4.58.0512232231090.387@Indigo2.Peter>
References: <Pine.LNX.4.21.0510172008340.2374-100000@Opal.Peter>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Reply-To: pf@net.alphadv.de
Return-Path: <pf@net.alphadv.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9735
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pf@net.alphadv.de
Precedence: bulk
X-list: linux-mips



Hi,

after some time of trial and error there's an updated version of
the Impact kernel-driver for IP28.  Changes in DMA-setup allow a
reliable Xserver startup now.  (For at least two weeks of daily
use X didn't hang in the "dmabusy"-loop anymore).
These kernel-patches can be found in the usual place.

kind regards

pf
