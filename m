Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Oct 2006 13:40:15 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.185]:17644 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20038802AbWJMMjK (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 13 Oct 2006 13:39:10 +0100
Received: by nf-out-0910.google.com with SMTP id a25so860037nfc
        for <linux-mips@linux-mips.org>; Fri, 13 Oct 2006 05:39:09 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:cc:subject:date:message-id:x-mailer:from;
        b=HSmye2evPMNT0sBlPFQttm8262vf4StD2GRSs1ZZx4jBskJZTMaScEjD7kQhz0u1Wxv+xV1juBQzW4GcS0sjq9RkMF/FkA3QvNMVJhDVzqURK/3ToDvDXuOC0OvMRz3Woa/K2oPk0/sVWr72aOlWYnx76Nbh6QUI4ECkzZiYgcA=
Received: by 10.49.26.18 with SMTP id d18mr6915332nfj;
        Fri, 13 Oct 2006 05:39:09 -0700 (PDT)
Received: from spoutnik.innova-card.com ( [81.252.61.1])
        by mx.google.com with ESMTP id l22sm888754nfc.2006.10.13.05.39.08;
        Fri, 13 Oct 2006 05:39:09 -0700 (PDT)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id 39BEB23F76A; Fri, 13 Oct 2006 14:39:06 +0200 (CEST)
To:	ralf@linux-mips.org
Cc:	anemo@mba.ocn.ne.jp, ths@networkno.de, linux-mips@linux-mips.org
Subject: [PATCH 0/7] Get ride of CPHYSADDR() in setup.c [take #2]
Date:	Fri, 13 Oct 2006 14:38:59 +0200
Message-Id: <11607431461469-git-send-email-fbuihuu@gmail.com>
X-Mailer: git-send-email 1.4.2.3
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12932
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Here's the take #2.

I changed the definition of __pa() for 64-bits kernels to match
the one suggested by Atsushi. It should be safer.

It also makes virt_to_page() uses virt_to_phys() instead of
__pa().

Unfortunately, no tests have been done for 64 bit kernels
because of lacks of hardware. If anybody could give a try that
would be great.

Please consider,

		Franck
---

 arch/mips/kernel/setup.c   |   55 +++++++++++++++++++++++++-------------------
 arch/mips/mm/init.c        |   42 +++++++++++++++-------------------
 include/asm-mips/io.h      |    2 +-
 include/asm-mips/page.h    |   14 ++++++++---
 include/asm-mips/pgtable.h |    2 +-
 5 files changed, 62 insertions(+), 53 deletions(-)
