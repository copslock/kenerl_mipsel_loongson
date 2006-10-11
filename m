Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Oct 2006 13:10:15 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.188]:42356 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20037684AbWJKMIz (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 11 Oct 2006 13:08:55 +0100
Received: by nf-out-0910.google.com with SMTP id a25so165413nfc
        for <linux-mips@linux-mips.org>; Wed, 11 Oct 2006 05:08:55 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:cc:subject:date:message-id:x-mailer:from;
        b=oR793y8memMD8hJrJNyTQl3agTFQdYqeuTakx/uaXqi5YkEQq+pRoOwSI4yl7GmNstS53lIuAAmatNSi3BotHb2nz2V8vyp25Tw9PCj2LXKDsm5Q4tmO8OJFpSmW7OJS+5Vr0JwDvlHoBBsInaGWSJ7Wx9j8adYSMF4ZFm0ypDI=
Received: by 10.49.10.3 with SMTP id n3mr3056391nfi;
        Wed, 11 Oct 2006 05:08:54 -0700 (PDT)
Received: from spoutnik.innova-card.com ( [81.252.61.1])
        by mx.google.com with ESMTP id c1sm2924114nfe.2006.10.11.05.08.53;
        Wed, 11 Oct 2006 05:08:53 -0700 (PDT)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id DDF3A23F770; Wed, 11 Oct 2006 14:08:45 +0200 (CEST)
To:	ralf@linux-mips.org
Cc:	anemo@mba.ocn.ne.jp, ths@networkno.de, linux-mips@linux-mips.org
Subject: [PATCH 0/5] Get ride of CPHYSADDR() in setup.c
Date:	Wed, 11 Oct 2006 14:08:40 +0200
Message-Id: <1160568525897-git-send-email-fbuihuu@gmail.com>
X-Mailer: git-send-email 1.4.2.3
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12901
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Indeed there's no point to have 2 macros __pa()/CPHYSADDR()
that do exactly the same thing that is convert a virtual
address into physical one at early boot.

So this patch simply removes CPHYSADDR() usages and make __pa()
aware of 64 bit kernels with CONFIG_BUILD_ELF64=n constraint.

At the same time, it also removes all hacks related to the
previous constraint and initrd.

Unfortunately, no tests have been done for 64 bit kernels
because of lacks of hardware. If anybody could give a try that
would be great.

Please consider,

		Franck
---

 arch/mips/kernel/setup.c |   53 ++++++++++++++++++++++++++--------------------
 arch/mips/mm/init.c      |    5 ----
 include/asm-mips/page.h  |    7 +++++-
 3 files changed, 36 insertions(+), 29 deletions(-)
