Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Nov 2009 11:35:58 +0100 (CET)
Received: from mail-px0-f188.google.com ([209.85.216.188]:41883 "EHLO
	mail-px0-f188.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492426AbZKFKfw (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 6 Nov 2009 11:35:52 +0100
Received: by pxi26 with SMTP id 26so296415pxi.21
        for <multiple recipients>; Fri, 06 Nov 2009 02:35:44 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=k+VZxu0sDOXgMoFq3ybbLXBZ9l5nVR5G6oBCuIpW3wk=;
        b=qsQQM4Qhlmwd2csOHcdeNj+XOVtlcxA/yVjXAjb0sT11zDdPG0GNK7mjrJh3vy8DU5
         r8v7bhaj1+b24Qy/p0g9BqgYPTxhRMpjpl8EZeg0FjjTfGlC7Iy8SaJppAZ3GQg4vX8t
         3sZsprutw9XzLVjOyUIYFGJZtYyxXNRyugqEo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=smFOcoCh4p7sfm72ycEZnrxfns+IHp5jPY3ZTs/1sPPigAo1lSN4+9/YLK7NI66GTJ
         h8OhaTqg0Pq303Ene4s5osNbY8C30u1YNvN7kJKKqTcBbzOPBfTO0Vcxodni3XBnFaZm
         z78xH7DWXlJmnUvA/fzog4To8PDQNA0t+WSSY=
Received: by 10.115.132.12 with SMTP id j12mr6496486wan.121.1257503744557;
        Fri, 06 Nov 2009 02:35:44 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 22sm1679219pzk.10.2009.11.06.02.35.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 06 Nov 2009 02:35:44 -0800 (PST)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org, Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH -queue 0/2] cleanups of loongson support
Date:	Fri,  6 Nov 2009 18:35:32 +0800
Message-Id: <cover.1257503025.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24713
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

The next two patches cleanup the machtype support and the serial port support,
which will help to the coming support to share the same kernel image among
different loongson2f family machines made by Lemote.

Wu Zhangjin (2):
  [loongson] Cleanup the machtype support
  [loongson] Cleanup the serial port support

 arch/mips/include/asm/mach-loongson/loongson.h |    4 +++
 arch/mips/include/asm/mach-loongson/machine.h  |    2 -
 arch/mips/loongson/common/Makefile             |    2 +-
 arch/mips/loongson/common/cmdline.c            |    4 ++-
 arch/mips/loongson/common/early_printk.c       |   11 +++++---
 arch/mips/loongson/common/init.c               |   11 +++++---
 arch/mips/loongson/common/machtype.c           |   17 +++++++-----
 arch/mips/loongson/common/serial.c             |   15 +++++-----
 arch/mips/loongson/common/uart_base.c          |   34 ++++++++++++++++++++++++
 9 files changed, 74 insertions(+), 26 deletions(-)
 create mode 100644 arch/mips/loongson/common/uart_base.c
