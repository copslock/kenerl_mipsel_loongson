Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Aug 2006 08:30:22 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.186]:53373 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S8133439AbWHCHaM (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 3 Aug 2006 08:30:12 +0100
Received: by nf-out-0910.google.com with SMTP id q29so939686nfc
        for <linux-mips@linux-mips.org>; Thu, 03 Aug 2006 00:30:12 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:x-mailer;
        b=LlLEDb8Xt7D7Z70dXf4u6592iur0w1CrlIT9VvnL5wFPtiXj0mGBHVm160n1ROpRYgXv86aE1gG8bqfLgWclHUhk2LhzpqM9Q6MOoxaeFYAG2xRGW8y3iD/a5gsGDt97evIIsx5RafNlyBSBneitpSGIEvvBUt8Eu+M/5PRLT10=
Received: by 10.49.10.3 with SMTP id n3mr3362379nfi;
        Thu, 03 Aug 2006 00:30:12 -0700 (PDT)
Received: from spoutnik.innova-card.com ( [194.3.162.233])
        by mx.gmail.com with ESMTP id p72sm655993nfc.2006.08.03.00.30.11;
        Thu, 03 Aug 2006 00:30:11 -0700 (PDT)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id 1C5A223F76A; Thu,  3 Aug 2006 09:29:21 +0200 (CEST)
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
To:	anemo@mba.ocn.ne.jp
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: [PATCH 0/7] Improve prologue analysis code (take #2)
Date:	Thu,  3 Aug 2006 09:29:14 +0200
Message-Id: <11545901611096-git-send-email-vagabon.xyz@gmail.com>
X-Mailer: git-send-email 1.4.2.rc2
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12166
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

This patch set clean up or improves this part of code. I splitted out
this into 7 patches to make the review easier.

This second try takes into account all feedbacks from Atsushi Nemoto.

		Franck

---
 arch/mips/kernel/process.c |  130 ++++++++++++++++++++++++--------------------
 arch/mips/kernel/traps.c   |   70 ++++++++++--------------
 2 files changed, 100 insertions(+), 100 deletions(-)
