Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Dec 2015 13:49:40 +0100 (CET)
Received: from mout.kundenserver.de ([212.227.126.131]:63878 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007931AbbLKMthpKq0S (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 11 Dec 2015 13:49:37 +0100
Received: from wuerfel.localnet ([134.3.118.24]) by mrelayeu.kundenserver.de
 (mreue004) with ESMTPSA (Nemesis) id 0MIRvH-1a604b3ntH-004CBx; Fri, 11 Dec
 2015 13:48:05 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Petr Mladek <pmladek@suse.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jiri Kosina <jkosina@suse.com>,
        Cris <linux-cris-kernel@axis.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "adi-buildroot-devel@lists.sourceforge.net" 
        <adi-buildroot-devel@lists.sourceforge.net>,
        Ingo Molnar <mingo@redhat.com>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3 4/4] printk/nmi: Increase the size of NMI buffer and make it configurable
Date:   Fri, 11 Dec 2015 13:47:59 +0100
Message-ID: <10841284.ycX60MmRhF@wuerfel>
User-Agent: KMail/4.11.5 (Linux/3.16.0-10-generic; KDE/4.11.5; x86_64; ; )
In-Reply-To: <20151211124159.GB3729@pathway.suse.cz>
References: <1449667265-17525-1-git-send-email-pmladek@suse.com> <CAMuHMdXVgr58YjoePGrRbMyMncQ27f85prL7G5SpeHeNxoYrXQ@mail.gmail.com> <20151211124159.GB3729@pathway.suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID: V03:K0:+bsKHQrcw5o5SR5os7VRM3qTuyqFB2aB0fVfv4BB7HESKh06/8G
 LQksy0xz0XH2ClakshuQorl3UKtB4Ei5fXJ02TDMWLwqY71rx9rk+dZvolPPUZiQ/fazuJW
 fhJo9Mbt7HFrOnAuDV7tp5aGdb6g3KLJZuIcxGUj4SOy8Q/Y3VsgKPFIDaEcSqgh7CbQma1
 NMQlWbb/4qS8RIqhFKjjg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:dJ1tdGoswUk=:k+Ss0tvx3LY1bkIjxZVpvv
 z3WQKcWoWOlwNMTfCAQYM8kPkhixgRvJMM8Q6S0yfDP/ntaNVYILepkmLmjMjaPKIWEHbYJuX
 IayWtw2fupaM6TRsTGWg73SThj1QG+sVfWF37Oy91HbxdxzR7YFed0cMeg1dwTwTvgcsaovWm
 wiWL4xeX/uF9xyknDjS1WPIzbWJVP8rsUS5jWxfKIhVkaARBUVw8BtfUBUd8oqkzlLgrXpxd6
 numWvAQnRya3MoY0q+7UmDTSmHuZv+kOxAMSmu/lsBICN0HxHFdEbPejxeYKADbUOJDJyyQp3
 o57mJ3LFToMmRjxz3ERnuzVvXt9HIc4zlqTGVYCs2+EJzY1V49CblbHlFAPNRmBwoJkl0hiSD
 w/HIrPysZjh4BIzn9HpQsq8VbOyQmjxJjc2khxJb+u2RTqIYeIxM7jkxbXJxEjNxhZSnYq/nf
 yZ7EpiLhRPqOcyX1zqNfnblfGpHlRcBb2VXSPYiQBqcvazYT+EIc0WGim6AWTuZNen9r0at+w
 iCixbMp0ZLjN1dgyDs0xfLWjYlvC/NHzILlY3Q8Bzwdd1EsRIx22Mgltn7sRYOOaT9WxhNRjd
 uN3DrUtEn+dEip9AHsHN0OMbeJ8wvxhvhessXl6KGQkXxR4bu+DxMHVDPtYL7S9UPduixJfg6
 BQZQ/BnX7lY/mpD5dHpZQdx7K7rGmeu9ZG57K21WK8qG2/qGFgt61MBN33KK9JyE50iZswPqs
 Vya+Gfz2PZao9gPn
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50545
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

On Friday 11 December 2015 13:41:59 Petr Mladek wrote:
> diff --git a/init/Kconfig b/init/Kconfig
> index efcff25a112d..61cfd96a3c96 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -870,7 +870,7 @@ config NMI_LOG_BUF_SHIFT
>         int "Temporary per-CPU NMI log buffer size (12 => 4KB, 13 => 8KB)"
>         range 10 21
>         default 13
> -       depends on PRINTK && HAVE_NMI
> +       depends on PRINTK_NMI
>         help
>           Select the size of a per-CPU buffer where NMI messages are temporary
>           stored. They are copied to the main log buffer in a safe context
> 
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>

I found this on linux-next as well today and came to the same conclusion.

	Arnd
