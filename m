Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Jul 2003 14:10:57 +0100 (BST)
Received: from [IPv6:::ffff:199.3.224.121] ([IPv6:::ffff:199.3.224.121]:57099
	"EHLO mailsweeper.scc-inc.com") by linux-mips.org with ESMTP
	id <S8225072AbTGPNKy>; Wed, 16 Jul 2003 14:10:54 +0100
Received: from Mailserver.scc-inc.com (mailserver.scc-inc.com) by mailsweeper.scc-inc.com
 (Content Technologies SMTPRS 4.3.6) with ESMTP id <T6376c820320a0101456f0@mailsweeper.scc-inc.com> for <linux-mips@linux-mips.org>;
 Wed, 16 Jul 2003 09:09:49 -0400
Received: by Mailserver.scc-inc.com with Internet Mail Service (5.5.2653.19)
	id <N9DWDHMA>; Wed, 16 Jul 2003 09:11:23 -0400
Message-ID: <4019CBE63D5A174F8F55FE25BC82D04102B46815@Mailserver.scc-inc.com>
From: Chris Fouts <ChrisF@SCC-INC.com>
To: "'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Subject: Co-Proc. 0
Date: Wed, 16 Jul 2003 09:11:22 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Return-Path: <ChrisF@scc-inc.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2801
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ChrisF@SCC-INC.com
Precedence: bulk
X-list: linux-mips

What options do I use for the compiler to recoginze the C0 specific
op-codes,
e.g., mfc0, mtc0, etc? I tried -mips1, -mips2, -mips3 and arch=RM7000 to no
avail.

-chris
