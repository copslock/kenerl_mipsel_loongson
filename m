Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Apr 2017 16:31:36 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.136]:60148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991965AbdD0Ob1qVk92 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 27 Apr 2017 16:31:27 +0200
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id 1090B202FF;
        Thu, 27 Apr 2017 14:31:25 +0000 (UTC)
Received: from gandalf.local.home (cpe-67-246-153-56.stny.res.rr.com [67.246.153.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E981202B8;
        Thu, 27 Apr 2017 14:31:21 +0000 (UTC)
Date:   Thu, 27 Apr 2017 10:31:18 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
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
Message-ID: <20170427103118.56351d30@gandalf.local.home>
In-Reply-To: <20170427133819.GW3452@pathway.suse.cz>
References: <1461239325-22779-1-git-send-email-pmladek@suse.com>
        <1461239325-22779-2-git-send-email-pmladek@suse.com>
        <20170419131341.76bc7634@gandalf.local.home>
        <20170420033112.GB542@jagdpanzerIV.localdomain>
        <20170420131154.GL3452@pathway.suse.cz>
        <20170421015724.GA586@jagdpanzerIV.localdomain>
        <20170421120627.GO3452@pathway.suse.cz>
        <20170424021747.GA630@jagdpanzerIV.localdomain>
        <20170427133819.GW3452@pathway.suse.cz>
X-Mailer: Claws Mail 3.14.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <SRS0=kAy7=4D=goodmis.org=rostedt@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57798
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

On Thu, 27 Apr 2017 15:38:19 +0200
Petr Mladek <pmladek@suse.com> wrote:

> > by the way,
> > does this `nmi_print_seq' bypass even fix anything for Steven?  
> 
> I think that this is the most important question.
> 
> Steven, does the patch from
> https://lkml.kernel.org/r/20170420131154.GL3452@pathway.suse.cz
> help you to see the debug messages, please?

You'll have to wait for a bit. The box that I was debugging takes 45
minutes to reboot. And I don't have much more time to play on it before
I have to give it back. I already found the bug I was looking for and
I'm trying not to crash it again (due to the huge bring up time).

When I get a chance, I'll see if I can insert a trigger to crash the
kernel from NMI on another box and see if this patch helps.

Thanks,

-- Steve
