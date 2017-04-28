Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Apr 2017 16:17:15 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.136]:37024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991672AbdD1ORHAkccZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 28 Apr 2017 16:17:07 +0200
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id 6D66A20274;
        Fri, 28 Apr 2017 14:17:04 +0000 (UTC)
Received: from gandalf.local.home (cpe-67-246-153-56.stny.res.rr.com [67.246.153.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F0DF20251;
        Fri, 28 Apr 2017 14:17:00 +0000 (UTC)
Date:   Fri, 28 Apr 2017 10:16:59 -0400
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
Message-ID: <20170428101659.7cd879e7@gandalf.local.home>
In-Reply-To: <20170428125725.GA3452@pathway.suse.cz>
References: <1461239325-22779-1-git-send-email-pmladek@suse.com>
        <1461239325-22779-2-git-send-email-pmladek@suse.com>
        <20170419131341.76bc7634@gandalf.local.home>
        <20170420033112.GB542@jagdpanzerIV.localdomain>
        <20170420131154.GL3452@pathway.suse.cz>
        <20170427121458.2be577cc@gandalf.local.home>
        <20170428013532.GB383@jagdpanzerIV.localdomain>
        <20170428125725.GA3452@pathway.suse.cz>
X-Mailer: Claws Mail 3.14.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <SRS0=N7JN=4E=goodmis.org=rostedt@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57816
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

On Fri, 28 Apr 2017 14:57:25 +0200
Petr Mladek <pmladek@suse.com> wrote:


> Of course, if the problem is reproducible, the easiest solution
> is to use bigger main log buffer, for example boot with
> log_buf_len=32M.

Of course that may not be enough. Especially when I have a machine with
240 CPUs. But it also has a ton of RAM, I could easily do
log_buf_len=32G

-- Steve
