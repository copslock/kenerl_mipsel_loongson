Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Apr 2016 11:33:58 +0200 (CEST)
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:45848 "EHLO
        pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27026913AbcD0Jdx19apy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 Apr 2016 11:33:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=arm.linux.org.uk; s=pandora-2014;
        h=Sender:In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=n5xYZzuXq+X1irTOoe3iJT+oNWE5n9tRO5zBZRb9B0Y=;
        b=ktWCkMlPPNY6WOuJm6m3VnvPtT3dthkRtKywBxatoRNf2KYWSZ5XkYHSuwPeGoWG4MZeDkhvxyAByPNwhiAOs/rlMILHuOzfxmUBL5Cogoge7bJn7q9kYP7LeGEAWxj9qkSXy5YF8PnZ9G5kn4q8YVY8G9JEFQoq5RmzAkEwYcA=;
Received: from n2100.arm.linux.org.uk ([2001:4d48:ad52:3201:214:fdff:fe10:4f86]:35882)
        by pandora.arm.linux.org.uk with esmtpsa (TLSv1:DHE-RSA-AES256-SHA:256)
        (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <linux@arm.linux.org.uk>)
        id 1avLoz-0003nz-TX; Wed, 27 Apr 2016 10:31:50 +0100
Received: from linux by n2100.arm.linux.org.uk with local (Exim 4.76)
        (envelope-from <linux@n2100.arm.linux.org.uk>)
        id 1avLow-0000Wn-A5; Wed, 27 Apr 2016 10:31:46 +0100
Date:   Wed, 27 Apr 2016 10:31:45 +0100
From:   Russell King - ARM Linux <linux@arm.linux.org.uk>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jiri Kosina <jkosina@suse.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-cris-kernel@axis.com, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Ralf Baechle <ralf@linux-mips.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        David Miller <davem@davemloft.net>
Subject: Re: [PATCH v5 1/4] printk/nmi: generic solution for safe printk in
 NMI
Message-ID: <20160427093145.GJ19428@n2100.arm.linux.org.uk>
References: <1461239325-22779-1-git-send-email-pmladek@suse.com>
 <1461239325-22779-2-git-send-email-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1461239325-22779-2-git-send-email-pmladek@suse.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <linux+linux-mips=linux-mips.org@arm.linux.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53235
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@arm.linux.org.uk
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

On Thu, Apr 21, 2016 at 01:48:42PM +0200, Petr Mladek wrote:
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index cdfa6c2b7626..259543ec6dc9 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -66,6 +66,7 @@ config ARM
>  	select HAVE_KRETPROBES if (HAVE_KPROBES)
>  	select HAVE_MEMBLOCK
>  	select HAVE_MOD_ARCH_SPECIFIC
> +	select HAVE_NMI
>  	select HAVE_OPROFILE if (HAVE_PERF_EVENTS)
>  	select HAVE_OPTPROBES if !THUMB2_KERNEL
>  	select HAVE_PERF_EVENTS
> diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
> index baee70267f29..df90bc59bfce 100644
> --- a/arch/arm/kernel/smp.c
> +++ b/arch/arm/kernel/smp.c
> @@ -644,9 +644,11 @@ void handle_IPI(int ipinr, struct pt_regs *regs)
>  		break;
>  
>  	case IPI_CPU_BACKTRACE:
> +		printk_nmi_enter();
>  		irq_enter();
>  		nmi_cpu_backtrace(regs);
>  		irq_exit();
> +		printk_nmi_exit();
>  		break;
>  
>  	default:

For the above,

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
