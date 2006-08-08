Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Aug 2006 13:51:45 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.190]:44727 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20041134AbWHHMt1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 8 Aug 2006 13:49:27 +0100
Received: by nf-out-0910.google.com with SMTP id o60so240921nfa
        for <linux-mips@linux-mips.org>; Tue, 08 Aug 2006 05:49:13 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:x-mailer;
        b=H7NXALiiJDjKdaKnyCGbQIM/0kkQbaa27gnsBT0+eOKDRQ0YI14ONmw3GDbizy/AZFCVD3zO7/kKehxZQMOLLHbj6E8oDUbnFFsOuRqHPM8SrUfoV5oO6aI8gSTBpUeUPF6MFTz6kNvHLWydcXMSYRN+4l2ugcI+tEoFsdo5sBg=
Received: by 10.49.8.10 with SMTP id l10mr400051nfi;
        Tue, 08 Aug 2006 05:49:13 -0700 (PDT)
Received: from spoutnik.innova-card.com ( [194.3.162.233])
        by mx.gmail.com with ESMTP id k24sm761637nfc.2006.08.08.05.49.13;
        Tue, 08 Aug 2006 05:49:13 -0700 (PDT)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id 91D9923F76A; Tue,  8 Aug 2006 14:48:32 +0200 (CEST)
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
To:	linux-mips@linux-mips.org
Cc:	anemo@mba.ocn.ne.jp, ralf@linux-mips.org,
	yoichi_yuasa@tripeaks.co.jp
Subject: [patch 0/6] cleanup setup.c
Date:	Tue,  8 Aug 2006 14:48:26 +0200
Message-Id: <1155041312273-git-send-email-vagabon.xyz@gmail.com>
X-Mailer: git-send-email 1.4.2.rc2
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12237
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Here's a patchset that clean up arch/mips/kernel/setup.c file.

NOTE !  The semantic for initrd command line argument has been
changed mainly because it is now a lot simpler to parse.
Before we were using "rd_start=xxx rd_size=yyy", now the patch uses
"initrd=yyy@xxx". It seems that no default config files use the old
semantic but I'm not sure for bootloader users for example...

Am I allowed to do that ?

		Franck

Overall diffstats:

 arch/mips/kernel/setup.c |  429 +++++++++++++++++++---------------------------
 1 files changed, 177 insertions(+), 252 deletions(-)
