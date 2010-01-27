Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Jan 2010 15:46:04 +0100 (CET)
Received: from mail-pz0-f197.google.com ([209.85.222.197]:45371 "EHLO
        mail-pz0-f197.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493546Ab0A0OqA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 Jan 2010 15:46:00 +0100
Received: by pzk35 with SMTP id 35so1461518pzk.22
        for <multiple recipients>; Wed, 27 Jan 2010 06:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :content-type:organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=Y7Bb7+ms1TgkUQC5sMY9fgAf5au4f8nJVMY7wWp9oVg=;
        b=fqyFMe6BEnxdxofYt4/qb0f3ebSo4PuZgsHnr9pd007iP4+cdrhkkO0eDgxO/f+uhn
         Zgub/dUOW+jguiYIED5Ee4LEYuxvdHCA9aj9rLvLwIQA27MJKYQPNlGzlLVtR6ZkmpJF
         joVe3/90asi/3u7PeWc+FIIerDFHMmLF6JJPc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:content-type:organization:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=CdEUks89aHe/QG9UWiTGH9Q9Lvv8GzIBGu+lbmyo9zDT4PYbr1rlNkxPdP8f+fz7O+
         xmx3hroSmIuxz+NzIb+iB4dWEh+WWEhKQ4M9y7L1HAeurZGeyUo4PyiAMGNaCuohIy3F
         dLqV+Z/VeyPvxxo+XSngrDqIYkJNp9+w6HMsM=
Received: by 10.114.3.2 with SMTP id 2mr2146012wac.156.1264603552614;
        Wed, 27 Jan 2010 06:45:52 -0800 (PST)
Received: from ?192.168.2.212? ([202.201.14.140])
        by mx.google.com with ESMTPS id 20sm5528966pzk.1.2010.01.27.06.45.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 Jan 2010 06:45:51 -0800 (PST)
Subject: [PATCH -queue] Loongson: Cleanup the halt and poweroff action
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Liu Shiwei <liushiwei@gmail.com>,
        Wu Zhangjin <wuzhangjin@gmail.com>,
        linux-mips <linux-mips@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Wed, 27 Jan 2010 22:39:46 +0800
Message-ID: <1264603186.21973.0.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.2 
Content-Transfer-Encoding: 7bit
X-archive-position: 25701
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 17556

(Add linux-mips <linux-mips@linux-mips.org> into the CC: list to make the patchwork get it!)

From: Wu Zhangjin <wuzhangjin@gmail.com>

In the old source code, I have let halt and poweroff do the same action,
but in reality, they have different meanings.

As the manpage of shutdown shows:

-r     Reboot after shutdown.
-H     Halt action is to halt or drop into boot monitor on systems that support it.
-P     Halt action is to turn off the power.

and in the real world, some machines(e.g. NAS) did not provide a power
button and the shutdown works as reset, so, we need to provide a
mechanism to let the users turn off the power safely without breaking
the system, such a mechanism is "halt", which only put the system into a
dead loop or a power-save mode and print some information to the screen
to tell the users to turn off the power safely.

$ shutdown -hH now /* loongson_halt, not turn off the power */
$ shutdown -hP now /* loongson_poweroff, work as poweroff */

Tested-by: Liu Shiwei <liushiwei@gmail.com>
Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/loongson/common/reset.c |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/mips/loongson/common/reset.c b/arch/mips/loongson/common/reset.c
index 33dff18..4bd9c18 100644
--- a/arch/mips/loongson/common/reset.c
+++ b/arch/mips/loongson/common/reset.c
@@ -25,17 +25,26 @@ static void loongson_restart(char *command)
 	((void (*)(void))ioremap_nocache(LOONGSON_BOOT_BASE, 4)) ();
 }
 
-static void loongson_halt(void)
+static void loongson_poweroff(void)
 {
 	mach_prepare_shutdown();
 	unreachable();
 }
 
+static void loongson_halt(void)
+{
+	pr_notice("\n\n** You can safely turn off the power now **\n\n");
+	while (1) {
+		if (cpu_wait)
+			cpu_wait();
+	}
+}
+
 static int __init mips_reboot_setup(void)
 {
 	_machine_restart = loongson_restart;
 	_machine_halt = loongson_halt;
-	pm_power_off = loongson_halt;
+	pm_power_off = loongson_poweroff;
 
 	return 0;
 }
-- 
1.6.6
