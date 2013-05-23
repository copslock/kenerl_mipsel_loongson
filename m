Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 May 2013 11:21:39 +0200 (CEST)
Received: from mail-bk0-f49.google.com ([209.85.214.49]:40106 "EHLO
        mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823013Ab3EWJVcIgqus (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 May 2013 11:21:32 +0200
Received: by mail-bk0-f49.google.com with SMTP id na1so311341bkb.36
        for <multiple recipients>; Thu, 23 May 2013 02:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        bh=hRtuLKfQ3MZrPnHApPceYnNwQ7bkjrnIF/UlActYxI8=;
        b=XSuABbSJ4jjPJmOXLgTPqP4+4sdOT0ahYYvg/7lSRN9Tcn1azINw57QXww4aLX7EJO
         ChUazzjjXR7ks6PmG1l38+Bv2IKHmuhHu76LDQnN8ZFbb2PVxqjh+6b7NG6p6IiP791R
         s5HXh5QtmCpNTaER/ppfMEZKD+7PGaQ1rxPyUWp5XtTGvqxv6kme6U+lc72tStlLDZVM
         y3XZeEcew7JfVZ/mbEl0SJHEyg51bj+P2V0kig7jqCH7th8VrjfVxqi7Dydz9+a6Ofve
         TirBpQC9jv8gyQfttslN+8lvHJGa+frAp232reHJZxQvKYZVXJjG9OUd1Aeu+ZkQjr/T
         fgOQ==
X-Received: by 10.205.9.193 with SMTP id ox1mr5982231bkb.35.1369300886753;
        Thu, 23 May 2013 02:21:26 -0700 (PDT)
Received: from [0.0.0.0] ([62.159.77.167])
        by mx.google.com with ESMTPSA id tc9sm2953968bkb.18.2013.05.23.02.21.21
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 23 May 2013 02:21:22 -0700 (PDT)
Message-ID: <519DDF8D.70700@gmail.com>
Date:   Thu, 23 May 2013 11:21:17 +0200
From:   Wladislav Wiebe <wladislav.kw@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20130308 Thunderbird/17.0.4
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>, david.daney@cavium.com,
        Maxim Uvarov <muvarov@gmail.com>, davem@davemloft.net
CC:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] MIPS: Octeon: fix for held reboot_mutex lock at task
 exit time
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <wladislav.kw@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36548
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wladislav.kw@gmail.com
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

When kernel halt's will reboot_mutex lock still hold at exit.
It will issue with 'halt' command:
$ halt
..
Sent SIGKILL to all processes
Requesting system halt
[66.729373] System halted.
[66.733244]
[66.734761] =====================================
[66.739473] [ BUG: lock held at task exit time! ]
[66.744188] 3.8.7-0-sampleversion-fct #49 Tainted: G           O
[66.750202] -------------------------------------
[66.754913] init/21479 is exiting with locks still held!
[66.760234] 1 lock held by init/21479:
[66.763990]  #0:  (reboot_mutex){+.+...}, at: [<ffffffff801776c8>] SyS_reboot+0xe0/0x218
[66.772165]
[66.772165] stack backtrace:
[66.776532] Call Trace:
[66.778992] [<ffffffff805780a8>] dump_stack+0x8/0x34
[66.783972] [<ffffffff801618b0>] do_exit+0x610/0xa70
[66.788948] [<ffffffff801777a8>] SyS_reboot+0x1c0/0x218
[66.794186] [<ffffffff8013d6a4>] handle_sys64+0x44/0x64

With this commit we will still have a proper halt sequence
and the reboot_mutex held bug is gone: (added printk's to affected functions)
$ halt
..
ent SIGKILL to all processes
Requesting system halt
[70.258665] DBG: kernel/sys.c, 486, SYSC_reboot: (case LINUX_REBOOT_CMD_HALT:)
[70.268953] DBG: kernel/sys.c, 396, kernel_halt: (kernel_shutdown_prepare(..);)
[70.284069] DBG: kernel/sys.c, 398, kernel_halt: (syscore_shutdown();)
[70.294364] DBG: kernel/sys.c, 400, kernel_halt: (kmsg_dump(KMSG_DUMP_HALT);)
[70.304640] System halted.
[70.307363] DBG: kernel/sys.c, 403, kernel_halt: (machine_halt();)
[70.317640] DBG: arch/mips/cavium-octeon/setup.c, 502, octeon_halt:
[70.329582] DBG: arch/mips/cavium-octeon/setup.c, 485, octeon_kill_core: (core1)
[70.329588] DBG: arch/mips/cavium-octeon/setup.c, 485, octeon_kill_core: (core2)
[70.329594] DBG: arch/mips/cavium-octeon/setup.c, 485, octeon_kill_core: (core3)
[70.329600] DBG: arch/mips/cavium-octeon/setup.c, 485, octeon_kill_core: (core4)
[70.329607] DBG: arch/mips/cavium-octeon/setup.c, 485, octeon_kill_core: (core5)
[70.329614] DBG: arch/mips/cavium-octeon/setup.c, 485, octeon_kill_core: (core6)

In this case on a 6 Core Cavium Octeon board.

Acked-by: Maxim Uvarov <muvarov@gmail.com>
Signed-off-by: Wladislav Wiebe <wladislav.kw@gmail.com>
---
 arch/mips/cavium-octeon/setup.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
index b0baa29..04ce396 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -457,6 +457,10 @@ static void octeon_halt(void)
 	}

 	octeon_kill_core(NULL);
+
+	/* We stop here */
+	while (1)
+		;
 }

 /**
-- 
1.7.9.5
