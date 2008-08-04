Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Aug 2008 21:17:28 +0100 (BST)
Received: from mx1.razamicroelectronics.com ([63.111.213.197]:59311 "EHLO
	hq-ex-mb01.razamicroelectronics.com") by ftp.linux-mips.org with ESMTP
	id S20044521AbYHDURZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 4 Aug 2008 21:17:25 +0100
Received: from sark.razamicroelectronics.com ([10.8.0.254]) by hq-ex-mb01.razamicroelectronics.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 4 Aug 2008 13:17:16 -0700
Received: from localhost.localdomain (unknown [10.8.0.25])
	by sark.razamicroelectronics.com (Postfix) with ESMTP id 0A3366DA536;
	Mon,  4 Aug 2008 15:09:38 -0500 (CDT)
From:	Kevin Hickey <khickey@rmicorp.com>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH 0/1] [MIPS] Add USB Device (OTG) support for Au1200 and Au1250
Date:	Mon,  4 Aug 2008 15:17:31 -0500
Message-Id: <1217881052-18797-1-git-send-email-khickey@rmicorp.com>
X-Mailer: git-send-email 1.5.4.3
In-Reply-To: <>
References: <>
X-OriginalArrivalTime: 04 Aug 2008 20:17:17.0023 (UTC) FILETIME=[172606F0:01C8F66F]
Return-Path: <khickey@rmicorp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20090
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: khickey@rmicorp.com
Precedence: bulk
X-list: linux-mips


The following is a patch adding preliminary device-only OTG support for the
Au1200 and Au1250.  It is made largely of code that I inherited that was never
published.  This is the largest patch I have submitted thus far, and the first
one including a new driver.  I welcome comments on anything in the code, as
well as the format and presentation of the patch.  I will happily rev this to
meet the community's standards.  Thanks.

Kevin Hickey
Alchemy Solutions
RMI Corporation
P:  512.691.8044
