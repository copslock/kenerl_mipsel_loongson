Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 Nov 2009 12:05:48 +0100 (CET)
Received: from mail-px0-f173.google.com ([209.85.216.173]:43257 "EHLO
	mail-px0-f173.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492249AbZKULFl (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 21 Nov 2009 12:05:41 +0100
Received: by pxi3 with SMTP id 3so2973133pxi.22
        for <multiple recipients>; Sat, 21 Nov 2009 03:05:34 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=O8pIAqzOT+WNtqsGc3NqyLD1+8dvyausjdc5pLTP9JE=;
        b=dj+AeCGzMAcW3sTq1gwRn84TYG6R5Mq1Ac9GPV458Amnf6U8DWl0TWDFQhF0orxpFT
         jtlN8/IZv9F9vKxacqHyiHYXyJ4u12Ap2PpY2nP6jnQzR0gD8cRm+ixTwM8o+Yix6Ye1
         +ueBulr2s0HvOYZsQ+kGUP8T7RDbutTCzkc0o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=btLVH6KLKzeeZC1606wXDQVyxUY0KcMq3OJ6WvMWgUWYiVo5Pi6VK3KpVqfX46dWPq
         2OZlvbntU5DAclnZG+2t2b3Ct5jxeWC2cYjCQdRQzK9DnyzaEF3xqrSifsyYy7vrsHeP
         sDNBvTYFRKuXQhlwg4EOMKOYeXeJWkFVisnGk=
Received: by 10.114.165.18 with SMTP id n18mr1807165wae.154.1258801534102;
        Sat, 21 Nov 2009 03:05:34 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 21sm1508374pxi.4.2009.11.21.03.05.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 21 Nov 2009 03:05:33 -0800 (PST)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org, Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH v1 0/4] Fixups and Cleanups of lemote-2f family machines
Date:	Sat, 21 Nov 2009 19:05:21 +0800
Message-Id: <cover.1258800842.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25013
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

This patchset includes the following changes:

  - [loongson] Remove the inline annotation of prom_init_uart_base()
    Ensure gcc 3.4.6 can compile it.
  - [loongson] yeeloong2f: add basic ec operations
    add basic support for the Embedded Controller(ec_kb3310b) of yeeloong2f netbook.
    This support is needed for the coming yeeloong2f platform drivers.
  - [loongson] yeeloong2f: add LID open event as the wakeup event
    Allow users wakeup the netbook from suspend mode via opening the LID.
  - [loongson] yeeloong2f: cleanup the reset logic with ec_write function
    Benefit from "[loongson] yeeloong2f: add basic ec operations",
    we can use the cleanup the old reset implementaion now.

All of the above updates have been tested and put into this branch:

git://dev.lemote.com/rt4ls.git linux-loongson/dev/for-upstream

Hi, Ralf, Could you please queue it for linux-2.6.33? Thanks!

Best Wishes,
     Wu Zhangjin

Wu Zhangjin (4):
  [loongson] Remove the inline annotation of prom_init_uart_base()
  [loongson] yeeloong2f: add basic ec operations
  [loongson] yeeloong2f: add LID open event as the wakeup event
  [loongson] yeeloong2f: cleanup the reset logic with ec_write function

 arch/mips/include/asm/mach-loongson/loongson.h |    3 +-
 arch/mips/loongson/common/uart_base.c          |    2 +-
 arch/mips/loongson/lemote-2f/Makefile          |    2 +-
 arch/mips/loongson/lemote-2f/ec_kb3310b.c      |  132 ++++++++++++++++++++++++
 arch/mips/loongson/lemote-2f/ec_kb3310b.h      |   47 +++++++++
 arch/mips/loongson/lemote-2f/irq.c             |    4 +-
 arch/mips/loongson/lemote-2f/pm.c              |   71 ++++++++++++-
 arch/mips/loongson/lemote-2f/reset.c           |   21 +----
 8 files changed, 256 insertions(+), 26 deletions(-)
 create mode 100644 arch/mips/loongson/lemote-2f/ec_kb3310b.c
 create mode 100644 arch/mips/loongson/lemote-2f/ec_kb3310b.h
