Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Apr 2016 11:35:14 +0200 (CEST)
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:45879 "EHLO
        pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27027570AbcD0JfLpx45y (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 Apr 2016 11:35:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=arm.linux.org.uk; s=pandora-2014;
        h=Sender:In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=9MD9lPYM5CAOsrJ0VCR9UKWFZHUZRNcyoxjHREi4gt8=;
        b=PRe6mO3h2tw5whelyeLccGSITLSNXOUi5bAAWo3glNtNSkZkTaBpCQSjZ38iGHS3zYE8sK9zH5uYf8+akEjOgNKY160/X3JuVAykcH9KaTC4g32jOL36vtxaAXpac16eDjmfSHCGHAAELaR7Lw/E4cb6ivPZxcgqhJjBnYNMnYc=;
Received: from n2100.arm.linux.org.uk ([2001:4d48:ad52:3201:214:fdff:fe10:4f86]:35888)
        by pandora.arm.linux.org.uk with esmtpsa (TLSv1:DHE-RSA-AES256-SHA:256)
        (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <linux@arm.linux.org.uk>)
        id 1avLrm-0003pf-8F; Wed, 27 Apr 2016 10:34:42 +0100
Received: from linux by n2100.arm.linux.org.uk with local (Exim 4.76)
        (envelope-from <linux@n2100.arm.linux.org.uk>)
        id 1avLri-0000Yh-VQ; Wed, 27 Apr 2016 10:34:39 +0100
Date:   Wed, 27 Apr 2016 10:34:38 +0100
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
Subject: Re: [PATCH v5 2/4] printk/nmi: warn when some message has been lost
 in NMI context
Message-ID: <20160427093438.GK19428@n2100.arm.linux.org.uk>
References: <1461239325-22779-1-git-send-email-pmladek@suse.com>
 <1461239325-22779-3-git-send-email-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1461239325-22779-3-git-send-email-pmladek@suse.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <linux+linux-mips=linux-mips.org@arm.linux.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53236
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

On Thu, Apr 21, 2016 at 01:48:43PM +0200, Petr Mladek wrote:
> @@ -64,8 +65,10 @@ static int vprintk_nmi(const char *fmt, va_list args)
>  again:
>  	len = atomic_read(&s->len);
>  
> -	if (len >= sizeof(s->buffer))
> +	if (len >= sizeof(s->buffer)) {
> +		atomic_inc(&nmi_message_lost);

This should be fine - I think its reasonable to expect that no one is
using a spinlock implementation for their atomic ops for this...

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
