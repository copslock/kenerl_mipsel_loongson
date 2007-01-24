Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Jan 2007 14:11:49 +0000 (GMT)
Received: from hu-out-0506.google.com ([72.14.214.238]:26235 "EHLO
	hu-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20048454AbXAXOKt (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 24 Jan 2007 14:10:49 +0000
Received: by hu-out-0506.google.com with SMTP id 22so152619hug
        for <linux-mips@linux-mips.org>; Wed, 24 Jan 2007 06:09:49 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:to:cc:subject:date:message-id:x-mailer:from;
        b=Xk3pM9HxEwp6EUcjHaksiCbpuyMkrhxi7f8tEtHkAs++e/qmtM3DA553jMg0gfChzmwEozSjxzMcxtFcZPM62l5HBiWVi43Bjoqm7BDahYw5jMomDsOFXepg3ZYhv4Vluki6Idi97bELNbhF7pduYQjfIft2ywzVCplWTG3nhTc=
Received: by 10.49.107.8 with SMTP id j8mr2943137nfm.1169647788670;
        Wed, 24 Jan 2007 06:09:48 -0800 (PST)
Received: from spoutnik.innova-card.com ( [81.252.61.1])
        by mx.google.com with ESMTP id k23sm6499299nfc.2007.01.24.06.09.47;
        Wed, 24 Jan 2007 06:09:48 -0800 (PST)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id 1CD6423F76A; Wed, 24 Jan 2007 15:12:11 +0100 (CET)
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org
Subject: [PATCH 0/8] Clean up signal code [take #2]
Date:	Wed, 24 Jan 2007 15:12:03 +0100
Message-Id: <11696479312279-git-send-email-fbuihuu@gmail.com>
X-Mailer: git-send-email 1.4.4.3.ge6d4
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13795
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Hi Ralf,

Here is the second version of this patchset.

Changes from take #1:
---------------------
- Fix ICACHE_REFILLS_WORKAROUND_WAR usages
- Do not save/restore cp0_status register anymore
- Check impact on performances

Please, consider.

		Franck
---
 arch/mips/kernel/signal-common.h |  194 +++++------------------
 arch/mips/kernel/signal.c        |  213 +++++++++++++++++++------
 arch/mips/kernel/signal32.c      |  325 +++++++++++++++-----------------------
 arch/mips/kernel/signal_n32.c    |   26 ++--
 4 files changed, 350 insertions(+), 408 deletions(-)
