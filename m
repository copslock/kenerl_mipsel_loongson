Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Feb 2015 17:19:29 +0100 (CET)
Received: from mout.kundenserver.de ([212.227.126.130]:55795 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012516AbbBDQT2cos0h (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 4 Feb 2015 17:19:28 +0100
Received: from wuerfel.localnet ([149.172.15.242]) by mrelayeu.kundenserver.de
 (mreue005) with ESMTPSA (Nemesis) id 0MP3YZ-1YFTlH1FG3-006NOr; Wed, 04 Feb
 2015 17:19:04 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Cc:     linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, mturquette@linaro.org,
        sboyd@codeaurora.org, ralf@linux-mips.org, jslaby@suse.cz,
        tglx@linutronix.de, jason@lakedaemon.net, lars@metafoo.de,
        paul.burton@imgtec.com
Subject: Re: [PATCH_V2 11/34] MIPS: jz4740: register an irq_domain for the interrupt controller
Date:   Wed, 04 Feb 2015 17:19:01 +0100
Message-ID: <27674856.cQPkonRYdW@wuerfel>
User-Agent: KMail/4.11.5 (Linux/3.16.0-10-generic; KDE/4.11.5; x86_64; ; )
In-Reply-To: <1423063323-19419-12-git-send-email-Zubair.Kakakhel@imgtec.com>
References: <1423063323-19419-1-git-send-email-Zubair.Kakakhel@imgtec.com> <1423063323-19419-12-git-send-email-Zubair.Kakakhel@imgtec.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID:  V03:K0:KE160W1LFcl9uiNuK110Jo9L5QXFAAjLVC+67c2NFlK9kw08agv
 nx5Y0DltWdNWOysgHjK0txNIIkGgz+8iywp7vHLB0uzB76F7HAm5Wa4kQ6Xka0zaZVHEdn3
 3W05ECkkRNVbNkxM6WnsXLH16DvL4fP+HTdfDLxt5TGtQ3nTnWOgIjKbkqnG2yU+CoN2+Os
 +5mjoTLV0u1D8IDcSpj9w==
X-UI-Out-Filterresults: notjunk:1;
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45689
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

On Wednesday 04 February 2015 15:21:40 Zubair Lutfullah Kakakhel wrote:
> +       domain = irq_domain_add_legacy(node, num_chips * 32, JZ4740_IRQ_BASE, 0,
> +                                      &irq_domain_simple_ops, NULL);
> +       if (!domain)
> +               pr_warn("unable to register IRQ domain\n");
> +
>         setup_irq(parent_irq, &jz4740_cascade_action);

Can you use the linear domain instead, or do you still require devices
that are hardcoded in the platform code rather than DT?

	Arnd
