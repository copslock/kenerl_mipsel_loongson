Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 22 Aug 2009 18:10:20 +0200 (CEST)
Received: from mail-bw0-f208.google.com ([209.85.218.208]:62063 "EHLO
	mail-bw0-f208.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493193AbZHVQKL (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 22 Aug 2009 18:10:11 +0200
Received: by bwz4 with SMTP id 4so1099528bwz.0
        for <multiple recipients>; Sat, 22 Aug 2009 09:10:06 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=zhRWrqz1duPgK2Cb6jUqlfvzMo9dvfiUHQwAHEUiWno=;
        b=G9+U9dOLl38M7m1hj6tGIqzktackaDJpdPBh0ynCGNX8qZXNage2MTr42J33Bvuuux
         BRdVHOmib2Ucnio34jZwYJLS91oTZus52V+XsUpmG5jGK7N394Fsat8eY28LxpjoqjVh
         jEgBfV0s1vFUqN+9CnVbexDPFP+pYqROnQA9A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=DYHjSRQSm7kiLsZ6IWvn52N1Md3AOWiJgPJX3a4FxlNS+6nGxZCDK97cLkyQA2FSRd
         ooRG4IqgI25is86d3iyQAZiqeJcM7KNEVEshoZuXQsn+6d1NvW6NhjE/C/Jvi8qfEx2q
         L+PdAbTkL0kaqQ1bJIyMY7OCf0ML1q+or9674=
Received: by 10.223.144.201 with SMTP id a9mr1599261fav.17.1250957406283;
        Sat, 22 Aug 2009 09:10:06 -0700 (PDT)
Received: from localhost.localdomain (fnoeppeil48.netpark.at [217.175.205.176])
        by mx.google.com with ESMTPS id f31sm4121507fkf.38.2009.08.22.09.10.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 22 Aug 2009 09:10:05 -0700 (PDT)
From:	Manuel Lauss <manuel.lauss@googlemail.com>
To:	Linux-MIPS <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>
Cc:	Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH 0/2] RFC: Alchemy: multiple timer base address support
Date:	Sat, 22 Aug 2009 18:09:59 +0200
Message-Id: <1250957401-14447-1-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.6.4
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23923
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

The Au1300 has the SYS_ block, which incorporates the 32kHz timer, PM
support and other stuff, at a base address different from all previous
models.  The following two patches add support for runtime detection
of CPU type and setup the timer on the correct base address (and as
preparation for a later patchseries, also irq number for RTCMATCH2).

Patch overview:
#1 adds a simple CPU subtype enumerator,
#2 implements the core changes.

Run-tested on DB1200.

Manuel Lauss (2):
  Alchemy: simple cpu subtype detector.
  Alchemy: timer: support multiple SYS_BASE addresses

 arch/mips/alchemy/common/time.c            |  137 ++++++++++++++++++++--------
 arch/mips/alchemy/devboards/pm.c           |   58 +++++++-----
 arch/mips/include/asm/mach-au1x00/au1000.h |   66 ++++++++++++--
 3 files changed, 191 insertions(+), 70 deletions(-)
