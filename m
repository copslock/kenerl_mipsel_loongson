Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Oct 2014 10:43:48 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:47155 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010680AbaJGInqnZ51j (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Oct 2014 10:43:46 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 8867C2DE87727;
        Tue,  7 Oct 2014 09:43:37 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 7 Oct 2014 09:43:39 +0100
Received: from [192.168.154.101] (192.168.154.101) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.195.1; Tue, 7 Oct
 2014 09:43:38 +0100
Message-ID: <5433A7BB.1090207@imgtec.com>
Date:   Tue, 7 Oct 2014 09:43:39 +0100
From:   James Hogan <james.hogan@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
MIME-Version: 1.0
To:     David Daney <ddaney.cavm@gmail.com>, <Zubair.Kakakhel@imgtec.com>,
        <peterz@infradead.org>, <paul.gortmaker@windriver.com>,
        <davidlohr@hp.com>, <macro@linux-mips.org>, <chenhc@lemote.com>,
        <zajec5@gmail.com>, <keescook@chromium.org>,
        <alex@alex-smith.me.uk>, <tglx@linutronix.de>,
        <blogic@openwrt.org>, <jchandra@broadcom.com>,
        <paul.burton@imgtec.com>, <qais.yousef@imgtec.com>,
        <ralf@linux-mips.org>, <markos.chandras@imgtec.com>,
        <manuel.lauss@gmail.com>, <akpm@linux-foundation.org>,
        <lars.persson@axis.com>, <torvalds@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>,
        <libc-alpha@sourceware.org>, David Daney <david.daney@cavium.com>
Subject: Re: [PATCH] MIPS: Allow FPU emulator to use non-stack area.
References: <1412626317-4128-1-git-send-email-ddaney.cavm@gmail.com>
In-Reply-To: <1412626317-4128-1-git-send-email-ddaney.cavm@gmail.com>
X-Enigmail-Version: 1.6
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.101]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43044
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

Hi David,

On 06/10/14 21:11, David Daney wrote:
> Any userspace thread desiring a non-executable stack,
> must allocate a 4-byte aligned area at least 8 bytes long

<snip>

> +SYSCALL_DEFINE1(set_fpuemul_xol_area, unsigned long, addr)
> +{
> +	struct thread_info *ti = task_thread_info(current);
> +
> +	ti->fpu_emul_xol = addr;
> +	return 0;
> +}
> +

<snip>

> -	/* Ensure that the two instructions are in the same cache line */
> -	fr = (struct emuframe __user *)
> -		((regs->regs[29] - sizeof(struct emuframe)) & ~0x7);
> +	if (ti->fpu_emul_xol != ~0ul)
> +		fr = (struct emuframe *)ti->fpu_emul_xol;
> +	else
> +		/* Ensure that the two instructions are in the same cache line */
> +		fr = (struct emuframe __user *)
> +			((regs->regs[29] - sizeof(struct emuframe)) & ~0x7);

I know your patch was more an RFC, but on a technical note, this
comment/code seems to imply that the address should be 8 byte aligned
(rather than 4 byte) so they both land in the same cache line. Also, I
think the alignment should be validated in the syscall.

Cheers
James
