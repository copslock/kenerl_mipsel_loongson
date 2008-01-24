Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Jan 2008 16:53:45 +0000 (GMT)
Received: from smtp06.mtu.ru ([62.5.255.53]:47354 "EHLO smtp06.mtu.ru")
	by ftp.linux-mips.org with ESMTP id S20037133AbYAXQxG (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 24 Jan 2008 16:53:06 +0000
Received: from smtp06.mtu.ru (localhost [127.0.0.1])
	by smtp06.mtu.ru (Postfix) with ESMTP id DC1A68EF600;
	Thu, 24 Jan 2008 19:53:00 +0300 (MSK)
Received: from localhost.localdomain (ppp85-140-77-152.pppoe.mtu-net.ru [85.140.77.152])
	by smtp06.mtu.ru (Postfix) with ESMTP id 550118EEE9E;
	Thu, 24 Jan 2008 19:53:00 +0300 (MSK)
From:	Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
To:	ralf@linux-mips.org, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 00/17] [MIPS] Malta: massive code cleanup
Date:	Thu, 24 Jan 2008 19:52:40 +0300
Message-Id: <1201193577-4261-1-git-send-email-dmitri.vorobiev@gmail.com>
X-Mailer: git-send-email 1.5.3.6
X-DCC-STREAM-Metrics: smtp06.mtu.ru 10001; Body=0 Fuz1=0 Fuz2=0
Return-Path: <dmitri.vorobiev@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18125
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@gmail.com
Precedence: bulk
X-list: linux-mips

Ralf,

This is the Malta cleanup, which I was talking about some time ago.

The patches should be fairly obvious. They make no functional
changes.

Build tests passed successfully when I used the default configs
for Atlas, Malta and SEAD.

Just in case, I also ran boot tests, which passed successfully with
the default Malta config and a Qemu-emulated Malta board in both BE
and LE modes.

The net effect is that the number of errors, warnings, and checks
reported by checkpatch.pl changes as follows:

Before:

--------------------------------------------
              | errors | warnings | checks 
--------------------------------------------
malta_int.c   |  47    |    20    |    1   
--------------------------------------------
malta_setup.c |  3     |    21    |    3
--------------------------------------------
malta_smtc.c  |  2     |    0     |    0
--------------------------------------------

After:

--------------------------------------------
              | errors | warnings | checks 
--------------------------------------------
malta_int.c   |  0     |    0     |    0   
--------------------------------------------
malta_setup.c |  0     |    0     |    0
--------------------------------------------
malta_smtc.c  |  0     |    0     |    0
--------------------------------------------

The last patch in the series removes a very obsolete and misleading
document from Documentation/mips.

Please consider.

Thanks,

Dmitri
