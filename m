Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Oct 2017 10:59:28 +0200 (CEST)
Received: from mail-oi0-x241.google.com ([IPv6:2607:f8b0:4003:c06::241]:33275
        "EHLO mail-oi0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990522AbdJEI7UmeB4D (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 5 Oct 2017 10:59:20 +0200
Received: by mail-oi0-x241.google.com with SMTP id n129so8318663oia.0;
        Thu, 05 Oct 2017 01:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=hjJl86aOnhkRGqNJGmN0QuM/MqZDYoW2aF9qHsZMAyI=;
        b=RtC4Wuc3+ThC6cjpfM/PkEkl7N6uRU6AK1d0xtl72vUpU9ybjeCzBB+SNzQU8FMBkg
         5wdpGMpdod5W4qQ5WvjmwmP/r/kCUZigipixNnrRT6RWJ+EnwTIL361BBp2R3bX2sJMv
         LwMqrzXgJhydDcu4X/nPBJTEV4BRjgGqDd5VOyftW/1zL1pkHP7RfJhn7Za+pHUdiLSr
         AX/kkHvej3C8oMvChjAjWNy5U9QWgXTR0bnU0lTX1v8XbTWmb/7Luat+5FlqvZyRqWVY
         XwW0+yIB3tGMPvB+NnbFN+tvrN0zadt3HqAtSbjYK6YyEPvOq5gavp+o4hehKimA5BYS
         pXJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=hjJl86aOnhkRGqNJGmN0QuM/MqZDYoW2aF9qHsZMAyI=;
        b=QsHpJ9YTntbGgiGILxwTd49o83wCY0SryM32DbTd8sXQL4jcY6hwMzdRaqHeZMw8ZC
         wB7uY+k36afKQbUZsDqZwL9WDX/otF2zQ4/3ywAEg7XgqteO3K7JH/gW5M2QzDZtW7Qd
         nKmenwc+I6yJxH1Z+wcVGV16Hl8GUJmTZYv/MO71A/Pn5cX3ebHkpdzw+T9corDzzo5l
         44ikf2cDrRLZ031Z9mMH9QTpFpb0gGK8nuUd/VqkgvraL1sZXWZiRRs3K3EsauV34bNA
         tDacB6heJXtmuA4hbMWWONSNlhFmCL+IL1ZqhezVOkvW32VtjIG3oAXuOcu8W9Y8RNdQ
         Cnzw==
X-Gm-Message-State: AMCzsaU+7E+ZGqCXn7DS/GvNtQnHxYbR3OwAgf+f8RD2mwVFksP4teRT
        KA6u/bU3M351gWADFbrWkl0C+1JWUtXoD7CoLx4=
X-Google-Smtp-Source: AOwi7QBhpc8D8UYuWiIwKWJvS95Rt3xTJvJNyMWrWuVLAo4HEdrjagaoZNS1Bf3apjbKftgA+zoJkPKk1PlJ72xrL1U=
X-Received: by 10.157.17.6 with SMTP id g6mr13540422ote.305.1507193953151;
 Thu, 05 Oct 2017 01:59:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.157.28.152 with HTTP; Thu, 5 Oct 2017 01:59:12 -0700 (PDT)
In-Reply-To: <1507159627-127660-11-git-send-email-keescook@chromium.org>
References: <1507159627-127660-1-git-send-email-keescook@chromium.org> <1507159627-127660-11-git-send-email-keescook@chromium.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 5 Oct 2017 10:59:12 +0200
X-Google-Sender-Auth: 78QHwSeyj49a01INFvcpGQcFj-4
Message-ID: <CAK8P3a2uio4L3BMedHGg0wVy2asJ_CD8xqxevSnqdNDKOy6Vqw@mail.gmail.com>
Subject: Re: [PATCH 10/13] timer: Remove expires and data arguments from DEFINE_TIMER
To:     Kees Cook <keescook@chromium.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Harish Patil <harish.patil@cavium.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        John Stultz <john.stultz@linaro.org>,
        Julian Wiedmann <jwi@linux.vnet.ibm.com>,
        Kalle Valo <kvalo@qca.qualcomm.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Len Brown <len.brown@intel.com>,
        Manish Chopra <manish.chopra@cavium.com>,
        Mark Gross <mark.gross@intel.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michael Reed <mdr@sgi.com>,
        Networking <netdev@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Paul Mackerras <paulus@samba.org>, Pavel Machek <pavel@ucw.cz>,
        Petr Mladek <pmladek@suse.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Sebastian Reichel <sre@kernel.org>,
        Stefan Richter <stefanr@s5r6.in-berlin.de>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        Ursula Braun <ubraun@linux.vnet.ibm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Wim Van Sebroeck <wim@iguana.be>,
        linux1394-devel@lists.sourceforge.net,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        linux-pm@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-watchdog@vger.kernel.org,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <arndbergmann@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60280
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

On Thu, Oct 5, 2017 at 1:27 AM, Kees Cook <keescook@chromium.org> wrote:
> Drop the arguments from the macro and adjust all callers with the
> following script:
>
>   perl -pi -e 's/DEFINE_TIMER\((.*), 0, 0\);/DEFINE_TIMER($1);/g;' \
>     $(git grep DEFINE_TIMER | cut -d: -f1 | sort -u | grep -v timer.h)
>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # for m68k parts

I was slightly worried about this large-scale rework, since it might conflict
with new users of DEFINE_TIMER(), causing bisection problems.

However, a little research showed that we have only added two users
in the past five years, so this is not a real concern.

for arch/arm, drivers/char and overall:

Acked-by: Arnd Bergmann <arnd@arndb.de>
