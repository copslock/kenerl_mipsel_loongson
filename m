Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Feb 2007 09:20:32 +0000 (GMT)
Received: from hu-out-0506.google.com ([72.14.214.234]:45365 "EHLO
	hu-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20039024AbXBMJUC (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 13 Feb 2007 09:20:02 +0000
Received: by hu-out-0506.google.com with SMTP id 22so1062366hug
        for <linux-mips@linux-mips.org>; Tue, 13 Feb 2007 01:19:01 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:to:cc:subject:date:message-id:x-mailer:from;
        b=Nhq8/5drnSC+c0XxpzH0QARhh5E9/vqrle0s7y2hq8U4lFmypsq5Yq9dw48AhtJL0yJzQEMjcdPBPtbyL7oKHR0Bz4f8bSh2SS1BDrXkuOTUgXUTmX3+qdB5r8jfipVLjFvVcosunRxsAbHqZrFLo++C6ww7K9YgTlmbt80w6Pg=
Received: by 10.48.202.14 with SMTP id z14mr518783nff.1171358340551;
        Tue, 13 Feb 2007 01:19:00 -0800 (PST)
Received: from spoutnik.innova-card.com ( [81.252.61.1])
        by mx.google.com with ESMTP id n23sm1886941nfc.2007.02.13.01.18.59;
        Tue, 13 Feb 2007 01:18:59 -0800 (PST)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id 36A6C23F770; Tue, 13 Feb 2007 10:18:09 +0100 (CET)
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org, anemo@mba.ocn.ne.jp,
	macro@linux-mips.org
Subject: [RFC] Kill CONFIG_BUILD_ELF64 from Kconfig
Date:	Tue, 13 Feb 2007 10:18:06 +0100
Message-Id: <1171358289786-git-send-email-fbuihuu@gmail.com>
X-Mailer: git-send-email 1.4.4.3.ge6d4
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14060
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

This patchset results from the following thread we had a couple weeks
ago:

http://marc.theaimsgroup.com/?l=linux-mips&m=117000798317188&w=2

Once this patchset is applied, we do not need to configure
CONFIG_BUILD_ELF64 manually. Instead, the makefile should do the right
thing for us:

    - It passes '-msym32' switch to gcc according to the platform's
      load address.

    - We can still force Kbuild to not use '-msym32' whatever the
      value of the load address by passing "BUILD_ELF32=no" when
      invoking make.

Patch #3 renames CONFIG_BUILD_ELF64 into CONFIG_64BIT_BUILD_ELF32. It
simplifies the places where it's used.

This patchset assumes that the compiler will fail if it doesn't
support '-msym32' switch. Therefore we needn't to test gcc's version
when testing CONFIG_64BIT_BUILD_ELF32 value.

Please, consider.

		Franck

---
 arch/mips/Kconfig             |   15 ---------------
 arch/mips/Makefile            |   23 ++++++++++++++++++-----
 include/asm-mips/page.h       |    2 +-
 include/asm-mips/pgtable-64.h |    2 +-
 include/asm-mips/stackframe.h |   12 ++++++------
 5 files changed, 26 insertions(+), 28 deletions(-)
