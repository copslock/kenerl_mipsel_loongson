Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 31 May 2010 06:42:21 +0200 (CEST)
Received: from 124x34x33x190.ap124.ftth.ucom.ne.jp ([124.34.33.190]:35215 "EHLO
        master.linux-sh.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491068Ab0EaEmS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 31 May 2010 06:42:18 +0200
Received: from localhost (unknown [127.0.0.1])
        by master.linux-sh.org (Postfix) with ESMTP id 9CF09636B0;
        Mon, 31 May 2010 04:41:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at linux-sh.org
Received: from master.linux-sh.org ([127.0.0.1])
        by localhost (master.linux-sh.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id CAiGIktjaZ9v; Mon, 31 May 2010 13:41:45 +0900 (JST)
Received: by master.linux-sh.org (Postfix, from userid 500)
        id 532BB636B3; Mon, 31 May 2010 13:41:45 +0900 (JST)
Date:   Mon, 31 May 2010 13:41:45 +0900
From:   Paul Mundt <lethal@linux-sh.org>
To:     Kevin Cernekee <cernekee@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] MIPS: Fix deferred console messages during CPU hotplug
Message-ID: <20100531044144.GA20358@linux-sh.org>
References: <1b31306f28573a4bee56f164b1f74962fced9bc5@localhost.localdomain> <526fcbfa605500d9da9b04ac0f93ef2beddca6ed@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <526fcbfa605500d9da9b04ac0f93ef2beddca6ed@localhost.localdomain>
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <lethal@linux-sh.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26936
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lethal@linux-sh.org
Precedence: bulk
X-list: linux-mips

On Sun, May 30, 2010 at 12:35:58AM -0700, Kevin Cernekee wrote:
> diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
> index 6cdca19..bf8923f 100644
> --- a/arch/mips/kernel/smp.c
> +++ b/arch/mips/kernel/smp.c
> @@ -219,6 +220,10 @@ int __cpuinit __cpu_up(unsigned int cpu)
>  
>  	cpu_set(cpu, cpu_online_map);
>  
> +	/* Flush out any buffered log messages from the new CPU */
> +	if (try_acquire_console_sem() == 0)
> +		release_console_sem();
> +
>  	return 0;
>  }
>  
Since this is entirely generic why not just have kernel/printk.c register
a hotcpu notifier and handle this in the CPU_ONLINE case?
