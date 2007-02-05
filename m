Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Feb 2007 14:26:34 +0000 (GMT)
Received: from hu-out-0506.google.com ([72.14.214.229]:2983 "EHLO
	hu-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20037688AbXBEO0b (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 5 Feb 2007 14:26:31 +0000
Received: by hu-out-0506.google.com with SMTP id 22so786004hug
        for <linux-mips@linux-mips.org>; Mon, 05 Feb 2007 06:25:30 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:to:cc:subject:date:message-id:x-mailer:from;
        b=NhIIXkekSdGkvXN9sFaAKTSyQ8Hn8yNHmBt0ii8l69PLFf4CE3D9bd4HnZt+Mhs7jdJ/95LnYmCf4QysXeoUHBLH774YPIi2yVo45YGrKqQrXllR09XUeXA3RgfAH5evchRtEo9M3879tlOmKxmhF/BjmVHqjmLwMkRat+/mhtA=
Received: by 10.49.12.4 with SMTP id p4mr2275525nfi.1170685528890;
        Mon, 05 Feb 2007 06:25:28 -0800 (PST)
Received: from spoutnik.innova-card.com ( [81.252.61.1])
        by mx.google.com with ESMTP id k23sm27230643nfc.2007.02.05.06.25.27;
        Mon, 05 Feb 2007 06:25:28 -0800 (PST)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id 28CDB23F76E; Mon,  5 Feb 2007 15:24:29 +0100 (CET)
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org
Subject: [PATCH 0/10] Clean up signal code [take #3]
Date:	Mon,  5 Feb 2007 15:24:18 +0100
Message-Id: <11706854683935-git-send-email-fbuihuu@gmail.com>
X-Mailer: git-send-email 1.4.4.3.ge6d4
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13928
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Hi Ralf,

Here is the third version of this patchset.
I ran (on a 32-bits kernel _only_) all LTP signal testcases and
they all passed. I haven't time to look at what these tests exactly
do though. 

Changes from take #2:
---------------------
- Do not use save_static_function() anymore
- do not inline handle_signal()

Changes from take #1:
---------------------
- Fix ICACHE_REFILLS_WORKAROUND_WAR usages
- Do not save/restore cp0_status register anymore
- Check impact on performances

Please, consider.

		Franck

---
 arch/mips/kernel/signal-common.h |  194 +++++-----------------
 arch/mips/kernel/signal.c        |  231 +++++++++++++++++++-------
 arch/mips/kernel/signal32.c      |  341 +++++++++++++++-----------------------
 arch/mips/kernel/signal_n32.c    |   34 ++--
 4 files changed, 361 insertions(+), 439 deletions(-)
