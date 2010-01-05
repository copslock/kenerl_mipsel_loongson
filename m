Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Jan 2010 10:04:38 +0100 (CET)
Received: from mail-pw0-f45.google.com ([209.85.160.45]:63902 "EHLO
        mail-pw0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490985Ab0AEJEf convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 5 Jan 2010 10:04:35 +0100
Received: by pwj1 with SMTP id 1so10227251pwj.24
        for <multiple recipients>; Tue, 05 Jan 2010 01:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=tccDM0Qe8mSQVdIqClWAw/kADLps4idUuTg9kIjhSZk=;
        b=E4FESs50oIyxVhRLVJ+XKFj6Xb81nBHHLdedL1K5nv/6IKTzDlKxb1rsEgN0lAbRgC
         9GDFw57g+kYl/xUYaiXmbDuLC09kKUkLxhcKOtfdxxnKNwMbFhMX0btN6Qr9bFMy/YAH
         PJ8RxolD+bmoHEcOoAE2o63AHJU1qfMgGxR/Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=nws820z5bCvmcMS/BKOusJn404uNnkqjruDBiOMv7bNGtDuSxrJBxgIzHdz9OHIBN9
         3R3nqYATKWtHf/ebOWRbv8hEU8ClRtFtDwy3sxuojqFxsjy2WV3QkDvfytOSSc7UReXq
         CYsh5veyQUbT9r1Fh1AxdprNbvxewoPwJIewA=
MIME-Version: 1.0
Received: by 10.142.1.22 with SMTP id 22mr14966512wfa.303.1262682267605; Tue, 
        05 Jan 2010 01:04:27 -0800 (PST)
In-Reply-To: <4B4273D6.2010306@kernel.org>
References: <daef60381001030705r93b3fbfkc50e7b9bbc62b334@mail.gmail.com> 
        <4B411F14.1040302@kernel.org> <20100103150134.5bdab023@infradead.org> 
        <4B412341.2010002@kernel.org> <20100103151406.20228c3a@infradead.org> 
        <daef60381001040822q188d7374te5a177c5f9877ac2@mail.gmail.com> 
        <4B4273D6.2010306@kernel.org>
From:   Hui Zhu <teawater@gmail.com>
Date:   Tue, 5 Jan 2010 17:04:07 +0800
Message-ID: <daef60381001050104u5d4adf11k16bec2406501fbd2@mail.gmail.com>
Subject: Re: [PATCH] stack2core: show stack message and convert it to core 
        file when kernel die
To:     Tejun Heo <tj@kernel.org>
Cc:     Arjan van de Ven <arjan@infradead.org>,
        Russell King <linux@arm.linux.org.uk>,
        saeed bishara <saeed.bishara@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Nicolas Pitre <nico@fluxnic.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Daney <ddaney@caviumnetworks.com>,
        Tomaso Paoletti <tpaoletti@caviumnetworks.com>,
        Chris Dearman <chris@mips.com>,
        Paul Gortmaker <Paul.Gortmaker@windriver.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Brian Gerst <brgerst@gmail.com>,
        Rusty Russell <rusty@rustcorp.com.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@suse.de>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, Coly Li <coly.li@suse.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-archive-position: 25514
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: teawater@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 3134

Hi,

I agree with read the current stack message is better.

About the extending, I have some question with it:
1.  markup_oops.pl have itself idea, it try use dmesg| markup_oops.pl
show what happen to usr.  This is different with s2c.
I am not sure people like it have other function with it.  Too much
part of this file need to be change.  It need rewrite, just the oops
message parse part can be keep.

2.  I use perl to work in a long time before, I know it good at parse
the text, but I am not sure it good at handle struct like:
struct mips64_elf_prstatus
{
	struct s2c_elf_siginfo	pr_info;
	uint16_t		pr_cursig;
	uint64_t		pr_sigpend;
	uint64_t		pr_sighold;
	uint32_t		pr_pid;
	uint32_t		pr_ppid;
	uint32_t		pr_pgrp;
	uint32_t		pr_sid;
	struct s2c_timeval_64	pr_utime;
	struct s2c_timeval_64	pr_stime;
	struct s2c_timeval_64	pr_cutime;
	struct s2c_timeval_64	pr_cstime;

	uint64_t		pr_reg[45];

	uint32_t		pr_fpvalid;
} __attribute__ ((aligned(8)));
Even if what happen, I will keep a c s2c with myself.  :)

Best regards,
Hui

On Tue, Jan 5, 2010 at 07:03, Tejun Heo <tj@kernel.org> wrote:
> Hello,
>
> On 01/05/2010 01:22 AM, Hui Zhu wrote:
>> For the s2c, user just "s2c < message >core" It did everything with itself.
>> After that, gdb vmlinux core.
>
> It is true that by making the kernel oops message more verbose, s2c
> can be made way simpler.  However, dependence on standard object tools
> or perl is already assumed and avoiding it doesn't really buy
> anything.  I really like the idea but unfortunately I'm doubtful that
> it will be able to go upstream in the current form.  The suggested
> solution (extending markup_oops.pl) won't be too much work, most of
> functionality will remain the same and will have much higher chance of
> getting included.
>
> Thanks.
>
> --
> tejun
>
