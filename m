Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Sep 2011 21:10:28 +0200 (CEST)
Received: from alius.ayous.org ([78.46.213.165]:46300 "EHLO alius.ayous.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491160Ab1INTKY (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 14 Sep 2011 21:10:24 +0200
Received: from eos.turmzimmer.net ([2001:a60:f006:aba::1])
        by alius.turmzimmer.net with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <aba@not.so.argh.org>)
        id 1R3uqk-0001uS-8I; Wed, 14 Sep 2011 19:10:23 +0000
Received: from aba by eos.turmzimmer.net with local (Exim 4.69)
        (envelope-from <aba@not.so.argh.org>)
        id 1R3uqe-0008Tm-KQ; Wed, 14 Sep 2011 21:10:16 +0200
Date:   Wed, 14 Sep 2011 21:10:16 +0200
From:   Andreas Barth <aba@not.so.argh.org>
To:     linux-mips@linux-mips.org, Wu Zhangjin <wuzhangjin@gmail.com>
Subject: i8042_enable_kbd_port in arch/mips/loongson/lemote-2f/pm.c?
Message-ID: <20110914191016.GT15003@mails.so.argh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Editor: Vim http://www.vim.org/
User-Agent: Mutt/1.5.18 (2008-05-17)
X-archive-position: 31082
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aba@not.so.argh.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 7372

Hi,

I just noticed that i8042_enable_kbd_port in
arch/mips/loongson/lemote-2f/pm.c is almost equal to
i8042_enable_kbd_port in drivers/input/serio/i8042.c
(+ is pm.c - the error message in pm.c contains the string i8042.c,
the one in i8042.c not):

 static int i8042_enable_kbd_port(void)
 {
+       if (i8042_command(&i8042_ctr, I8042_CMD_CTL_RCTR)) {
+               pr_err("i8042.c: Can't read CTR while enabling i8042 kbd port."
+                      "\n");
+               return -EIO;
+       }
+
        i8042_ctr &= ~I8042_CTR_KBDDIS;
        i8042_ctr |= I8042_CTR_KBDINT;

        if (i8042_command(&i8042_ctr, I8042_CMD_CTL_WCTR)) {
                i8042_ctr &= ~I8042_CTR_KBDINT;
                i8042_ctr |= I8042_CTR_KBDDIS;
-               pr_err("Failed to enable KBD port\n");
+               pr_err("i8042.c: Failed to enable KBD port.\n");
                return -EIO;
        }

(called as part of setup_wakeup_events
               outb((0xff & ~(1 << I8042_KBD_IRQ)), PIC_MASTER_IMR);
               irq_mask = inb(PIC_MASTER_IMR);
               i8042_enable_kbd_port();
)



This was added within 94d0b0e3 with this comment:
    MIPS: Yeeloong 2F: Add board specific suspend support

    Lemote Loongson 2F family machines need an external interrupt to wake the
    system from the suspend mode.

    For YeeLoong 2F and Mengloong 2F setup the keyboard interrupt as the wakeup
    interrupt.

    The new Fuloong 2F and LingLoong 2F have a button to directly send an
    interrupt to the CPU so there is no need to setup an interrupt.

    Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
    Cc: linux-mips@linux-mips.org
    Cc: yanh@lemote.com
    Cc: huhb@lemote.com
    Cc: Wu Zhangjin <wuzhangjin@gmail.com>
    Cc: Len Brown <len.brown@intel.com>
    Cc: Rafael J. Wysocki <rjw@sisk.pl>
    Cc: linux-pm@lists.linux-foundation.org
    Patchwork: http://patchwork.linux-mips.org/patch/630/
    Acked-by: Pavel Machek <pavel@ucw.cz>
    Signed-off-by: Ralf Baechle <ralf@linux-mips.org>


My question now is: Could we migrate some way or other to use the standard
i8042_enable_kbd_port?



Andi
