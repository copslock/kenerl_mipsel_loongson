Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Dec 2015 12:10:10 +0100 (CET)
Received: from mail-ob0-f169.google.com ([209.85.214.169]:35831 "EHLO
        mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007832AbbLKLKI61EAY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 11 Dec 2015 12:10:08 +0100
Received: by obc18 with SMTP id 18so80281499obc.2
        for <linux-mips@linux-mips.org>; Fri, 11 Dec 2015 03:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=7mikNddyCN0ORGY489Hfcbv1xE9Joe5sEj9nvobw7Pk=;
        b=oVEyCWQDUtzqxyTWe4G0rArAVN0w07QAIVU49w+N2whU9w3bv6jirh9UF4HiuzpfAM
         aPSGRBV9PMQT4wjndU0dqogWCmNbVPlg2OCUpQ7PNPDgYrepffh+EQN/qkj9IapD0zhz
         uJGip0C+kM6koVKftKU+u8TxBKyRT4L/UC4wk76jSv+GYOUlPpUvGGxx5mAZ8Q+W6qfC
         vcTTbyGMctvpemBrM0KzGW34sr5hAggfNYmf41ZcFSjAlNkHOXKNt80gzpkb16VwFvOS
         a3wIHlpqdNcm2ihZXYGjx8Z4CA87kBiMBul0DcFAq7YW0JcuSUUz0yfrlfN2NKqxEnYm
         5gwQ==
MIME-Version: 1.0
X-Received: by 10.182.120.4 with SMTP id ky4mr13544062obb.16.1449832202684;
 Fri, 11 Dec 2015 03:10:02 -0800 (PST)
Received: by 10.60.233.35 with HTTP; Fri, 11 Dec 2015 03:10:02 -0800 (PST)
In-Reply-To: <1449667265-17525-5-git-send-email-pmladek@suse.com>
References: <1449667265-17525-1-git-send-email-pmladek@suse.com>
        <1449667265-17525-5-git-send-email-pmladek@suse.com>
Date:   Fri, 11 Dec 2015 12:10:02 +0100
X-Google-Sender-Auth: CsIvV8NVAYrLNBsuubq93hglviQ
Message-ID: <CAMuHMdXVgr58YjoePGrRbMyMncQ27f85prL7G5SpeHeNxoYrXQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] printk/nmi: Increase the size of NMI buffer and
 make it configurable
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jiri Kosina <jkosina@suse.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "adi-buildroot-devel@lists.sourceforge.net" 
        <adi-buildroot-devel@lists.sourceforge.net>,
        Cris <linux-cris-kernel@axis.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50543
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
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

On Wed, Dec 9, 2015 at 2:21 PM, Petr Mladek <pmladek@suse.com> wrote:
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -866,6 +866,28 @@ config LOG_CPU_MAX_BUF_SHIFT
>                      13 =>   8 KB for each CPU
>                      12 =>   4 KB for each CPU
>
> +config NMI_LOG_BUF_SHIFT
> +       int "Temporary per-CPU NMI log buffer size (12 => 4KB, 13 => 8KB)"
> +       range 10 21
> +       default 13
> +       depends on PRINTK && HAVE_NMI

Symbol NMI_LOG_BUF_SHIFT does not exist if its dependencies are not met.

> +       help
> +         Select the size of a per-CPU buffer where NMI messages are temporary
> +         stored. They are copied to the main log buffer in a safe context
> +         to avoid a deadlock. The value defines the size as a power of 2.
> +
> +         NMI messages are rare and limited. The largest one is when
> +         a backtrace is printed. It usually fits into 4KB. Select
> +         8KB if you want to be on the safe side.
> +
> +         Examples:
> +                    17 => 128 KB for each CPU
> +                    16 =>  64 KB for each CPU
> +                    15 =>  32 KB for each CPU
> +                    14 =>  16 KB for each CPU
> +                    13 =>   8 KB for each CPU
> +                    12 =>   4 KB for each CPU
> +
>  #
>  # Architectures with an unreliable sched_clock() should select this:
>  #
> diff --git a/kernel/printk/nmi.c b/kernel/printk/nmi.c
> index 5465230b75ec..78c07d441b4e 100644
> --- a/kernel/printk/nmi.c
> +++ b/kernel/printk/nmi.c
> @@ -41,7 +41,8 @@ DEFINE_PER_CPU(printk_func_t, printk_func) = vprintk_default;
>  static int printk_nmi_irq_ready;
>  atomic_t nmi_message_lost;
>
> -#define NMI_LOG_BUF_LEN (4096 - sizeof(atomic_t) - sizeof(struct irq_work))
> +#define NMI_LOG_BUF_LEN ((1 << CONFIG_NMI_LOG_BUF_SHIFT) -             \
> +                        sizeof(atomic_t) - sizeof(struct irq_work))

kernel/printk/nmi.c:50:24: error: 'CONFIG_NMI_LOG_BUF_SHIFT'
undeclared here (not in a function)

E.g. efm32_defconfig
http://kisskb.ellerman.id.au/kisskb/buildresult/12565754/

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
