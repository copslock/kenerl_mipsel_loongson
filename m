Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Aug 2006 10:29:12 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.191]:24343 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S8133447AbWHAJ2M (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 1 Aug 2006 10:28:12 +0100
Received: by nf-out-0910.google.com with SMTP id q29so210807nfc
        for <linux-mips@linux-mips.org>; Tue, 01 Aug 2006 02:28:11 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:x-mailer;
        b=IEy+WEUhFkkzdlvwdsD0mJl0avUOYlI4xIBdlNGflyvzkr14pieU7vBAFMG2w/itY6WqvkSEQICmguFZfupjUOocNqBmWnKDwgCiIqB5+kReMGSQMb6QoVtCrjixlnJM5vpPAMG2V9DvGjYCu1wSvk0DCmc+z8KxornSfEn4KbQ=
Received: by 10.49.75.2 with SMTP id c2mr403220nfl;
        Tue, 01 Aug 2006 02:28:11 -0700 (PDT)
Received: from spoutnik.innova-card.com ( [194.3.162.233])
        by mx.gmail.com with ESMTP id c1sm688395nfe.2006.08.01.02.28.11;
        Tue, 01 Aug 2006 02:28:11 -0700 (PDT)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id 19AA923F76A; Tue,  1 Aug 2006 11:27:18 +0200 (CEST)
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
To:	anemo@mba.ocn.ne.jp
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: [PATCH 0/7] Improve prologue analysis code
Date:	Tue,  1 Aug 2006 11:27:10 +0200
Message-Id: <11544244373398-git-send-email-vagabon.xyz@gmail.com>
X-Mailer: git-send-email 1.4.2.rc2
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12141
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

This patch serie clean up or improves this code. I splitted out
this into 7 patches to make the review easier.

		Franck

arch/mips/kernel/process.c |  111 +++++++++++++++++++++++---------------------
 arch/mips/kernel/traps.c   |   55 ++++++++--------------
 2 files changed, 76 insertions(+), 90 deletions(-)
