Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Mar 2007 11:20:49 +0100 (BST)
Received: from ug-out-1314.google.com ([66.249.92.172]:29054 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S20021682AbXC0KUr (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 27 Mar 2007 11:20:47 +0100
Received: by ug-out-1314.google.com with SMTP id 40so2049667uga
        for <linux-mips@linux-mips.org>; Tue, 27 Mar 2007 03:19:46 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:to:cc:subject:date:message-id:x-mailer:from;
        b=CgWXu3HPh9cPv0TU7WVVEueHHzW9G/F5K2XSvOXTjxHs58ISL8MJsFav2NL2YtR2lKGWkDAJ87ybs1nY8Z44r9hDHt+1BJ/ZcCrBM8lR7S5xNy+hk1pPuuaIq4II1CmvsSniJNQ7nVXNXcHKyHSXB25ctzKUj0xwY75enF9vPYk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:to:cc:subject:date:message-id:x-mailer:from;
        b=swjAyKC4D8nC6V1ZTb/cp5mDZaqN1KxBWc6mw5XZ0qz2XsbiQF29NmwIRSX9xBj57nxAZIM+dq2ZYR+cgxmep+QVix4wE8YUkOghTyv9IyB+HvL0dOY3tuYhjWF2WLrMU63jxTizEG3M9V4gVXIrtnQw1EjgVUzQBzOe13uGshM=
Received: by 10.66.232.9 with SMTP id e9mr738677ugh.1174990786580;
        Tue, 27 Mar 2007 03:19:46 -0700 (PDT)
Received: from spoutnik.innova-card.com ( [81.252.61.1])
        by mx.google.com with ESMTP id m1sm9092974uge.2007.03.27.03.19.45;
        Tue, 27 Mar 2007 03:19:46 -0700 (PDT)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id 0DC2E23F76F; Tue, 27 Mar 2007 11:19:41 +0200 (CEST)
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org
Subject: [PATCH 0/4] PHYS_OFFSET fix and cleanup
Date:	Tue, 27 Mar 2007 11:19:36 +0200
Message-Id: <11749871802730-git-send-email-fbuihuu@gmail.com>
X-Mailer: git-send-email 1.5.1.rc1.27.g1d848
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14722
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Ralf,

This small patchset deals with PHYS_OFFSET (last) issue.

Most of the patch are clean up and ease PHYS_OFFSET use except for the
last one which is a real fix for 64-bits kernels with 32-bits
symbols. Basically we now use CPHYSADDR() in __pa(). But this change
implies that we could no more handle mapped kernel in this config. Do
you think it's a real issue ?

Please consider,

		Franck

---

 include/asm-mips/mach-generic/spaces.h |   30 +++++++++++++++++++++++++++---
 include/asm-mips/page.h                |   21 +++++++++------------
 2 files changed, 36 insertions(+), 15 deletions(-)
