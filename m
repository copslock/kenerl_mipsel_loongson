Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Nov 2018 17:00:56 +0100 (CET)
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46240 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993826AbeKSQAp0fmUA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Nov 2018 17:00:45 +0100
Received: by mail-qk1-f196.google.com with SMTP id q1so49330466qkf.13;
        Mon, 19 Nov 2018 08:00:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=etJ06+iczpf28NRoBWJwPxdidTlkeRUxLcwzAMEwHB0=;
        b=YkiHpIKO4uo3o2H2xNcjmCAWsPK1WJDrfYCpKZYObH7dl3K3HPRyHNoJ8c2od27xtK
         gd/Hpu8DAYbb6Cr/aP1gQh5o2fEyzTICD2LvZ2eKznN6BqHV5uItgJzNidw1eFU4x4sB
         ReO65J+K44Z34eiRZzC/ojdTzJVy4xxLOmATWVNZa+rEx4VuYgwIJJ2ZZNdVc5NuZYG+
         rM/wBReZ/0j5jQIzOzkBrvKAVaJ2G+IBvbgaxm46DoXuIiYeMuzLziTtDRZIaiGnG4di
         sTkoJguKusseK58J+mQwtufdqxncqWA8CN7U1auLl6z4z70qKj/b2NxwAY8T0EoPlK9j
         g1Eg==
X-Gm-Message-State: AGRZ1gIlg4GDTRsSORi5XuRnjgEc/deS+eL8kTfKFasshXbxUxM/7UTa
        mFPsSYyJJzRBU5qD4k5OYT7gR8vvYfo+Rh71rhw=
X-Google-Smtp-Source: AJdET5dw/dqcsuslp95hhoRhcw2RFHknXqo8sA0zV13CqDEv4OTFZfQgEkRmLA5biUs6ZJOABbNE2ZF/Kg1p6SyaV5U=
X-Received: by 2002:aed:35c5:: with SMTP id d5mr21296810qte.212.1542643244719;
 Mon, 19 Nov 2018 08:00:44 -0800 (PST)
MIME-Version: 1.0
References: <1542262461-29024-1-git-send-email-firoz.khan@linaro.org> <1542262461-29024-5-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1542262461-29024-5-git-send-email-firoz.khan@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 19 Nov 2018 17:00:28 +0100
Message-ID: <CAK8P3a1Ee-6unLimZ=0TH0PjdSjwu1naK=U6Jvoi_qvsf5+z7w@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] mips: add system call table generation support
To:     Firoz Khan <firoz.khan@linaro.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        gregkh <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <arndbergmann@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67355
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

On Thu, Nov 15, 2018 at 7:15 AM Firoz Khan <firoz.khan@linaro.org> wrote:
>
> The system call tables are in different format in all
> architecture and it will be difficult to manually add,
> modify or delete the syscall table entries in the res-
> pective files. To make it easy by keeping a script and
> which will generate the uapi header and syscall table
> file. This change will also help to unify the implemen-
> tation across all architectures.

This looks great to me, just one question:

> +# The <abi> is always "64" for this file.
> +#
> +0      64      read                            sys_read
> +1      64      write                           sys_write

What is the reason for using '64', 'n32', and 'o32' respectively in
the ABI field
but use 'common' in other architectures that have a table of entries that are
all for the same architecture?

       Arnd
