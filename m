Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Jan 2007 14:16:06 +0000 (GMT)
Received: from nf-out-0910.google.com ([64.233.182.187]:26933 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20044412AbXAWOQB (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 23 Jan 2007 14:16:01 +0000
Received: by nf-out-0910.google.com with SMTP id l24so237972nfc
        for <linux-mips@linux-mips.org>; Tue, 23 Jan 2007 06:16:00 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:to:cc:subject:date:message-id:x-mailer:from;
        b=Z5vndMBy8/NY2E+dbZPlgxLZzJFZVROuRbblZV+Rhd+SmFDE4IAmHSHich7MRBjCg6aj9cdxBb9bsOB8cTQWCKnUSrFKKSH5Li2VvF4nz5cQRs+JNbAAUm9OFyaYOwBjKTep1C8hkCbX+J8Zgr1k2EZTwrB2ObFrfN15f+VN7XI=
Received: by 10.49.29.2 with SMTP id g2mr1143892nfj.1169561760097;
        Tue, 23 Jan 2007 06:16:00 -0800 (PST)
Received: from spoutnik.innova-card.com ( [81.252.61.1])
        by mx.google.com with ESMTP id m15sm2668787nfc.2007.01.23.06.15.59;
        Tue, 23 Jan 2007 06:15:59 -0800 (PST)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id 37A5323F76A; Tue, 23 Jan 2007 15:18:23 +0100 (CET)
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org
Subject: [PATCH 0/7] Clean up signal code
Date:	Tue, 23 Jan 2007 15:18:16 +0100
Message-Id: <1169561903878-git-send-email-fbuihuu@gmail.com>
X-Mailer: git-send-email 1.4.4.3.ge6d4
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13747
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

This patchset cleans up signal related code by factorizing code
shared by all signal sources. The consequence is that the signal
code is decreased a lot.

This patchset has been splitted out into 7 differents patches
to ease code review.

Two questions are still open: 

    (a) It seems that the status register is not saved by
        setup_sigcontext() and therefore not restored by
        restore_sigcontext(). Is it a bug ?

    (b) Status register is saved by setup_sigcontext32() but
        not restored by restore_sigcontext(). Is it a bug ?

Unfortunately I do not have any 64 bits cross compiler setup
and no adequate plateforms to test the changes introduced by
this patchset in signal32.c and signal_n32.c. If someone
could give it a try, that would be nice.

Please, consider.

		Franck
---
 arch/mips/kernel/signal-common.h |  194 +++++------------------
 arch/mips/kernel/signal.c        |  216 ++++++++++++++++++++------
 arch/mips/kernel/signal32.c      |  326 +++++++++++++++-----------------------
 arch/mips/kernel/signal_n32.c    |   26 ++--
 4 files changed, 354 insertions(+), 408 deletions(-)
