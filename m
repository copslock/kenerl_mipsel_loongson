Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Sep 2004 01:15:39 +0100 (BST)
Received: from mail.alphastar.de ([IPv6:::ffff:194.59.236.179]:58126 "EHLO
	mail.alphastar.de") by linux-mips.org with ESMTP
	id <S8225222AbUIBAPf>; Thu, 2 Sep 2004 01:15:35 +0100
Received: from SNaIlmail.Peter (212.144.142.117)
          by mail.alphastar.de with MERCUR Mailserver (v4.02.28 MTIxLTIxODAtNjY2OA==)
          for <linux-mips@linux-mips.org>; Thu, 2 Sep 2004 02:14:10 +0200
Received: from Opal.Peter (root@Opal.Peter [192.168.1.1])
	by SNaIlmail.Peter (8.12.6/8.12.6/Sendmail/Linux 2.0.32) with ESMTP id i8209nWf000939
	for <linux-mips@linux-mips.org>; Thu, 2 Sep 2004 02:09:50 +0200
Received: from indigo2.Peter (Indigo2.Peter [192.168.1.28])
	by Opal.Peter (8.9.3/8.9.3/Sendmail/Linux 2.2.5-15) with ESMTP id CAA05841
	for <linux-mips@linux-mips.org>; Thu, 2 Sep 2004 02:09:50 +0200
Received: from localhost (pf@localhost)
	by indigo2.Peter (8.8.7/8.8.7/Linux 2.4.22 IP28) with SMTP id EAA14051
	for <linux-mips@linux-mips.org>; Thu, 2 Sep 2004 04:11:25 +0200
Date: Thu, 2 Sep 2004 04:11:25 +0200 (CEST)
From: Peter Fuerst <pf@net.alphadv.de>
Reply-To: Peter Fuerst <pf@net.alphadv.de>
To: linux-mips@linux-mips.org
Subject: gcc 2.95 patch for IP28
Message-ID: <Pine.LNX.3.96.1040902040502.14047A-100000@indigo2.Peter>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <pf@net.alphadv.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5766
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pf@net.alphadv.de
Precedence: bulk
X-list: linux-mips



Hello !

A patch to gcc 2.95.4 to make it insert the necessary cache barriers
in (kernel-)code for SGI Indigo2 R10k (IP28) is available at
http://home.alphastar.de/fuerst/download.html


with kind regards...
