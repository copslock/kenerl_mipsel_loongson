Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Apr 2017 03:35:50 +0200 (CEST)
Received: from mail-pf0-x241.google.com ([IPv6:2607:f8b0:400e:c00::241]:35909
        "EHLO mail-pf0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993879AbdD1BfnRwYjn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 28 Apr 2017 03:35:43 +0200
Received: by mail-pf0-x241.google.com with SMTP id v14so14994595pfd.3;
        Thu, 27 Apr 2017 18:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ax2RoY4lW4ift84HKOfRqhKdcL7PCtsI+nkzslElg4A=;
        b=TohMlFLoG9KPUuHybRzIB7luE//lswJe+vA5SBFT+5dcuaqTes82kvkynTPS4s5p11
         lbcfu8O6WXwuNms8SJTsZ61tPgyFz5LWHVQfnkGN/tyG9rFRuCV2ns/PIZHsYNmvuq5y
         JoM6V/YPPywalZgY3AAlRJ6yKe1kfpg81p0BR+GNRDJAl/Hnjdgj5vo9kNk0QW4fsI03
         IpcRJIhYoj9lKDzOCkIsdzyvXNivNFFHafzPZ6UJDIc5VI8S1C+QM+Ge9a/0zdZXWYdS
         UqVbJXoaiILMR6CanWEySFYWQ7u7pLTumeKZyj84lAaIVkKTIihKCZOc/JC4wAWvFe+z
         WfUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ax2RoY4lW4ift84HKOfRqhKdcL7PCtsI+nkzslElg4A=;
        b=NgP5gyCdm3srEwq43Ed2EiySzBbBFhNoOvYLxo0ccXonQ9Qrk15ypLK4arbkWknxJD
         CKRgWu+ilY7I/DZ+1MO0TYxcpfAwknKeMf+K/kMG7xDJgcXpUvS3PDTbmqAgHCzx5FxC
         J0PSDkSiu+lIKlMJ35W63XssLMGQTacg8hLud8izZA7ffXn2aud0HGx93P2g081ure1V
         5k23a+Nm3vSuSWq42F/yyuoqOOk3tMTq9CIztWSSmNAXQ4v4CTmtsoHilihhPj1Oszxv
         20PC7JJpEB/liwmP8gTj5j5Gm4D9SWsw6C0tLVHCJYGKDuJQIlTCI2aTFOZfbfYkiNZQ
         q/6Q==
X-Gm-Message-State: AN3rC/4o3g11PkBuy2u4oVJT/puwGldadAlquRV7j/Pde9SEXOAN51Qk
        UshcS2gClFWKug==
X-Received: by 10.99.104.9 with SMTP id d9mr9202945pgc.27.1493343336469;
        Thu, 27 Apr 2017 18:35:36 -0700 (PDT)
Received: from localhost ([110.70.54.84])
        by smtp.gmail.com with ESMTPSA id m187sm597064pfm.132.2017.04.27.18.35.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Apr 2017 18:35:35 -0700 (PDT)
Date:   Fri, 28 Apr 2017 10:35:32 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jiri Kosina <jkosina@suse.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
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
Message-ID: <20170428013532.GB383@jagdpanzerIV.localdomain>
References: <1461239325-22779-1-git-send-email-pmladek@suse.com>
 <1461239325-22779-2-git-send-email-pmladek@suse.com>
 <20170419131341.76bc7634@gandalf.local.home>
 <20170420033112.GB542@jagdpanzerIV.localdomain>
 <20170420131154.GL3452@pathway.suse.cz>
 <20170427121458.2be577cc@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170427121458.2be577cc@gandalf.local.home>
User-Agent: Mutt/1.8.2 (2017-04-18)
Return-Path: <sergey.senozhatsky.work@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57804
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

On (04/27/17 12:14), Steven Rostedt wrote:
[..]
> I tried this patch. It's better because I get the end of the trace, but
> I do lose the beginning of it:
> 
> ** 196358 printk messages dropped ** [  102.321182]     perf-5981    0.... 12983650us : d_path <-seq_path

many thanks!

so we now drop messages from logbuf, not from per-CPU buffers. that
"queue printk_deferred irq_work on every online CPU when we bypass per-CPU
buffers from NMI" idea *probably* might help here - we need someone to emit
messages from the logbuf while we printk from NMI. there is still a
possibility that we can drop messages, though, since log_store() from NMI
CPU can be much-much faster than call_console_drivers() on other CPU.

	-ss
