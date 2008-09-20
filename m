Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 20 Sep 2008 08:35:49 +0100 (BST)
Received: from smtp1.dnsmadeeasy.com ([205.234.170.134]:29580 "EHLO
	smtp1.dnsmadeeasy.com") by ftp.linux-mips.org with ESMTP
	id S30623841AbYITHeI (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 20 Sep 2008 08:34:08 +0100
Received: from smtp1.dnsmadeeasy.com (localhost [127.0.0.1])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP id 5C73B3211BD;
	Sat, 20 Sep 2008 07:33:59 +0000 (UTC)
X-Authenticated-Name: js.dnsmadeeasy
X-Transit-System: In case of SPAM please contact abuse@dnsmadeeasy.com
Received: from avtrex.com (unknown [173.8.135.205])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP;
	Sat, 20 Sep 2008 07:33:59 +0000 (UTC)
Received: from silver64.hq2.avtrex.com ([192.168.7.224]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Sat, 20 Sep 2008 00:33:54 -0700
Message-ID: <48D4A761.7020706@avtrex.com>
Date:	Sat, 20 Sep 2008 00:33:53 -0700
From:	David Daney <ddaney@avtrex.com>
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: Move headfiles to new location below arch/mips/include
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Sep 2008 07:33:54.0504 (UTC) FILETIME=[3C228480:01C91AF3]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20572
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

Ralf,

This patch on linux-queue:

commit 77f312878b8b76e96aa0e2f381582e9ea8239e71
Author: Ralf Baechle <ralf@linux-mips.org>
Date:   Tue Sep 16 19:48:51 2008 +0200

    MIPS: Move headfiles to new location below arch/mips/include

    Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

Seems to be a nop.  It doesn't look like any files got moved.

David Daney
