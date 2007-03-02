Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Mar 2007 21:10:02 +0000 (GMT)
Received: from smtp-ext.int-evry.fr ([157.159.11.17]:63650 "EHLO
	smtp-ext.int-evry.fr") by ftp.linux-mips.org with ESMTP
	id S20039604AbXCBVJ5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 2 Mar 2007 21:09:57 +0000
Received: from mini.int.alphacore.net (florian.maisel.int-evry.fr [157.159.41.36])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp-ext.int-evry.fr (Postfix) with ESMTP id 1F6848D1691
	for <linux-mips@linux-mips.org>; Fri,  2 Mar 2007 22:09:04 +0100 (CET)
From:	Florian Fainelli <florian.fainelli@int-evry.fr>
To:	linux-mips@linux-mips.org
Subject: [PATCH 0/7] MTX-1 patches
Date:	Fri, 2 Mar 2007 22:07:20 +0100
User-Agent: KMail/1.9.6
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200703022207.20580.florian.fainelli@int-evry.fr>
Return-Path: <florian.fainelli@int-evry.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14311
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian.fainelli@int-evry.fr
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch suite is used in the OpenWrt au1000-2.6 port, and working 
flawlessly on MTX-1 boards for months now. Most patches are not from me, but 
forward ported from the openembedded repository.

Patches are based on 2.6.19.2 and should apply fine with 2.6.20.
-- 
Regards, Florian
