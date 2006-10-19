Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Oct 2006 12:20:06 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.190]:44001 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20037890AbWJSLUE (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 19 Oct 2006 12:20:04 +0100
Received: by nf-out-0910.google.com with SMTP id l23so1027107nfc
        for <linux-mips@linux-mips.org>; Thu, 19 Oct 2006 04:20:03 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:cc:subject:date:message-id:x-mailer:from;
        b=La2N3wC5ZqPN1q0e/LNB1ZxBkF/1fP3UEynkwMkIHHGDvxlNEKPgCVIZuQ6az3WmpLrr/hOUTyeQrfiHBZAR6VozQAlaVHWNURhPfRsmT98Hefh4zeErSgi2dIAG0zDkBupwI1QEr2Qntjw5kTI17rdgKK07G2aZCJ2tHcv4ufc=
Received: by 10.49.90.4 with SMTP id s4mr5610316nfl;
        Thu, 19 Oct 2006 04:20:03 -0700 (PDT)
Received: from spoutnik.innova-card.com ( [81.252.61.1])
        by mx.google.com with ESMTP id y24sm870874nfb.2006.10.19.04.20.02;
        Thu, 19 Oct 2006 04:20:02 -0700 (PDT)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id BBE6A23F76A; Thu, 19 Oct 2006 13:20:05 +0200 (CEST)
To:	ralf@linux-mips.org
Cc:	anemo@mba.ocn.ne.jp, ths@networkno.de, linux-mips@linux-mips.org
Subject: [PATCH 0/7] Get ride of CPHYSADDR() in setup.c [take #4]
Date:	Thu, 19 Oct 2006 13:19:58 +0200
Message-Id: <11612568052624-git-send-email-fbuihuu@gmail.com>
X-Mailer: git-send-email 1.4.2.3
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13026
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Changes since take #3
--------------------
  * Sign extension hack still needed by rd_start_early() (Atsushi)
  * Replace panic() by printk() in init_initrd() (Atsushi)
  * Fix CONFIG_64BITS typo (Atsushi)
  * Add a new sanity check in init_initrd():
		initrd_start < PAGE_OFFSET

Changes since take #2
--------------------
  * More initrd code clean up. It should be more readable and
    more robust now.
  * Add some missing include in page.h (Atsushi)
  * Fix a wrong use of __page_offset() in __va() (Atsushi)
  * Rename __page_offset() into __pa_page_offset()

changes since take #1
--------------------
  * Changed the definition of __pa() for 64-bits kernels to match
    the one suggested by Atsushi. It should be safer.
  * Make virt_to_page() uses virt_to_phys() instead of __pa().


Thanks to Atsushi for testing this patchset on 64 bit kernels.

Please consider,

		Franck
---

 arch/mips/kernel/setup.c   |   87 +++++++++++++++++++++++++++-----------------
 arch/mips/mm/init.c        |   42 ++++++++++-----------
 include/asm-mips/io.h      |    2 +
 include/asm-mips/page.h    |   16 ++++++--
 include/asm-mips/pgtable.h |    2 +
 5 files changed, 87 insertions(+), 62 deletions(-)
