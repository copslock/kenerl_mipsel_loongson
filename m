Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Sep 2006 16:57:29 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.191]:30669 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20038966AbWIZP50 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 26 Sep 2006 16:57:26 +0100
Received: by nf-out-0910.google.com with SMTP id l23so235743nfc
        for <linux-mips@linux-mips.org>; Tue, 26 Sep 2006 08:57:26 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=rWWcak18juvALB3umGsq28Klr6iE5mvPBIPaqz4jCkBqP7tfeq/FEx/f+afZUMu+XglYbWTMFf9EsNiOjK0BmXGFcFXEyY0XgDwD/iMMECbDYzdBgERxLVyOohcyY5IK4++gH2cg2knPc51OeAW2btV9093zN09UGvoDc7XFFNw=
Received: by 10.49.8.4 with SMTP id l4mr1190868nfi;
        Tue, 26 Sep 2006 08:57:26 -0700 (PDT)
Received: from ?192.168.0.24? ( [81.252.61.1])
        by mx.gmail.com with ESMTP id q27sm1585505nfc.2006.09.26.08.57.24;
        Tue, 26 Sep 2006 08:57:24 -0700 (PDT)
Message-ID: <45194E14.10203@innova-card.com>
Date:	Tue, 26 Sep 2006 17:58:12 +0200
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	linux-mips@linux-mips.org, ralf@linux-mips.org, mingo@redhat.com
Subject: Re: [PATCH 2/3] [MIPS] lockdep: add STACKTRACE_SUPPORT and enable
 LOCKDEP_SUPPORT
References: <20060926.234401.08077257.anemo@mba.ocn.ne.jp>
In-Reply-To: <20060926.234401.08077257.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12683
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Hi Atsushi

Atsushi Nemoto wrote:
> Implement stacktrace interface by using unwind_stack().
> And enable lockdep support.
> 
[snip]
> + */
> +static inline void
> +save_raw_context_stack(struct stack_trace *trace, unsigned int skip,
> +		       unsigned long reg29)
> +{
[snip]
> +
> +static inline struct pt_regs *
> +save_context_stack(struct stack_trace *trace, unsigned int skip,
> +		   struct task_struct *task, struct pt_regs *regs)
> +{
> +	unsigned long sp = regs->regs[29];

Any reasons why marking these 2 functions as inlined ? IMHO gcc is now
good enough for this decision.

		Franck
