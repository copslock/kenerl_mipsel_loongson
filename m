Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 19 Jul 2014 00:26:44 +0200 (CEST)
Received: from mail-la0-f54.google.com ([209.85.215.54]:41993 "EHLO
        mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6861350AbaGRW0jZ0rKB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 19 Jul 2014 00:26:39 +0200
Received: by mail-la0-f54.google.com with SMTP id el20so3241906lab.41
        for <linux-mips@linux-mips.org>; Fri, 18 Jul 2014 15:26:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=YFIWzqNM84f1+fssTI8WD08P3A9hwklkPc8ETiA2EXY=;
        b=M7g0hSDGLfKQ5gKMp10u8/QFgaIRlgTcth6ydGH9o4V3VEUUHXdHyMcGdUyvjXKc73
         cEj3eiCco7JvBx3RjWvHqiZ6QwtGF9CIFfxyY0bmAQnCWukqjCQthIDS/52i9AJw94z7
         7sChYg4K7V/d4HjUds7yFeUcpmS/RIO/sF74Upa1leTzXx0wUe3AQjAoFQ1GQcVAP63k
         VLZhQWCi24BRYtRXZRfgzGVLm9KBl8g4CePW74b/cyUydGvp/tJsgzH+vvwp8mF80h9E
         DE3VtkuZXo5IN5ScvV1x4Pd2yI/lA0vG1yt+ivB3LAVMcOcD8cbLurbWFNbuWY5MZNG1
         H7aQ==
X-Gm-Message-State: ALoCoQmQpO3oJM608LsSVf/SrWFD+f2RiroISxgZu8LJnYXv4Ij+/uE+FQm0I7iVAtTUEj3IUa1c
X-Received: by 10.152.5.105 with SMTP id r9mr8400547lar.37.1405722393766; Fri,
 18 Jul 2014 15:26:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.152.108.130 with HTTP; Fri, 18 Jul 2014 15:26:13 -0700 (PDT)
In-Reply-To: <CAGXu5jLsnSujJdZmA=nzHw1_K3eYhSiUEnntJ3S2hCZ8DFVYpg@mail.gmail.com>
References: <cover.1405717901.git.luto@amacapital.net> <ce65e0e8be18ae8fab437899db44ca41c912b506.1405717901.git.luto@amacapital.net>
 <CAGXu5jLsnSujJdZmA=nzHw1_K3eYhSiUEnntJ3S2hCZ8DFVYpg@mail.gmail.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Fri, 18 Jul 2014 15:26:13 -0700
Message-ID: <CALCETrX=hN1yKh=cfcOHffMprjP74PdeRfhTFOYCK7oPhURV_Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] seccomp: Allow arch code to provide seccomp_data
To:     Kees Cook <keescook@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Will Drewry <wad@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@plumgrid.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <luto@amacapital.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41343
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: luto@amacapital.net
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

On Fri, Jul 18, 2014 at 3:16 PM, Kees Cook <keescook@chromium.org> wrote:
> On Fri, Jul 18, 2014 at 2:18 PM, Andy Lutomirski <luto@amacapital.net> wrote:
>> populate_seccomp_data is expensive: it works by inspecting
>> task_pt_regs and various other bits to piece together all the
>> information, and it's does so in multiple partially redundant steps.
>>
>> Arch-specific code in the syscall entry path can do much better.
>>
>> Admittedly this adds a bit of additional room for error, but the
>> speedup should be worth it.
>
> I still think we should gain either a note in the
> HAVE_ARCH_SECCOMP_FILTER help text in arch/Kconfig, or possibly a new
> section in Documentation/prctl/seccomp.txt (or similar) on how do
> implement filter support for an architecture, that mentions the
> arch-supplied seccomp_data and how two-phase can be done.

I would have sworn I did that.  I distinctly remember typing that
text.  I must have failed to commit it.

I'll send a followup patch.

--Andy

>
> -Kees
>
> --
> Kees Cook
> Chrome OS Security



-- 
Andy Lutomirski
AMA Capital Management, LLC
