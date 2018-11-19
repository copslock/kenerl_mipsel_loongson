Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Nov 2018 17:02:38 +0100 (CET)
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40560 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991708AbeKSQCAs1l7A (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Nov 2018 17:02:00 +0100
Received: by mail-qk1-f194.google.com with SMTP id y16so49387427qki.7;
        Mon, 19 Nov 2018 08:02:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k7XGE259zPHtZxyj7onWoRQ4Ox/KArkHxcJHDXcQDLk=;
        b=NJoG86mBMUlnTOjukCQl4IsdGV/EVjDY+2tLDcETfdK5/+YSOGnFcDl03JcpqSwJUx
         asF7I0YCg8oFLP+N/dT0TvoQtxupGYxf3K8UIwOfp3XR76H9zpPnVJOaMr+NAAt5i41V
         CAWL2bQtdO0sOojljfoCOWLkGhkV0gdDW84iLlsPx2GH26OTYPASxCIIu/1OlgJW1mC4
         WHEL+esf8MjkzkoASrN8aCYWzVmPsyXX/JvPgQ0jIEFMcIsTtg8/aCl6cj4ZDBDIVPyL
         E+6/GbMHgt895vL9XAo0hZLco/aOMkpo1ibyqVsq0+uHcOr26hURBMpWMRZWTuuo107X
         6vbw==
X-Gm-Message-State: AGRZ1gIkOAeoBoeR+k5gzNOlc5a+fYLkUlWO4uQAUcOLHzz7d0vm3qmu
        xtTdM64unvJIqy29h9KPnVESWLXIpFoHxh6U8Lg=
X-Google-Smtp-Source: AJdET5cNa0GJZ2humvx++P4L6Ki0xQCssn0DfSiMQcrhmV49lRChPLUKYP70wxb7wDe0gvNTZAVy9h87pet1DTbVl4U=
X-Received: by 2002:a0c:dc0f:: with SMTP id s15mr21478459qvk.40.1542643320063;
 Mon, 19 Nov 2018 08:02:00 -0800 (PST)
MIME-Version: 1.0
References: <1542262461-29024-1-git-send-email-firoz.khan@linaro.org> <1542262461-29024-6-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1542262461-29024-6-git-send-email-firoz.khan@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 19 Nov 2018 17:01:43 +0100
Message-ID: <CAK8P3a20MaFRNf8-umvrGNtjgNG98PkzcFGtHrnY835UEGv3tg@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] mips: generate uapi header and system call table files
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
X-archive-position: 67356
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
> System call table generation script must be run to gener-
> ate unistd_64/n32/o32.h and syscall_table_32_o32/64_64/64-
> _n32/64-o32.h files. This patch will have changes which
> will invokes the script.
>
> This patch will generate unistd_64/n32/o32.h and syscall-
> _table_32_o32/64_64/64-n32/64-o32.h files by the syscall
> table generation script invoked by parisc/Makefile and
> the generated files against the removed files must be
> identical.
>
> The generated uapi header file will be included in uapi/-
> asm/unistd.h and generated system call table header file
> will be included by kernel/scall32-o32/64-64/64-n32/-
> 64-o32.Sfile.
>
> Signed-off-by: Firoz Khan <firoz.khan@linaro.org>

Looks good to me.

      Arnd
