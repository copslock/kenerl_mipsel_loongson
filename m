Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Sep 2014 20:05:12 +0200 (CEST)
Received: from mail-pd0-f169.google.com ([209.85.192.169]:58407 "EHLO
        mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010197AbaI3SBqohLmZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 30 Sep 2014 20:01:46 +0200
Received: by mail-pd0-f169.google.com with SMTP id p10so7698427pdj.14
        for <linux-mips@linux-mips.org>; Tue, 30 Sep 2014 11:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uk9PhDnqYd2VHty/au3bMVyIYyr5J/u7KX/H4dlb9Mo=;
        b=Y+UsaQkwNo+3j8tFz8Bu5jtJYoL8yb16x9RgRoRUL7jMsw5oQW1J6Y/IwquP1Xw0VR
         XfJfKBtTObXXnlvw+gipuOpoBsGMcank0x00X4eEZn+S8zW5HcKmZKUD/iq+E+fpDHi9
         8Of1YXw+lVDSLJuzscQ62n1cZfx/SvnsR0ylY6ZFrFNw/OwhONveb7UYw1MU0PF83dA+
         ocoJGsiW/TLV7c7WU6rRgdzumHRj4aSE8ZuixgRa7qq09IcZll+Swdt0Al5nEaV6DK1/
         70ghVjSTuAp7MxIoozpXKLQb8jxjAxuZCU4eUSqkkVt4USe88R55frO987lwSM9feDTU
         a0Bg==
X-Received: by 10.68.223.103 with SMTP id qt7mr72959161pbc.9.1412100100812;
        Tue, 30 Sep 2014 11:01:40 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by mx.google.com with ESMTPSA id f2sm15799501pdd.25.2014.09.30.11.01.40
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 30 Sep 2014 11:01:40 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-kernel@vger.kernel.org
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-c6x-dev@linux-c6x.org, linux-ia64@vger.kernel.org,
        linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org,
        xen-devel@lists.xenproject.org, Guenter Roeck <linux@roeck-us.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [RFC PATCH 13/16] x86: support poweroff through poweroff handler call chain
Date:   Tue, 30 Sep 2014 11:00:53 -0700
Message-Id: <1412100056-15517-14-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1412100056-15517-1-git-send-email-linux@roeck-us.net>
References: <1412100056-15517-1-git-send-email-linux@roeck-us.net>
Return-Path: <groeck7@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42919
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
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

The kernel core now supports a poweroff handler call chain
to remove power from the system. Call it if pm_power_off
is set to NULL.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/x86/kernel/reboot.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index 17962e6..c5514aa 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -651,6 +651,10 @@ static void native_machine_power_off(void)
 		if (!reboot_force)
 			machine_shutdown();
 		pm_power_off();
+	} else {
+		if (!reboot_force)
+			machine_shutdown();
+		do_kernel_poweroff();
 	}
 	/* A fallback in case there is no PM info available */
 	tboot_shutdown(TB_SHUTDOWN_HALT);
-- 
1.9.1
