Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Oct 2014 22:57:03 +0200 (CEST)
Received: from mail-pd0-f171.google.com ([209.85.192.171]:49722 "EHLO
        mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011970AbaJTUzLtPK3c (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 Oct 2014 22:55:11 +0200
Received: by mail-pd0-f171.google.com with SMTP id ft15so5701207pdb.2
        for <linux-mips@linux-mips.org>; Mon, 20 Oct 2014 13:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kyL4NquGDJwdcIUtQJQhy0cCq6kpi6NuUuum6i++DRg=;
        b=xHswFeeGjeb57xXJyj265w/G0iDG6bXdomH1AaYmzOqklwDHY44E9dgzJbE7+6DuR7
         YshTvtVOjFi+tMqNBtjqRhZJhSsWYasHPttD0lYj/o5A0w3plA77bcNTEACHVj/lz3tn
         KeIVYwpACF/6Juozn9yHzxUuZf+QdWn2yMRQ6Plgdgu0/mYT9gGlfXZYRnd8+9KXlhxb
         ukVn4+Z11WfvjKHm3Ao9sFifwU/I6EXTfD6MgOpTM0+D7v3KfnPtwB+RqqBmKfAL4BwC
         luWZ3CdpclCo1HCXkbFgKLZ5YNDPJUy1w6AqfmgVI+BuHuD1OVrwC4AUs4vqE43vI3Kw
         N8NQ==
X-Received: by 10.66.141.165 with SMTP id rp5mr6124563pab.121.1413838505841;
        Mon, 20 Oct 2014 13:55:05 -0700 (PDT)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id fr7sm9954083pdb.79.2014.10.20.13.55.04
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 20 Oct 2014 13:55:05 -0700 (PDT)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.cz, robh@kernel.org,
        grant.likely@linaro.org
Cc:     geert@linux-m68k.org, f.fainelli@gmail.com, mbizon@freebox.fr,
        jogo@openwrt.org, linux-mips@linux-mips.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH V2 7/9] tty: serial: of-serial: Suppress warnings if OF earlycon is invoked twice
Date:   Mon, 20 Oct 2014 13:54:06 -0700
Message-Id: <1413838448-29464-8-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1413838448-29464-1-git-send-email-cernekee@gmail.com>
References: <1413838448-29464-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43386
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Specifying "earlycon earlycon" on the kernel command line yields this
warning:

    bootconsole [uart0] enabled
    ------------[ cut here ]------------
    WARNING: CPU: 0 PID: 0 at kernel/printk/printk.c:2391 register_console+0x244/0x3fc()
    console 'uart0' already registered
    CPU: 0 PID: 0 Comm: swapper Not tainted 3.18.0-rc1+ #2
    Stack : 00000000 00000004 80af0000 80af0000 00000000 00000000 00000000 00000000
              80ad4e12 00000036 00000000 00000000 00010000 805abe88 805606b4 805abae7
              00000000 00000000 80ad38d8 805abe88 8055f304 43d42d03 9988c6a1 804e2710
              805b0000 80032854 00000000 00000000 8056492c 80599c84 80599c84 805606b4
              00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
              ...
    Call Trace:
    [<8001a22c>] show_stack+0x64/0x7c
    [<804e47d8>] dump_stack+0xc8/0xfc
    [<80032aa8>] warn_slowpath_common+0x7c/0xac
    [<80032b38>] warn_slowpath_fmt+0x2c/0x38
    [<80076524>] register_console+0x244/0x3fc
    [<805d8314>] of_setup_earlycon+0x74/0x98
    [<805daa40>] early_init_dt_scan_chosen_serial+0x104/0x134
    [<805c51a0>] do_early_param+0xc4/0x13c
    [<8004efa0>] parse_args+0x284/0x444
    [<805c56cc>] parse_early_options+0x34/0x40
    [<805c5714>] parse_early_param+0x3c/0x58
    [<805c87a4>] setup_arch+0xec/0x6e4
    [<805c57d4>] start_kernel+0x94/0x458

    ---[ end trace dc8fa200cb88537f ]---

In this case the duplicate "earlycon" was entered directly, but there are
other cases where this could happen inadvertently:

 - Some platforms allow user bootargs to be concatenated with builtin
   bootargs, e.g. CONFIG_CMDLINE_EXTEND.

 - Other platforms may want to hardwire earlycon to ON, so it isn't
   nice if a user manually specifying "earlycon" on the command line sees
   a big scary warning.

So, we will treat "earlycon" as a flag, and if happens to be requested
multiple times the kernel will not print any warnings.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 drivers/of/fdt.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index d1ffca8..20193cc 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -755,6 +755,11 @@ int __init early_init_dt_scan_chosen_serial(void)
 	int l;
 	const struct of_device_id *match = __earlycon_of_table;
 	const void *fdt = initial_boot_params;
+	static int done;
+
+	if (done)
+		return -EBUSY;
+	done = 1;
 
 	offset = fdt_path_offset(fdt, "/chosen");
 	if (offset < 0)
@@ -792,10 +797,9 @@ int __init early_init_dt_scan_chosen_serial(void)
 
 static int __init setup_of_earlycon(char *buf)
 {
-	if (buf)
-		return 0;
-
-	return early_init_dt_scan_chosen_serial();
+	if (!buf)
+		early_init_dt_scan_chosen_serial();
+	return 0;
 }
 early_param("earlycon", setup_of_earlycon);
 #endif
-- 
2.1.1
