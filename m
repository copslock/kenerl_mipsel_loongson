Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Nov 2009 18:32:28 +0100 (CET)
Received: from mail-px0-f173.google.com ([209.85.216.173]:59966 "EHLO
	mail-px0-f173.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1494047AbZKSRcW (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 19 Nov 2009 18:32:22 +0100
Received: by pxi3 with SMTP id 3so1800437pxi.22
        for <multiple recipients>; Thu, 19 Nov 2009 09:32:15 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=EqVYvqpDHWIT4sbyaQF0CKwabzH0dIrbmJaMu+rvMkk=;
        b=QSHorgkalmYTT90hn+8KxqrIFQrnAwaBLza5CDDlbyosUXJu0Ya8pKIksG7J3loBg1
         8Su1qRxC/s0V7OGK1cmfHic7YQI+PqxrSz2pPgbZUY512pgKtkBspYwZ8Sxe1+uRn+PG
         wqi7YQDOVXwLGncJrmZNBFGiq4axpJwR6AJyM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=DBGVjbKHmeKGd0KUE2ruDULZX2NEQh42rXPYDpX8NfYkPd0vtOrCk9zYQUo5Afrwzd
         DbVd9sSHZVLexQMWHX/IrDdjStcHfgan+fD7uRa7tKfB+1IXO0hsX6+QCPbLuY2Y+gyd
         Z3gSoOfYg9AyZj2+zQE+I4WbkbP3+0xNRF6D4=
Received: by 10.114.50.17 with SMTP id x17mr239571wax.168.1258651935587;
        Thu, 19 Nov 2009 09:32:15 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 20sm461888pxi.7.2009.11.19.09.32.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 19 Nov 2009 09:32:14 -0800 (PST)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org, zhangfx@lemote.com, yanh@lemote.com,
	huhb@lemote.com, Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH 0/5] Lemote-2f: Add Platform Specific Support
Date:	Fri, 20 Nov 2009 01:32:05 +0800
Message-Id: <cover.1258651050.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24975
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

This patchset add the platform specific support for LynLoong2F(ALLINONE) PC and
YeeLoong2F netbook. and also, a cleanup and update for YeeLoong2F is added.

  o [loongson] LynLoong2F: Add Platform Specific Support
    Add the backlight and suspend support for LynLoong2F.
  o [loongson] yeeloong2f: add basic ec operations
    [loongson] yeeloong2f: add platform specific support
    Add the support for YeeLoong2F's Embedded Controller and cleanup the reset
    logic with the ec operations. the following yeeloong2f patches need this ec support.
  o [loongson] yeeloong2f: add platform specific support
    Add the backlight,hwmon,hotkey,thermal,battery,suspend support for YeeLoong2F.
  o [loongson] yeeloong2f: add LID open event as the wakeup event
    Setup a new wakeup interrupt for YeeLoong2F to allow user wakeup the
    netbook from suspend mode via opening the netbook.

All of the above updates have been put into this branch:

git://dev.lemote.com/rt4ls.git linux-loongson/dev/for-upstream

Thanks & Best Regards,
     Wu Zhangjin

Wu Zhangjin (5):
  [loongson] LynLoong2F: Add Platform Specific Support
  [loongson] yeeloong2f: add basic ec operations
  [loongson] yeeloong2f: add LID open event as the wakeup event
  [loongson] yeeloong2f: cleanup the reset logic with ec_write function
  [loongson] yeeloong2f: add platform specific support

 .../mips/include/asm/mach-loongson/cs5536/cs5536.h |   35 +
 .../asm/mach-loongson/cs5536/cs5536_mfgpt.h        |    5 +
 arch/mips/include/asm/mach-loongson/loongson.h     |    1 +
 arch/mips/kernel/setup.c                           |    1 +
 arch/mips/loongson/Kconfig                         |   53 +
 arch/mips/loongson/common/cmdline.c                |   10 +
 arch/mips/loongson/lemote-2f/Makefile              |    8 +-
 arch/mips/loongson/lemote-2f/ec_kb3310b.c          |  132 ++
 arch/mips/loongson/lemote-2f/ec_kb3310b.h          |  197 +++
 arch/mips/loongson/lemote-2f/irq.c                 |    4 +-
 arch/mips/loongson/lemote-2f/lynloong_pc.c         |  609 +++++++++
 arch/mips/loongson/lemote-2f/pm.c                  |   72 +
 arch/mips/loongson/lemote-2f/reset.c               |   21 +-
 arch/mips/loongson/lemote-2f/yeeloong_laptop.c     | 1354 ++++++++++++++++++++
 14 files changed, 2481 insertions(+), 21 deletions(-)
 create mode 100644 arch/mips/loongson/lemote-2f/ec_kb3310b.c
 create mode 100644 arch/mips/loongson/lemote-2f/ec_kb3310b.h
 create mode 100644 arch/mips/loongson/lemote-2f/lynloong_pc.c
 create mode 100644 arch/mips/loongson/lemote-2f/yeeloong_laptop.c
