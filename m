Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Sep 2018 13:57:50 +0200 (CEST)
Received: from mail-yw1-xc43.google.com ([IPv6:2607:f8b0:4864:20::c43]:36174
        "EHLO mail-yw1-xc43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994598AbeIRL5rCjyDA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 18 Sep 2018 13:57:47 +0200
Received: by mail-yw1-xc43.google.com with SMTP id i144-v6so648319ywc.3
        for <linux-mips@linux-mips.org>; Tue, 18 Sep 2018 04:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=RlK2Au7f7Pw0XN+y1/uWdu8MO+Nry4x3rQoc7bdLLWo=;
        b=YXjX8G6rpXbfHutJCG3KhruQBW90GtH7pQ9sahNp2HCVaD16B8j9XV/RmEYcrTpgVO
         cBY6E7EWAF92OCdB3LB2mqOKzfn6WOsLDys1pJKjOgsEh2d8eLXlDtgl/ncNOkb79eHV
         fBH7SFozD71XS60HDZoGRV3uCCMSA+fbrPZZ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=RlK2Au7f7Pw0XN+y1/uWdu8MO+Nry4x3rQoc7bdLLWo=;
        b=Vt4tM63+je5dneH0qfcohosjKdNBJwWsAJo4vt4s4tu7vKFMSixPo+r3ENOp60PVpm
         zacfFI2re9Rq+WSzO+Dzm11Bv0dNQ+/AmBsKzW9FfZEsxZ1r88SvtevRJIDcoFMuND6R
         NbboOj/EO25BvsrdGLJH91peAezARtbo30oCKowfHlofam19q4Q9USudFfzQ9g3ErPiz
         aRONSju9Ax7jEr3AR72fwf75PY1MhLKDxvP72o9CSAzfWJQkpChq7/AlmaasEsmseCbg
         UGCgJFYNmOLxVJ2y947Vx6TMfnOajuBpLYjI7nIStkCGMgbTv2JCj+ZwedkiTmEFeCvc
         X1yQ==
X-Gm-Message-State: APzg51DMBgbs3GvAInmg7IWm7TBBG3Ux/AZ7E8qM1ImE1IGN/Kr4MQIn
        PAPh/AydatCLofIazt7VBb0zW6CPkxhJOP1AOqI4TQ==
X-Google-Smtp-Source: ANB0VdZ/0qFOo0U1nAPvrC9VYwTSWTYwpGNRLiSh5mAwbZaAk92J9zyLKhsXK/ju7rFTeHdrlM3T34gGzxYJ+RT2o/Q=
X-Received: by 2002:a81:1b82:: with SMTP id b124-v6mr12433657ywb.381.1537271860818;
 Tue, 18 Sep 2018 04:57:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0d:cc4f:0:0:0:0:0 with HTTP; Tue, 18 Sep 2018 04:57:40
 -0700 (PDT)
In-Reply-To: <CAK8P3a221wz4iqwoKcof2ioVWzHmUCOwt8Y5cdVPvZEEtHcycQ@mail.gmail.com>
References: <1536914314-5026-1-git-send-email-firoz.khan@linaro.org>
 <1536914314-5026-3-git-send-email-firoz.khan@linaro.org> <CAK8P3a221wz4iqwoKcof2ioVWzHmUCOwt8Y5cdVPvZEEtHcycQ@mail.gmail.com>
From:   Firoz Khan <firoz.khan@linaro.org>
Date:   Tue, 18 Sep 2018 17:27:40 +0530
Message-ID: <CALxhOnjxFiWd_rTKnUo4dAYZZgqi_AqVsCj1AB8yHL-KwvMpQQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] mips: Add system call table generation support
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
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
Return-Path: <firoz.khan@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66395
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: firoz.khan@linaro.org
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

On 14 September 2018 at 15:28, Arnd Bergmann <arnd@arndb.de> wrote:
> On Fri, Sep 14, 2018 at 10:39 AM Firoz Khan <firoz.khan@linaro.org> wrote:
>>
>> The system call tables are in different format in all
>> architecture and it will be difficult to manually add or
>> modify the system calls in the respective files. To make
>> it easy by keeping a script and which'll generate the
>> header file and syscall table file so this change will
>> unify them across all architectures.
>>
>> The system call table generation script is added in
>> syscalls directory which contain the script to generate
>> both uapi header file system call table generation file
>> and syscall_32/64.tbl file which'll be the input for the
>> scripts.
>
> I think it would be best to name the files
> o32/n64/n32 instead of 32/64/n32

This is an easy fix. I'll make it in the next version.

>
> It would also be helpful to mention why the n32/n64
> files cannot be combined into one nfile here.

Sure.

>
>
>> +364     32      pkey_alloc                      sys_pkey_alloc
>> +365     32      pkey_free                       sys_pkey_free
>> +366     32      statx                           sys_statx
>
> You missed the additon of rseq and io_pgetevetns here.

As I mentioned in the cover letter:
"I started working system call table generation on 4.17-rc1. I used
marcin's script - https://github.com/hrw/syscalls-table to generate
the syscall.tbl file. And this will be the input to the system call
table generation script. But there are couple system call got add
in the latest rc release. If run Marcin's script on latest release,
It will generate a new syscall.tbl. But I still use the old file -
syscall.tbl and once all review got over I'll update syscall.tbl
alone w.r.to the tip of the kernel. The impact of this thing, few
of the system call won't work."

Hopefully, the next version does have this change. Thanks!

- Firoz
