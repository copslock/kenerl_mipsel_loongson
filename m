Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Oct 2006 17:15:40 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.187]:10828 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20039642AbWJPQM2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 16 Oct 2006 17:12:28 +0100
Received: by nf-out-0910.google.com with SMTP id l23so2530937nfc
        for <linux-mips@linux-mips.org>; Mon, 16 Oct 2006 09:12:20 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:cc:subject:date:message-id:x-mailer:from;
        b=UOzr+j9akHvQHt8AD1RiYLD2Z6uR4I9QKDhQDyMo9YN+hH94ycl78hPTYxyOYBcAEb5a6HXutPFjkn4XlnxRa6UwWdxIdY8c/njOShGs54btrqX9zspxbvXaidU4kdGV7iu3PJRhH6nhYzHzjQ7Var12cvaUgfLrn2R8RjblPLg=
Received: by 10.48.163.19 with SMTP id l19mr12194995nfe;
        Mon, 16 Oct 2006 09:12:19 -0700 (PDT)
Received: from spoutnik.innova-card.com ( [81.252.61.1])
        by mx.google.com with ESMTP id c10sm1145352nfb.2006.10.16.09.12.18;
        Mon, 16 Oct 2006 09:12:19 -0700 (PDT)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id A711123F76A; Mon, 16 Oct 2006 18:12:21 +0200 (CEST)
To:	ralf@linux-mips.org
Cc:	anemo@mba.ocn.ne.jp, ths@networkno.de, linux-mips@linux-mips.org
Subject: [PATCH 0/7] Get ride of CPHYSADDR() in setup.c [take #3]
Date:	Mon, 16 Oct 2006 18:12:14 +0200
Message-Id: <1161015141975-git-send-email-fbuihuu@gmail.com>
X-Mailer: git-send-email 1.4.2.3
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12978
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Changes from take #2
--------------------
  * More initrd code clean up. It should be more readable and
    more robust now.
  * Add some missing include in page.h (Atsushi)
  * Fix a wrong use of __page_offset() in __va() (Atsushi)
  * Rename __page_offset() into __pa_page_offset()

changes from take #1
--------------------
  * Changed the definition of __pa() for 64-bits kernels to match
    the one suggested by Atsushi. It should be safer.
  * Make virt_to_page() uses virt_to_phys() instead of __pa().


I still can't test this patchset on 64 bit kernels. If anybody
could give a try that would be great.

Please consider,

		Franck
---

 arch/mips/kernel/setup.c   |   77 +++++++++++++++++++-------------------------
 arch/mips/mm/init.c        |   42 +++++++++++++-----------
 include/asm-mips/io.h      |    2 +
 include/asm-mips/page.h    |   16 ++-------
 include/asm-mips/pgtable.h |    2 +
 5 files changed, 62 insertions(+), 77 deletions(-)
