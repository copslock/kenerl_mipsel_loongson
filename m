Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 11 Nov 2017 03:38:22 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:56552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992309AbdKKCiOrkSW5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 11 Nov 2017 03:38:14 +0100
Received: from gandalf.local.home (cpe-67-246-153-56.stny.res.rr.com [67.246.153.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 568D8218C5;
        Sat, 11 Nov 2017 02:38:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 568D8218C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date:   Fri, 10 Nov 2017 21:38:05 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     tglx@linutronix.de, john.stultz@linaro.org,
        linux-kernel@vger.kernel.org, arnd@arndb.de,
        y2038@lists.linaro.org, acme@kernel.org, benh@kernel.crashing.org,
        borntraeger@de.ibm.com, catalin.marinas@arm.com,
        cmetcalf@mellanox.com, cohuck@redhat.com, davem@davemloft.net,
        deller@gmx.de, devel@driverdev.osuosl.org,
        gerald.schaefer@de.ibm.com, gregkh@linuxfoundation.org,
        heiko.carstens@de.ibm.com, hoeppner@linux.vnet.ibm.com,
        hpa@zytor.com, jejb@parisc-linux.org, jwi@linux.vnet.ibm.com,
        linux-mips@linux-mips.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        mark.rutland@arm.com, mingo@redhat.com, mpe@ellerman.id.au,
        oberpar@linux.vnet.ibm.com, oprofile-list@lists.sf.net,
        paulus@samba.org, peterz@infradead.org, ralf@linux-mips.org,
        rric@kernel.org, schwidefsky@de.ibm.com, sebott@linux.vnet.ibm.com,
        sparclinux@vger.kernel.org, sth@linux.vnet.ibm.com,
        ubraun@linux.vnet.ibm.com, will.deacon@arm.com, x86@kernel.org
Subject: Re: [PATCH 1/9] include: Move compat_timespec/ timeval to
 compat_time.h
Message-ID: <20171110213805.0400a855@gandalf.local.home>
In-Reply-To: <20171110224259.15930-2-deepa.kernel@gmail.com>
References: <20171110224259.15930-1-deepa.kernel@gmail.com>
        <20171110224259.15930-2-deepa.kernel@gmail.com>
X-Mailer: Claws Mail 3.14.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <SRS0=fXM2=CJ=goodmis.org=rostedt@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60835
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rostedt@goodmis.org
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

On Fri, 10 Nov 2017 14:42:51 -0800
Deepa Dinamani <deepa.kernel@gmail.com> wrote:

> diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
> index 09ad88572746..db25aa15b705 100644
> --- a/arch/x86/include/asm/ftrace.h
> +++ b/arch/x86/include/asm/ftrace.h
> @@ -49,7 +49,7 @@ int ftrace_int3_handler(struct pt_regs *regs);
>  #if !defined(__ASSEMBLY__) && !defined(COMPILE_OFFSETS)
>  
>  #if defined(CONFIG_FTRACE_SYSCALLS) && defined(CONFIG_IA32_EMULATION)
> -#include <asm/compat.h>
> +#include <linux/compat.h>
>  

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve
