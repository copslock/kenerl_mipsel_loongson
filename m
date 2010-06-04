Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Jun 2010 07:59:18 +0200 (CEST)
Received: from smtp1.linux-foundation.org ([140.211.169.13]:52040 "EHLO
        smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491164Ab0FDF7K (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Jun 2010 07:59:10 +0200
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
        by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o545wMDV003252
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Thu, 3 Jun 2010 22:58:23 -0700
Received: from localhost (localhost [127.0.0.1])
        by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with SMTP id o545wKTn009948;
        Thu, 3 Jun 2010 22:58:21 -0700
Date:   Thu, 3 Jun 2010 22:58:24 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Kevin Cernekee <cernekee@gmail.com>
Cc:     <mingo@elte.hu>, <simon.kagstrom@netinsight.net>,
        <David.Woodhouse@intel.com>, <lethal@linux-sh.org>,
        <linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>
Subject: Re: [PATCH v3] printk: fix delayed messages from CPU hotplug events
Message-Id: <20100603225824.8de77fba.akpm@linux-foundation.org>
In-Reply-To: <ee1bf4f9c158983acad0a4548229586128afad67@localhost>
References: <ee1bf4f9c158983acad0a4548229586128afad67@localhost>
X-Mailer: Sylpheed 2.7.1 (GTK+ 2.18.9; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
X-archive-position: 27071
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: akpm@linux-foundation.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 3043

On Thu, 3 Jun 2010 22:11:25 -0700 Kevin Cernekee <cernekee@gmail.com> wrote:

> [Changes from v2:
> 
> Use hotcpu_notifier - fix will only apply to hotplug events, not
> initial SMP boot
> 
> Kerneldocify function arguments
> 
> Use acquire_console_sem() instead of try_acquire_console_sem()
> 
> Reuse the existing disable_boot_consoles() initcall instead of making a
> new one]
> 
> When a secondary CPU is being brought up, it is not uncommon for
> printk() to be invoked when cpu_online(smp_processor_id()) == 0.  The
> case that I witnessed personally was on MIPS:
> 
> http://lkml.org/lkml/2010/5/30/4
> 
> If (can_use_console() == 0), printk() will spool its output to log_buf
> and it will be visible in "dmesg", but that output will NOT be echoed to
> the console until somebody calls release_console_sem() from a CPU that
> is online.  Therefore, the boot time messages from the new CPU can get
> stuck in "limbo" for a long time, and might suddenly appear on the
> screen when a completely unrelated event (e.g. "eth0: link is down")
> occurs.
> 
> This patch modifies the console code so that any pending messages are
> automatically flushed out to the console whenever a CPU hotplug
> operation completes successfully or aborts.
> 
> The issue was seen on 2.6.34.
> 
> ...
>
> +static int __cpuinit console_cpu_notify(struct notifier_block *self,
> +	unsigned long action, void *hcpu)
> +{
> +	switch (action) {
> +	case CPU_ONLINE:
> +	case CPU_UP_CANCELED:
> +		acquire_console_sem();
> +		release_console_sem();
> +	}
> +	return NOTIFY_OK;
> +}
> +
> +static struct notifier_block __cpuinitdata console_nb = {
> +	.notifier_call		= console_cpu_notify,
> +};
> +
> +/**
>   * acquire_console_sem - lock the console system for exclusive use.
>   *
>   * Acquires a semaphore which guarantees that the caller has
> @@ -1371,7 +1400,7 @@ int unregister_console(struct console *console)
>  }
>  EXPORT_SYMBOL(unregister_console);
>  
> -static int __init disable_boot_consoles(void)
> +static int __init printk_late_init(void)
>  {
>  	struct console *con;
>  
> @@ -1382,9 +1411,10 @@ static int __init disable_boot_consoles(void)
>  			unregister_console(con);
>  		}
>  	}
> +	register_hotcpu_notifier(&console_nb);

gack, we seem to have made these interfaces as hard to use and as documentation-free
as we possibly could :(

This:

--- a/kernel/printk.c~printk-fix-delayed-messages-from-cpu-hotplug-events-fix
+++ a/kernel/printk.c
@@ -1009,10 +1009,6 @@ static int __cpuinit console_cpu_notify(
 	return NOTIFY_OK;
 }
 
-static struct notifier_block __cpuinitdata console_nb = {
-	.notifier_call		= console_cpu_notify,
-};
-
 /**
  * acquire_console_sem - lock the console system for exclusive use.
  *
@@ -1411,7 +1407,7 @@ static int __init printk_late_init(void)
 			unregister_console(con);
 		}
 	}
-	register_hotcpu_notifier(&console_nb);
+	hotcpu_notifier(console_cpu_notify, 0);
 	return 0;
 }
 late_initcall(printk_late_init);


There are numerous other register_hotcpu_notifier() callsites which can
probably be converted.
