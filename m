Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Nov 2016 22:27:31 +0100 (CET)
Received: from frisell.zx2c4.com ([192.95.5.64]:59340 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993030AbcKIV1ZO0ti1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 9 Nov 2016 22:27:25 +0100
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 3b1bfaf8
        for <linux-mips@linux-mips.org>;
        Wed, 9 Nov 2016 21:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :from:date:message-id:subject:to:cc:content-type; s=mail; bh=fwR
        cFtMMhlQoQKQbpn4ZvB4JQSo=; b=26pT9GItiiUAquD4LCaSWfGwxp5oYt1pWGZ
        ucM+9ruysIeL5QR8kK2vr2QzXt+m4K3y64WqJS5jQPgAI/niF+q30ITWuGET+Glt
        ggi7SEjpq6oEReljhZbzCMeRCDkoCEa9dQZREu3AiZKDfBUSVaA87DhCWB4Za0+G
        8/wfkVW1OUen5Z2A+8H9MQxF0EyCWtyKveJ6jh9U2GDEPClgJL0ma+u746lbqjoH
        fvzQmCdXLpZux7GK3WiA6djs1F1gcUU+gSarEubAS80TCZBl9r5Do2Hv/Kre78mf
        8SgOBZ+g77MLBTMsRIGC0nfdHKGnVpgDjEsuoSNw8JlLJdDmIKg==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id f91456ea (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO)
        for <linux-mips@linux-mips.org>;
        Wed, 9 Nov 2016 21:25:15 +0000 (UTC)
Received: by mail-lf0-f44.google.com with SMTP id t196so175160061lff.3
        for <linux-mips@linux-mips.org>; Wed, 09 Nov 2016 13:27:16 -0800 (PST)
X-Gm-Message-State: ABUngveAF0PDO8AMf2lF8kIY/eHmzOBaIeWqQ6kTmNLAgBNuHhnqlJsvcSxWXyhPtBBnIAO1l/hKbi8O1CAW/Q==
X-Received: by 10.25.18.199 with SMTP id 68mr715650lfs.180.1478726834475; Wed,
 09 Nov 2016 13:27:14 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.208.80 with HTTP; Wed, 9 Nov 2016 13:27:13 -0800 (PST)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 9 Nov 2016 22:27:13 +0100
X-Gmail-Original-Message-ID: <CAHmME9oSUcAXVMhpLt0bqa9DKHE8rd3u+3JDb_wgviZnOpP7JA@mail.gmail.com>
Message-ID: <CAHmME9oSUcAXVMhpLt0bqa9DKHE8rd3u+3JDb_wgviZnOpP7JA@mail.gmail.com>
Subject: Proposal: HAVE_SEPARATE_IRQ_STACK?
To:     LKML <linux-kernel@vger.kernel.org>, linux-mips@linux-mips.org,
        linux-mm@kvack.org, Thomas Gleixner <tglx@linutronix.de>
Cc:     WireGuard mailing list <wireguard@lists.zx2c4.com>, k@vodka.home.kg
Content-Type: text/plain; charset=UTF-8
Return-Path: <Jason@zx2c4.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55756
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Jason@zx2c4.com
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

Hi folks,

I do some ECC crypto in a kthread. A fast 32bit implementation usually
uses around 2k - 3k bytes of stack. Since kernel threads get 8k, I
figured this would be okay. And for the most part, it is. However,
everything falls apart on architectures like MIPS, which do not use a
separate irq stack.

From what I can tell, on MIPS, the irq handler uses whichever stack
was in current at the time of interruption. At the end of the irq
handler, softirqs trigger if preemption hasn't been disabled. When the
softirq handler runs, it will still use the same interrupted stack. So
let's take some pathological case of huge softirq stack usage: wifi
driver inside of l2tp inside of gre inside of ppp. Now, my ECC crypto
is humming along happily in its kthread, when all of the sudden, a
wifi packet arrives, triggering the interrupt. Or, perhaps instead,
TCP sends an ack packet on softirq, using my kthread's stack. The
interrupt is serviced, and at the end of it, softirq is serviced,
using my kthread's stack, which was already half full. When this
softirq is serviced, it goes through our 4 layers of network device
drivers. Since we started with a half full stack, we very quickly blow
it up, and everything explodes, and users write angry mailing list
posts.

It seems to me x86, ARM, SPARC, SH, ParisC, PPC, Metag, and UML all
concluded that letting the interrupt handler use current's stack was a
terrible idea, and instead have a per-cpu irq stack that gets used
when the handler is service. Whew!

But for the remaining platforms, such as MIPS, this is still a
problem. In an effort to work around this in my code, rather than
having to invoke kmalloc for what should be stack-based variables, I
was thinking I'd just disable preemption for those functions that use
a lot of stack, so that stack-hungry softirq handlers don't crush it.
This is generally unsatisfactory, so I don't want to do this
unconditionally. Instead, I'd like to do some cludge such as:

    #ifndef CONFIG_HAVE_SEPARATE_IRQ_STACK
    preempt_disable();
    #endif

    some_func_that_uses_lots_of_stack();

    #ifndef CONFIG_HAVE_SEPARATE_IRQ_STACK
    preempt_enable();
    #endif

However, for this to work, I actual need that config variable. Would
you accept a patch that adds this config variable to the relavent
platforms? If not, do you have a better solution for me (which doesn't
involve using kmalloc or choosing a different crypto primitive)?

Thanks,
Jason
