Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Nov 2018 15:18:11 +0100 (CET)
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36460 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990505AbeK2OQQGAROQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 29 Nov 2018 15:16:16 +0100
Received: by mail-qt1-f196.google.com with SMTP id t13so2090547qtn.3;
        Thu, 29 Nov 2018 06:16:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zwMsN0MymMapX+iJ/bF8gBhwCFKK8oi/Umouxn9UCY8=;
        b=r+LbThLtGhuIjuc3k1lsJpInZrnQh9qt+FSzjgIE5xB+kH9NfTm7o2QyGeXn/KKgkQ
         ilyRcA5q3vx0u6MRuQxbeGDd5/cJAZn9peBb2XcQoz9ej5xFYLxHmqH8KSQ/xoPKyT2p
         dNBAp4/erats2uiLmfLG6fSMohcemgtLrK9UcwNLsJxo5EizGwrmabJFdOCq/hfSV00t
         6bQmcVkFYhPLOiX6LVzuZFPWesL0QmkLH1bdgJDt1nhJXatDnhF44rVXcmnZYvb7FVMB
         HTUGVrsSKxUjmMuGAH0lJAH+k1L9UskE/s3JO/cOldF9o71tcDEibPQI0YQJxM2jEzFj
         erHQ==
X-Gm-Message-State: AA+aEWbQhiuWJFW03Bsodkkdk3wuBGiYQZV8cffhM86O9RY2FxWJxj8D
        yAyoptuQ/eeK1oo7PdNKAIDmInlKBTSBoVrnbuk=
X-Google-Smtp-Source: AFSGD/VUvNzby+S4wIVg0cInp60n3619SBSM9Xrq04K+HaQrdFlLpq0bws5ClRJz7ihaSn5wJoLVGZ7ETa1+jOR2AOc=
X-Received: by 2002:ac8:2c34:: with SMTP id d49mr1581648qta.152.1543500975228;
 Thu, 29 Nov 2018 06:16:15 -0800 (PST)
MIME-Version: 1.0
References: <1543481016-18500-1-git-send-email-firoz.khan@linaro.org> <1543481016-18500-6-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1543481016-18500-6-git-send-email-firoz.khan@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 29 Nov 2018 15:15:58 +0100
Message-ID: <CAK8P3a1KcUQEbavu1eZaoKXTmbdbxiKgVqt6XF-PeeSSbpVEVg@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] mips: add system call table generation support
To:     Firoz Khan <firoz.khan@linaro.org>
Cc:     "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
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
X-archive-position: 67550
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

On Thu, Nov 29, 2018 at 9:44 AM Firoz Khan <firoz.khan@linaro.org> wrote:
>
> The system call tables are in different format in all
> architecture and it will be difficult to manually add,
> modify or delete the syscall table entries in the res-
> pective files. To make it easy by keeping a script and
> which will generate the uapi header and syscall table
> file. This change will also help to unify the implemen-
> tation across all architectures.
>
> The system call table generation script is added in
> kernel/syscalls directory which contain the scripts to
> generate both uapi header file and system call table
> files. The syscall.tbl will be input for the scripts.
>
> syscall.tbl contains the list of available system calls
> along with system call number and corresponding entry
> point. Add a new system call in this architecture will
> be possible by adding new entry in the syscall.tbl file.
>
> Adding a new table entry consisting of:
>         - System call number.
>         - ABI.
>         - System call name.
>         - Entry point name.
>         - Compat entry name, if required.
>
> syscallhdr.sh and syscalltbl.sh will generate uapi
> header unistd_64/n32/o32.h and syscall_table_32_o32/-
> 64_64/64-n32/64-o32.h files respectively. Both .sh files
> will parse the content syscall.tbl to generate the header
> and table files. unistd_64/n32/o32.h will be included by
> uapi/asm/unistd.h and syscall_table_32_o32/64_64/64-n32-
> /64-o32.h is included by kernel/syscall_table32_o32/64-
> _64/64-n32/64-o32.S - the real system call table.
>
> ARM, s390 and x86 architecuture does have similar support.
> I leverage their implementation to come up with a generic
> solution.
>
> Signed-off-by: Firoz Khan <firoz.khan@linaro.org>

Ah, I see you added the syscallnr.sh script from ARM.  I guess
that is one way to handle it, and the implementation seems
fine. It would be good to mention it in the changelog text above
though.

      Arnd
