Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Aug 2008 15:48:07 +0100 (BST)
Received: from yx-out-1718.google.com ([74.125.44.153]:45911 "EHLO
	yx-out-1718.google.com") by ftp.linux-mips.org with ESMTP
	id S28585579AbYHUOr7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 21 Aug 2008 15:47:59 +0100
Received: by yx-out-1718.google.com with SMTP id 36so8576yxh.24
        for <linux-mips@linux-mips.org>; Thu, 21 Aug 2008 07:47:57 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :x-mailer:mime-version:content-type:content-transfer-encoding:sender
         :message-id;
        bh=BYCSHeyDTqHF4rDxRylMXj5v55k7QyS7XZ9S6q9DEKU=;
        b=BAV5eM9R/dNN+pCmN5ltcQEzafZRhxUHPLNynA1uYHl+e5X1l6mpGoRoGp5ZFAOK1w
         2OANNZf8JDJGrIn7FaKQWPV8DWWeGJZTMtqoo+JWdLFHb7AlRVvQ7J9W2bQ0JEhvSgTl
         TE93GfdcafoFRtFVE0eXdD4qGGaJEVdEYImIg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:x-mailer:mime-version:content-type
         :content-transfer-encoding:sender:message-id;
        b=DB1mmHbaO7IJ7VMu1dBrZHWfGHcMgrNxg6A+XtlzPlnOAF6Et6TnSgqftTCElXkMy3
         zop071raYoAAaj3X+vQaetj5INiaSWU+d5ai33lUHmScB1QR9zo8QjgCqz+q+A9KHvkM
         aJiK5LJBavTrek3q5Uvj9PWioC9BzEGdckmxo=
Received: by 10.114.95.1 with SMTP id s1mr1479904wab.13.1219330076560;
        Thu, 21 Aug 2008 07:47:56 -0700 (PDT)
Received: from delta ( [125.30.7.41])
        by mx.google.com with ESMTPS id 30sm16569yxk.4.2008.08.21.07.47.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 21 Aug 2008 07:47:55 -0700 (PDT)
Date:	Thu, 21 Aug 2008 23:47:52 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][MIPS] cobalt: select PCI
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.9; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-ID: <48ad801b.9e03be0a.1023.04ef@mx.google.com>
Return-Path: <tripeaks@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20305
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

cobalt_board_id is indispensable for Cobalt server.
It's depend on PCI.

arch/mips/cobalt/built-in.o: In function `cobalt_led_add':
led.c:(.init.text+0x1a4): undefined reference to `cobalt_board_id'
led.c:(.init.text+0x1a8): undefined reference to `cobalt_board_id'
arch/mips/cobalt/built-in.o: In function `cobalt_uart_add':
serial.c:(.init.text+0x334): undefined reference to `cobalt_board_id'
serial.c:(.init.text+0x338): undefined reference to `cobalt_board_id'
arch/mips/cobalt/built-in.o: In function `get_system_type':
(.text.get_system_type+0x0): undefined reference to `cobalt_board_id'
arch/mips/cobalt/built-in.o:(.text.get_system_type+0x4): more undefined references to `cobalt_board_id' follow
make: *** [vmlinux] Error 1

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X /home/yuasa/Memo/dontdiff linux-orig/arch/mips/Kconfig linux/arch/mips/Kconfig
--- linux-orig/arch/mips/Kconfig	2008-08-05 13:54:04.522608782 +0900
+++ linux/arch/mips/Kconfig	2008-08-05 13:54:52.185324926 +0900
@@ -71,6 +71,7 @@ config MIPS_COBALT
 	select IRQ_CPU
 	select IRQ_GT641XX
 	select PCI_GT64XXX_PCI0
+	select PCI
 	select SYS_HAS_CPU_NEVADA
 	select SYS_HAS_EARLY_PRINTK
 	select SYS_SUPPORTS_32BIT_KERNEL
