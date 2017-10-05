Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Oct 2017 15:18:48 +0200 (CEST)
Received: from mail-oi0-x244.google.com ([IPv6:2607:f8b0:4003:c06::244]:38005
        "EHLO mail-oi0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992160AbdJENSkEjuhT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 5 Oct 2017 15:18:40 +0200
Received: by mail-oi0-x244.google.com with SMTP id t134so1595511oih.5;
        Thu, 05 Oct 2017 06:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=l0EgT4BCp2dtRJV89J4lMpS3D9tnIKJLg29GOKXpRtU=;
        b=oZ1xA3CzdptbgULx0VTB1ZK3ofpqRst14F+MyvuE14pFdfLUQlD0KFraUm+jBeaKC0
         Glo50cHBzwJG7579zzseN0w95KQ7r/uNBGPDei+gL+BwcHoswQiPb5MBk1lAF3cWvbl2
         ZzbvgsPPYGr8FRqvP9dcieLmWQA8KzNrullOq3esvZuHo6qdV98vOwnExxNYa4x3wgj3
         7pjcyOHpf/p9Lecj/J4+yi6DK65I5ucnXDY6kETG4ZF5aNw22/M3FXzzXr5haeTIuhcV
         pIH2DzJfh8qqvFBlcv4De2OwaMihjacMcd6Gsjecwxr83+cEGHh8u4zl23ivYN52RxVh
         HXag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=l0EgT4BCp2dtRJV89J4lMpS3D9tnIKJLg29GOKXpRtU=;
        b=XAKz+yh4FwCjL1VLpzHblfH8NjjnnuIk1M2ykl2TN0SJe6dKEZuEO3VWjV4AqsYx8F
         BLh+1NnY6uG8lUlQRvNNiEPIF+VqUqDyUDYW0bGIB60yVpwWhQKIHMuJlI9FflHz9Tbi
         rSXXi5qFVe+RrH4+RYGr/G3sLW0dQNzgUej9T+PFQdMRyYCxnCpytvFeo6xSiSgtfj9r
         wU0W0Xrb6lQED883C2Ifx5GpdtEWg/3PAGvQJmkJpz2XZSVvY1+G2BOWHwgj54Dsk5WI
         e6yCsX4nZpuY5S/5srCTpPIea+r1yPJ6x6rbcykbyGSot1efL9UzpErwGDDVhmQrMVPW
         YLSw==
X-Gm-Message-State: AMCzsaVy1o2zIASFbZy/7KjzbVquotvGsVPqmh1ox1U/yen/dX6N1nTm
        eKksLMkt75pOokYXn6uVv7a3Zj4ZxW/29OxjI40=
X-Google-Smtp-Source: AOwi7QAA+wRmyIafi9TXTCD4MuKUKHFt4GUbez0T2Rbwb6pXmP3pcxOQK1nKi1eKOimBdYP5gbTrbjLXBB5wUHM/szU=
X-Received: by 10.157.68.156 with SMTP id v28mr7097540ote.358.1507209513424;
 Thu, 05 Oct 2017 06:18:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.157.73.24 with HTTP; Thu, 5 Oct 2017 06:18:32 -0700 (PDT)
In-Reply-To: <1507159627-127660-4-git-send-email-keescook@chromium.org>
References: <1507159627-127660-1-git-send-email-keescook@chromium.org> <1507159627-127660-4-git-send-email-keescook@chromium.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 5 Oct 2017 15:18:32 +0200
X-Google-Sender-Auth: p1vnYj1cp9srKgemf395tl5Lovw
Message-ID: <CAJZ5v0iMxSDj0gR0n3YF+zRvR3e2XHpiMR9hKjjon_EXSbB89w@mail.gmail.com>
Subject: Re: [PATCH 03/13] timer: Remove init_timer_on_stack() in favor of timer_setup_on_stack()
To:     Kees Cook <keescook@chromium.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stefan Richter <stefanr@s5r6.in-berlin.de>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Julian Wiedmann <jwi@linux.vnet.ibm.com>,
        Ursula Braun <ubraun@linux.vnet.ibm.com>,
        Michael Reed <mdr@sgi.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux1394-devel@lists.sourceforge.net, linux-s390@vger.kernel.org,
        "open list:TARGET SUBSYSTEM" <linux-scsi@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Harish Patil <harish.patil@cavium.com>,
        John Stultz <john.stultz@linaro.org>,
        Kalle Valo <kvalo@qca.qualcomm.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Manish Chopra <manish.chopra@cavium.com>,
        Mark Gross <mark.gross@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>, netdev@vger.kernel.org,
        Oleg Nesterov <oleg@redhat.com>,
        Paul Mackerras <paulus@samba.org>,
        Petr Mladek <pmladek@suse.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Sebastian Reichel <sre@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>, Tejun Heo <tj@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Wim Van Sebroeck <wim@iguana.be>,
        MIPS Linux Kernel List <linux-mips@linux-mips.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "open list:NETWORKING DRIVERS (WIRELESS)" 
        <linux-wireless@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <rjwysocki@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60282
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rafael@kernel.org
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

On Thu, Oct 5, 2017 at 1:26 AM, Kees Cook <keescook@chromium.org> wrote:
> Remove uses of init_timer_on_stack() with open-coded function and data
> assignments that could be expressed using timer_setup_on_stack(). Several
> were removed from the stack entirely since there was a one-to-one mapping
> of parent structure to timer, those are switched to using timer_setup()
> instead. All related callbacks were adjusted to use from_timer().
>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Stefan Richter <stefanr@s5r6.in-berlin.de>
> Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: Julian Wiedmann <jwi@linux.vnet.ibm.com>
> Cc: Ursula Braun <ubraun@linux.vnet.ibm.com>
> Cc: Michael Reed <mdr@sgi.com>
> Cc: "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>
> Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: linux-pm@vger.kernel.org
> Cc: linux1394-devel@lists.sourceforge.net
> Cc: linux-s390@vger.kernel.org
> Cc: linux-scsi@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  drivers/base/power/main.c           |  8 +++-----
>  drivers/firewire/core-transaction.c | 10 +++++-----
>  drivers/parport/ieee1284.c          | 21 +++++++--------------
>  drivers/s390/char/tape.h            |  1 +
>  drivers/s390/char/tape_std.c        | 18 ++++++------------
>  drivers/s390/net/lcs.c              | 16 ++++++----------
>  drivers/s390/net/lcs.h              |  1 +
>  drivers/scsi/qla1280.c              | 14 +++++---------
>  drivers/scsi/qla1280.h              |  1 +
>  include/linux/parport.h             |  1 +
>  include/linux/timer.h               |  2 --
>  11 files changed, 36 insertions(+), 57 deletions(-)
>
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index 770b1539a083..ae47b2ec84b4 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -478,9 +478,9 @@ struct dpm_watchdog {
>   * There's not much we can do here to recover so panic() to
>   * capture a crash-dump in pstore.
>   */
> -static void dpm_watchdog_handler(unsigned long data)
> +static void dpm_watchdog_handler(struct timer_list *t)
>  {
> -       struct dpm_watchdog *wd = (void *)data;
> +       struct dpm_watchdog *wd = from_timer(wd, t, timer);
>
>         dev_emerg(wd->dev, "**** DPM device timeout ****\n");
>         show_stack(wd->tsk, NULL);
> @@ -500,11 +500,9 @@ static void dpm_watchdog_set(struct dpm_watchdog *wd, struct device *dev)
>         wd->dev = dev;
>         wd->tsk = current;
>
> -       init_timer_on_stack(timer);
> +       timer_setup_on_stack(timer, dpm_watchdog_handler, 0);
>         /* use same timeout value for both suspend and resume */
>         timer->expires = jiffies + HZ * CONFIG_DPM_WATCHDOG_TIMEOUT;
> -       timer->function = dpm_watchdog_handler;
> -       timer->data = (unsigned long)wd;
>         add_timer(timer);
>  }

For the above:

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
