Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Jul 2009 01:44:02 +0200 (CEST)
Received: from TYO201.gate.nec.co.jp ([202.32.8.193]:35477 "EHLO
	tyo201.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1493130AbZGIXny (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 10 Jul 2009 01:43:54 +0200
Received: from relay11.aps.necel.com ([10.29.19.46])
	by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id n69Nhgef012134;
	Fri, 10 Jul 2009 08:43:50 +0900 (JST)
Received: from realmbox41.aps.necel.com ([10.29.19.32] [10.29.19.32]) by relay11.aps.necel.com with ESMTP; Fri, 10 Jul 2009 08:43:50 +0900
Received: from [10.114.180.83] ([10.114.180.83] [10.114.180.83]) by mbox02.aps.necel.com with ESMTP; Fri, 10 Jul 2009 08:43:50 +0900
Message-ID: <4A5680B5.2090405@necel.com>
Date:	Fri, 10 Jul 2009 08:43:49 +0900
From:	Shinya Kuribayashi <shinya.kuribayashi@necel.com>
User-Agent: Thunderbird 2.0.0.22 (Windows/20090605)
MIME-Version: 1.0
To:	yuasa@linux-mips.org
CC:	linux-mips@linux-mips.org
Subject: What's happening with vr41xx_giu.c?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <shinya.kuribayashi@necel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23693
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: shinya.kuribayashi@necel.com
Precedence: bulk
X-list: linux-mips

Does anyone have a similar symptom?

---
skuribay@ubuntu:linux.git$ git checkout -f master
Already on 'master'
skuribay@ubuntu:linux.git$
skuribay@ubuntu:linux.git$ git log HEAD^..
commit 4eebdebd71325d0814b1c8e093fd0d1f191da9aa
Author: Kurt Martin <kurt@mips.com>
Date:   Wed Jul 8 19:22:35 2009 -0700

    MIPS: SMTC: Move cross VPE writes to after a TC is assigned to VPE.

    Signed-off-by: Chris Dearman <chris@mips.com>
    Signed-off-by: Raghu Gandham <raghu@mips.com>
    Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
skuribay@ubuntu:linux.git$
skuribay@ubuntu:linux.git$ git status
# On branch master
nothing to commit (working directory clean)
skuribay@ubuntu:linux.git$
skuribay@ubuntu:linux.git$
skuribay@ubuntu:linux.git$ make distclean
skuribay@ubuntu:linux.git$
skuribay@ubuntu:linux.git$
skuribay@ubuntu:linux.git$ git status
# On branch master
# Changed but not updated:
#   (use "git add/rm <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working directory)
#
#       deleted:    drivers/char/vr41xx_giu.c
#
no changes added to commit (use "git add" and/or "git commit -a")
skuribay@ubuntu:linux.git$

-- 
Shinya Kuribayashi
NEC Electronics
