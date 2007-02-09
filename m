Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Feb 2007 15:11:06 +0000 (GMT)
Received: from qb-out-0506.google.com ([72.14.204.238]:22154 "EHLO
	qb-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20038792AbXBIPJh (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 9 Feb 2007 15:09:37 +0000
Received: by qb-out-0506.google.com with SMTP id e12so191991qba
        for <linux-mips@linux-mips.org>; Fri, 09 Feb 2007 07:08:36 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:to:cc:subject:date:message-id:x-mailer:from;
        b=kKHqRGUbfzAc51QRUk+oeVStFC+566YUng/jgiOW1Bn4kHcGW0wRok2Eofje6NLkGyOFR16CeWo0J6GuYR0Mqd9r4cFOVjDcQLRb+QWOV+/0FBp4HdkFlav9iV4jzQke0XZyOo2JOShwmOILVOW4BqPVSfmAAAR1wL26GvOefas=
Received: by 10.65.154.2 with SMTP id g2mr15856175qbo.1171033716322;
        Fri, 09 Feb 2007 07:08:36 -0800 (PST)
Received: from spoutnik.innova-card.com ( [81.252.61.1])
        by mx.google.com with ESMTP id q13sm3530337qbq.2007.02.09.07.08.34;
        Fri, 09 Feb 2007 07:08:35 -0800 (PST)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id 4F79E23F770; Fri,  9 Feb 2007 16:07:39 +0100 (CET)
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org, anemo@mba.ocn.ne.jp
Subject: [PATCH 0/3] More signal clean up
Date:	Fri,  9 Feb 2007 16:07:35 +0100
Message-Id: <1171033658561-git-send-email-fbuihuu@gmail.com>
X-Mailer: git-send-email 1.4.4.3.ge6d4
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14008
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Hi Ralf,

Sorry for forgetting these 3 trivial patches. It shouldn't
conflict with Atsushi's last patch:

	Check FCSR for pending interrupts, alternative version

Please consider,

		Franck
---

 arch/mips/kernel/signal-common.h |    2 ++
 arch/mips/kernel/signal.c        |   10 ++++------
 arch/mips/kernel/signal32.c      |    2 --
 arch/mips/kernel/signal_n32.c    |    2 --
 4 files changed, 6 insertions(+), 10 deletions(-)
