Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Apr 2017 05:31:23 +0200 (CEST)
Received: from mail-io0-x243.google.com ([IPv6:2607:f8b0:4001:c06::243]:33080
        "EHLO mail-io0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990686AbdDTDbPOJ8fG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 20 Apr 2017 05:31:15 +0200
Received: by mail-io0-x243.google.com with SMTP id k87so11114277ioi.0;
        Wed, 19 Apr 2017 20:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NJqQV0LcGDcEsCyJBhbKZ0WmO5np3Rzoh+FFfAyma2c=;
        b=IYGykPtqWwPau8p7V29c+Zj1NXP4bpPoa21ylv1m7aXwMPyPbLSBfBRfDlrhFyXynx
         1l1AUKAB0mpdIWzgiEZrF/wro6mBdRKJmvdYxDh3pcrnXpYM2amIP9iseyAv7t2P46v8
         aeVUEAF368gpzEQqcoBxyyxdXpFPnDCUJZZY2WVIhaN7juyDFU131v4ArqBM73bhbnjh
         5mWmmASasUQWbfWEyzPB3loJLc8lZWz3+Zr6wbTeb17gGB9bwt7F+F+nqSRDhgdLal6D
         zs1jgkbtmN+jg5yIYpGRvRcUbZWz/jouHedJxYRMbMrMujr1nAP21ASP2qSpaJ3WPNPG
         e+Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NJqQV0LcGDcEsCyJBhbKZ0WmO5np3Rzoh+FFfAyma2c=;
        b=QNCloRwMmBE6e7BB4DiGdSh62uJYCpkSJmy54bfcV9HPM22uaxVTtf32JmMQQntWBT
         r1gjRzlf3BTCCa/h1+ewfajImsdPYsCVL9rFL5Y+VDDCuS6JUo/LL5a3bobQG4JXNZ1p
         wK/5IM34sXWUfgND2C8JWnkX6MjWxAUh3aUaeRrvEYrf9NhpYno5pSuU1xqr1YmLwepf
         39m3mT75ULR0hJWDVpltAGsiIFcAP7qzF0u0nkOZ8GKocWEsBxWKEBKKboDTLn/ATkp8
         g8T/0Fq0Fb2cOR/D5x8EC9K6G6KIBJ4ezR0VGGUvZFoE6amPFBA6pm6amJMbshmsZD9j
         leyw==
X-Gm-Message-State: AN3rC/7fURatglz7yiWr5wshYNQJOSfGqBFK+aIaV2+mrtHhAcKdZfSU
        94ZeGcWY0kUkRQ==
X-Received: by 10.84.222.129 with SMTP id x1mr7823486pls.44.1492659069384;
        Wed, 19 Apr 2017 20:31:09 -0700 (PDT)
Received: from localhost ([175.223.2.161])
        by smtp.gmail.com with ESMTPSA id g75sm6952933pfg.82.2017.04.19.20.31.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Apr 2017 20:31:08 -0700 (PDT)
Date:   Thu, 20 Apr 2017 12:31:12 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
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
Message-ID: <20170420033112.GB542@jagdpanzerIV.localdomain>
References: <1461239325-22779-1-git-send-email-pmladek@suse.com>
 <1461239325-22779-2-git-send-email-pmladek@suse.com>
 <20170419131341.76bc7634@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170419131341.76bc7634@gandalf.local.home>
User-Agent: Mutt/1.8.2 (2017-04-18)
Return-Path: <sergey.senozhatsky.work@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57734
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sergey.senozhatsky.work@gmail.com
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

Hello Steven,

On (04/19/17 13:13), Steven Rostedt wrote:
> > printk() takes some locks and could not be used a safe way in NMI context.
> 
> I just found a problem with this solution. It kills ftrace dumps from
> NMI context :-(
> 
> [ 1295.168495]    <...>-67423  10dNh1 382171111us : do_raw_spin_lock <-_raw_spin_lock
> [ 1295.168495]    <...>-67423  10dNh1 382171111us : sched_stat_runtime: comm=cc1 pid=67423 runtime=96858 [ns] vruntime=11924198270 [ns]
> [ 1295.168496]    <...>-67423  10dNh1 382171111us : lock_acquire: ffffffff81c5c940 read rcu_read_lock
> [ 1295.168497]
> [ 1295.168498] Lost 4890096 message(s)!
> [ 1296.805063] ---[ end Kernel panic - not syncing: Hard LOCKUP
> [ 1296.811553] unchecked MSR access error: WRMSR to 0x83f (tried to write 0x00000000000000f6) at rIP: 0xffffffff81046fc7 (native_apic_msr_write+0x27/0x40)
> [ 1296.811553] Call Trace:
> [ 1296.811553]  <NMI>
> 
> I was hoping to see a cause of a hard lockup by enabling
> ftrace_dump_on_oops. But as NMIs now have a very small buffer that
> gets flushed, we need to find a new way to print out the full ftrace
> buffer over serial.
> 
> Thoughts?

hmmm... a really tough one.

well, someone has to say this:
 the simplest thing is to have a bigger PRINTK_SAFE_LOG_BUF_SHIFT value :)


just thinking (well, sort of) out loud. the problem is that we can't tell if
we already hold any printk related locks ("printk related locks" is not even
well defined term). so printk from NMI can deadlock or it can be OK, we
never know. but looking and vprintk_emit() and console_unlock() it seems that
we have some sort of a hint now, which is this_cpu_read(printk_context) - if
we are not in printk_safe context then we can say that _probably_ (and that's
a Russian roulette) doing "normal" printk() will work. that is a *very-very*
risky (and admittedly dumb) thing to assume, so we will move in a slightly
different direction. checking this_cpu_read(printk_context) only assures us
that we don't hold `logbuf_lock' on this CPU. and that is sort of something,
at least we can be sure that doing printk_deferred() from this CPU is safe.
printk_deferred() means that your NMI messages will end up in the logbuf,
which is a) bigger in size than per-CPU buffer and b) some other CPU can
immediately print those messages (hopefully).

we also switch to printk_safe mode for call_console_drivers() in
console_unlock(). but we can't make any solid assumptions there - serial
console lock can already be acquired, we don't have any markers for that.
it may be reasonable to assume that if we are not in printk_safe mode on
this CPU then serial console is not locked from this CPU, but there is
nothing that can assure us.

so at the moment what I can think of is something like

  -- check this_cpu_read(printk_context) in NMI prink

	-- if we are NOT in printk_safe on this CPU, then do printk_deferred()
	   and bypass `nmi_print_seq' buffer

	-- if we are in printk_safe
	  -- well... bad luck... have a bigger buffer.

		.... or there are some other options here, but I'd prefer
		not to list them, because people will hate me :)


so this shifts the purpose of `nmi_print_seq' buffer: use it only when
you can't use logbuf. otherwise, do printk_deferred().


need to think more.

	-ss
