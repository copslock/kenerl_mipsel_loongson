Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Aug 2004 23:16:12 +0100 (BST)
Received: from gw01.mail.saunalahti.fi ([IPv6:::ffff:195.197.172.115]:39578
	"EHLO gw01.mail.saunalahti.fi") by linux-mips.org with ESMTP
	id <S8224986AbUHRWQG>; Wed, 18 Aug 2004 23:16:06 +0100
Received: from tori.tal.org (tori.tal.org [195.16.220.82])
	by gw01.mail.saunalahti.fi (Postfix) with ESMTP id 4DD7E4CB0E
	for <linux-mips@linux-mips.org>; Thu, 19 Aug 2004 01:16:04 +0300 (EEST)
Date: Thu, 19 Aug 2004 01:18:28 +0300 (EEST)
From: Kaj-Michael Lang <milang@tal.org>
To: linux-mips@linux-mips.org
Subject: Patch to fix O2 fb mmap + misc other fixes
Message-ID: <Pine.LNX.4.58.0408190115080.16742@tori.tal.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <milang@tal.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5684
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: milang@tal.org
Precedence: bulk
X-list: linux-mips

I found the problem to why mmap of the O2 fb didn't work...

Patch with mmap fix, fbset depth changing fix and sysfs support can be
found here: http://home.tal.org/~milang/o2/patches/

It might need some cleaning and such but it works for me.
Enjoy..

-- 
Kaj-Michael Lang, Turku, Finland
milang@tal.org http://www.tal.org
