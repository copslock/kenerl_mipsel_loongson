Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Aug 2006 15:53:53 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.184]:13286 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20042387AbWHIOxZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 9 Aug 2006 15:53:25 +0100
Received: by nf-out-0910.google.com with SMTP id o60so206824nfa
        for <linux-mips@linux-mips.org>; Wed, 09 Aug 2006 07:53:21 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:x-mailer;
        b=gelvf/B1TSY7oclsq1zbvUJYKTUpXJSOG61TsKGJKenCl51VVQ3l4tVfOl/5FUicZInO8T3A94Ewc7D7q6fsVzsSzbKLef1pcTuzcH2/UkAOF27QdJezNTDZfygpburGnD+Z4m1+Q1G9AM90sBZIQj0BnuOKw4DRgY24ffJSrKc=
Received: by 10.49.29.3 with SMTP id g3mr1380342nfj;
        Wed, 09 Aug 2006 07:53:21 -0700 (PDT)
Received: from spoutnik.innova-card.com ( [194.3.162.233])
        by mx.gmail.com with ESMTP id z73sm2036221nfb.2006.08.09.07.53.19;
        Wed, 09 Aug 2006 07:53:21 -0700 (PDT)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id 435D123F76E; Wed,  9 Aug 2006 16:52:39 +0200 (CEST)
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
To:	linux-mips@linux-mips.org
Cc:	anemo@mba.ocn.ne.jp, ralf@linux-mips.org,
	yoichi_yuasa@tripeaks.co.jp
Subject: [patch 0/6] cleanup setup.c (take #2)
Date:	Wed,  9 Aug 2006 16:52:32 +0200
Message-Id: <11551351581277-git-send-email-vagabon.xyz@gmail.com>
X-Mailer: git-send-email 1.4.2.rc2
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12250
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Here's a patchset that clean up arch/mips/kernel/setup.c file.

This second take doesn't use "initrd=xxx@yyy" semantic anymore for
passing initrd memory area through the command line. It sticks
with the old semantic for bootloader compatibilities.

		Franck

Overall diffstats:

 arch/mips/kernel/setup.c |  442 ++++++++++++++++++++--------------------------
 1 files changed, 189 insertions(+), 253 deletions(-)
