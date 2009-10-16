Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Oct 2009 13:59:56 +0200 (CEST)
Received: from mail-px0-f189.google.com ([209.85.216.189]:58369 "EHLO
	mail-px0-f189.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493600AbZJPL7u (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 16 Oct 2009 13:59:50 +0200
Received: by pxi27 with SMTP id 27so1726305pxi.22
        for <multiple recipients>; Fri, 16 Oct 2009 04:59:43 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=wiIQo6p8mZyV2YXZLs0gtpIQsk/S0BChS+ui7bUavBU=;
        b=NSNe7gRAR1whv2BpeVfeB+jw1bfEXvVIaXodPdUuuHKKlr/PQuSSHqZ76O6CNKQb8o
         /kHv4TC5OQ2YzWEjT3KiguBmjXiwWfIwf+aDMdS2PjBOSFF7+Zu8+0THC27B+mnrKWpf
         XlYBHPzY4etMBFiFkWYhaGKvU2mEHw1hIXll8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=Kvnug8mUJfUSWq+jaZFnlXqb+EKNmIsFQ1MuEdMb9MsVD9hZCFyzwGmEoSEczNfzjP
         lRzVRDHVAF+2G5QoW+XZFQKkahElOdGW+xQgE9ALhK+ypo5k/nrNJKIyB8yFVvyzCx6K
         Z/UFelIz1Iu6KEGhudQTlAFy3j3q+lsBDo0Tc=
Received: by 10.115.20.11 with SMTP id x11mr1450634wai.220.1255694383195;
        Fri, 16 Oct 2009 04:59:43 -0700 (PDT)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 20sm656732pxi.11.2009.10.16.04.59.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 16 Oct 2009 04:59:42 -0700 (PDT)
Subject: Re: [PATCH 1/2] tracing: convert trace_clock_local() as weak
 function
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	=?ISO-8859-1?Q?Am=E9rico?= Wang <xiyou.wangcong@gmail.com>
Cc:	linux-kernel@vger.kernel.org,
	linux-mips <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@elte.hu>,
	Manuel Lauss <manuel.lauss@googlemail.com>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20091016115214.GA3159@hack>
References: <4205779ae74d7c4144ee6cbf4e3f15f833646356.1255692619.git.wuzhangjin@gmail.com>
	 <20091016115214.GA3159@hack>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:	Fri, 16 Oct 2009 19:59:32 +0800
Message-Id: <1255694372.7084.3.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.26.1 
Content-Transfer-Encoding: 8bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24367
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Fri, 2009-10-16 at 19:52 +0800, Américo Wang wrote:
> On Fri, Oct 16, 2009 at 07:38:24PM +0800, Wu Zhangjin wrote:
> >trace_clock_local() is based on the arch-specific sched_clock(), in X86,
> >it is tsc(64bit) based, which can give very high precision(about 1ns
> >with 1GHz). but in MIPS, the sched_clock() is jiffies based, which can
> >give only 10ms precison with 1000 HZ. which is not enough for tracing,
> >especially for Real Time system.
> >
> >so, we need to implement a MIPS specific sched_clock() to get higher
> >precision. There is a tsc like clock counter register in MIPS, whose
> >frequency is half of the processor, so, if the cpu frequency is 800MHz,
> >the time precision reaches 2.5ns, which is very good for tracing, even
> >for Real Time system.
> >
> >but 'Cause it is only 32bit long, which will rollover quickly, so, such
> >a sched_clock() will bring with extra load, which is not good for the
> >whole system. so, we only need to implement a arch-specific
> >trace_clock_local() for tracing. as a preparation, we convert it as a
> >weak function.
> >
> >The MIPS specific trace_clock_local() is coming in the next patch.
> >
> >Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
> >---
> > kernel/trace/trace_clock.c |    2 +-
> > 1 files changed, 1 insertions(+), 1 deletions(-)
> >
> >diff --git a/kernel/trace/trace_clock.c b/kernel/trace/trace_clock.c
> >index 20c5f92..a04dc18 100644
> >--- a/kernel/trace/trace_clock.c
> >+++ b/kernel/trace/trace_clock.c
> >@@ -26,7 +26,7 @@
> >  * Useful for tracing that does not cross to other CPUs nor
> >  * does it go through idle events.
> >  */
> >-u64 notrace trace_clock_local(void)
> >+u64 __attribute__((weak)) notrace trace_clock_local(void)
> 
> We have __weak.
> 

Thanks, will use it in the next version.

Regards,
	Wu Zhangjin
