Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Oct 2014 00:22:25 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:8049 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012176AbaJVWWYNSm8E (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 Oct 2014 00:22:24 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 78506991EEF93;
        Wed, 22 Oct 2014 23:22:13 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (10.40.60.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Wed, 22 Oct
 2014 23:22:17 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (10.40.60.222) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 22 Oct 2014 23:22:17 +0100
Received: from localhost (192.168.154.101) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.195.1; Wed, 22 Oct
 2014 23:22:16 +0100
Date:   Wed, 22 Oct 2014 23:22:16 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Eunbong Song <eunb.song@samsung.com>
CC:     <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mips: add arch_trigger_all_cpu_backtrace() function
Message-ID: <20141022222216.GD12296@jhogan-linux.le.imgtec.org>
References: <1669712409.167661413959996217.JavaMail.weblogic@epmlwas02b>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <1669712409.167661413959996217.JavaMail.weblogic@epmlwas02b>
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Originating-IP: [192.168.154.101]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43508
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

On Wed, Oct 22, 2014 at 06:39:56AM +0000, Eunbong Song wrote:
> This patch adds arch_trigger_all_cpu_backtrace() for mips architecture.

Don't forget your Signed-off-by

> +static void arch_dump_stack(void *info)
> +{
> +	struct pt_regs *regs;  
> +	
> +	regs = get_irq_regs();
> +
> +	if(regs)
> +		show_regs(regs);
> +
> +	dump_stack();
> +}
> +
> +void arch_trigger_all_cpu_backtrace(bool include_self)
> +{
> +	smp_call_function(arch_dump_stack, NULL, 1);

should this call arch_dump_stack directly too if include_self?

Cheers
James
