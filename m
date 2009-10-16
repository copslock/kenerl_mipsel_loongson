Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Oct 2009 13:52:40 +0200 (CEST)
Received: from mail-px0-f189.google.com ([209.85.216.189]:60152 "EHLO
	mail-px0-f189.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493593AbZJPLwd (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 16 Oct 2009 13:52:33 +0200
Received: by pxi27 with SMTP id 27so1722139pxi.22
        for <multiple recipients>; Fri, 16 Oct 2009 04:52:26 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=r04+XZ5pc95a6TBKCpo6MfnbvRuHr3AOq7xkJtaXFD4=;
        b=KHD6XAfyzL2OrsOWW3vwTZ4g6njBFRVmXpsu3QRqYO40tbRcEnK8GyBfJG2xWOEWY6
         SUzpeqGLPMTZoKJtEQER2unXLumi9r5NIMeecuQFflRCahkFqucPtoMfaBoj4HDIKiQt
         sVfyARsP5JtnosLbfJ62t2B8dLJaoO2RGcF6o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=wYAQ38mZ1wLmu/bqqZsx5DUSFw9waVKwdgbt1hsy/tebUWr2Ga+2p5PbR973XGjs63
         zavOQYqtA13l6wgzPekNQ648tPF/OZQqyCjTDjZadxI8xOZec5suAQCGzACMrzUcf6db
         Jz8xykb3nGaOiOazf7eMPJpXI8jsg09hygCC0=
Received: by 10.114.50.17 with SMTP id x17mr1475471wax.168.1255693946314;
        Fri, 16 Oct 2009 04:52:26 -0700 (PDT)
Received: from hack ([58.31.79.117])
        by mx.google.com with ESMTPS id 23sm741154pzk.12.2009.10.16.04.52.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 16 Oct 2009 04:52:25 -0700 (PDT)
Date:	Fri, 16 Oct 2009 19:52:14 +0800
From:	=?utf-8?Q?Am=C3=A9rico?= Wang <xiyou.wangcong@gmail.com>
To:	Wu Zhangjin <wuzhangjin@gmail.com>
Cc:	linux-kernel@vger.kernel.org,
	linux-mips <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@elte.hu>,
	Manuel Lauss <manuel.lauss@googlemail.com>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH 1/2] tracing: convert trace_clock_local() as weak
	function
Message-ID: <20091016115214.GA3159@hack>
References: <4205779ae74d7c4144ee6cbf4e3f15f833646356.1255692619.git.wuzhangjin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4205779ae74d7c4144ee6cbf4e3f15f833646356.1255692619.git.wuzhangjin@gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <xiyou.wangcong@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24366
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: xiyou.wangcong@gmail.com
Precedence: bulk
X-list: linux-mips

On Fri, Oct 16, 2009 at 07:38:24PM +0800, Wu Zhangjin wrote:
>trace_clock_local() is based on the arch-specific sched_clock(), in X86,
>it is tsc(64bit) based, which can give very high precision(about 1ns
>with 1GHz). but in MIPS, the sched_clock() is jiffies based, which can
>give only 10ms precison with 1000 HZ. which is not enough for tracing,
>especially for Real Time system.
>
>so, we need to implement a MIPS specific sched_clock() to get higher
>precision. There is a tsc like clock counter register in MIPS, whose
>frequency is half of the processor, so, if the cpu frequency is 800MHz,
>the time precision reaches 2.5ns, which is very good for tracing, even
>for Real Time system.
>
>but 'Cause it is only 32bit long, which will rollover quickly, so, such
>a sched_clock() will bring with extra load, which is not good for the
>whole system. so, we only need to implement a arch-specific
>trace_clock_local() for tracing. as a preparation, we convert it as a
>weak function.
>
>The MIPS specific trace_clock_local() is coming in the next patch.
>
>Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
>---
> kernel/trace/trace_clock.c |    2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)
>
>diff --git a/kernel/trace/trace_clock.c b/kernel/trace/trace_clock.c
>index 20c5f92..a04dc18 100644
>--- a/kernel/trace/trace_clock.c
>+++ b/kernel/trace/trace_clock.c
>@@ -26,7 +26,7 @@
>  * Useful for tracing that does not cross to other CPUs nor
>  * does it go through idle events.
>  */
>-u64 notrace trace_clock_local(void)
>+u64 __attribute__((weak)) notrace trace_clock_local(void)

We have __weak.


> {
> 	unsigned long flags;
> 	u64 clock;
>-- 
>1.6.2.1
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
Live like a child, think like the god.
 
