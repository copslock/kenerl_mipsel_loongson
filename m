Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Jun 2010 05:15:54 +0200 (CEST)
Received: from 124x34x33x190.ap124.ftth.ucom.ne.jp ([124.34.33.190]:33810 "EHLO
        master.linux-sh.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1490966Ab0FADPv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 Jun 2010 05:15:51 +0200
Received: from localhost (unknown [127.0.0.1])
        by master.linux-sh.org (Postfix) with ESMTP id B0F7B636A5;
        Tue,  1 Jun 2010 03:15:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at linux-sh.org
Received: from master.linux-sh.org ([127.0.0.1])
        by localhost (master.linux-sh.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id yx52S3st8dNe; Tue,  1 Jun 2010 12:15:28 +0900 (JST)
Received: by master.linux-sh.org (Postfix, from userid 500)
        id 52FC8636AA; Tue,  1 Jun 2010 12:15:28 +0900 (JST)
Date:   Tue, 1 Jun 2010 12:15:28 +0900
From:   Paul Mundt <lethal@linux-sh.org>
To:     Kevin Cernekee <cernekee@gmail.com>
Cc:     mingo@elte.hu, akpm@linux-foundation.org,
        simon.kagstrom@netinsight.net, David.Woodhouse@intel.com,
        rgetz@analog.com, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH v2] printk: fix delayed messages from CPU hotplug events
Message-ID: <20100601031528.GC15411@linux-sh.org>
References: <ede63b5a20af951c755736f035d1e787772d7c28@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ede63b5a20af951c755736f035d1e787772d7c28@localhost>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-archive-position: 26952
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lethal@linux-sh.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 9

On Mon, May 31, 2010 at 04:57:15PM -0700, Kevin Cernekee wrote:
>  /**
> + * console_cpu_notify - print deferred console messages after CPU hotplug
> + *
> + * If printk() is called from a CPU that is not online yet, the messages
> + * will be spooled but will not show up on the console.  This function is
> + * called when a new CPU comes online and ensures that any such output
> + * gets printed.
> + */
> +static int __cpuinit console_cpu_notify(struct notifier_block *self,
> +	unsigned long action, void *hcpu)
> +{
> +	switch (action) {
> +	case CPU_ONLINE:
> +	case CPU_UP_CANCELED:
> +		if (try_acquire_console_sem() == 0)
> +			release_console_sem();
> +	}
> +	return NOTIFY_OK;
> +}
> +
> +static struct notifier_block __cpuinitdata console_nb = {
> +	.notifier_call		= console_cpu_notify,
> +};
> +
> +static int __init console_notifier_init(void)
> +{
> +	register_cpu_notifier(&console_nb);
> +	return 0;
> +}

If this is to be entirely restricted to CPU hotplug then you could use
the hotcpu notifier here instead of the open-coded cpu notifier directly,
the former wraps to the latter in the CPU hotplug case and is simply a
nop for the regular SMP case.
