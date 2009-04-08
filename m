Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Apr 2009 00:36:23 +0100 (BST)
Received: from mx1.rmicorp.com ([12.239.216.72]:17511 "EHLO mx1.rmicorp.com")
	by ftp.linux-mips.org with ESMTP id S20026950AbZDHXgQ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 9 Apr 2009 00:36:16 +0100
Received: from sark.razamicroelectronics.com ([10.8.0.254]) by mx1.rmicorp.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 8 Apr 2009 16:36:09 -0700
Received: from localhost.localdomain (unknown [10.8.0.44])
	by sark.razamicroelectronics.com (Postfix) with ESMTP id 97CA1D6C36;
	Sat,  4 Apr 2009 05:34:46 -0600 (CST)
From:	Kevin Hickey <khickey@rmicorp.com>
To:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: [PATCH v3 0/5] Alchemy: Basic Au1300 and DB1300 support
Date:	Wed,  8 Apr 2009 18:36:03 -0500
Message-Id: <1239233768-11927-1-git-send-email-khickey@rmicorp.com>
X-Mailer: git-send-email 1.5.4.3
In-Reply-To: <>
References: <>
X-OriginalArrivalTime: 08 Apr 2009 23:36:09.0322 (UTC) FILETIME=[CB629CA0:01C9B8A2]
Return-Path: <khickey@rmicorp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22279
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: khickey@rmicorp.com
Precedence: bulk
X-list: linux-mips

This patch series introduces support for the RMI Alchemy Au1300 series of SOCs
and the DBAu1300 (or DB1300) development board.  With this set the basic CPU
and board are supported.  I have code for several of the peripherals, including
USB, MMC, IDE, and Ethernet and will submit those patches after these have been
accepted.

Though some of the new code added here could be useful for other boards (the
DB1200 in particular), I did my best to limit this patch set to additions only.
It should not disturb any other boards.  To verify this I built and tested the
updated directory for an on a DB1200 board.  A future patch set may include
some integration of this new code into the DB1200 configuration.

This set incorporates feedback I received on v2 of these patches.

=Kevin
