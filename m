Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 07 Feb 2015 02:07:49 +0100 (CET)
Received: from mail-ob0-f175.google.com ([209.85.214.175]:34588 "EHLO
        mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012809AbbBGBHrosTZ9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 7 Feb 2015 02:07:47 +0100
Received: by mail-ob0-f175.google.com with SMTP id va2so16624901obc.6
        for <linux-mips@linux-mips.org>; Fri, 06 Feb 2015 17:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=CdOX4rMLP4VapPB4JqTn/Ny5p+V7xzCjx2wIKbGgTe8=;
        b=etvSWG3qjTTd1zGAyGKuMEGUp58V177sZ7IIfiCi/p8Wlhj/El1ajBREgM3/wFunOZ
         cebVamM7zNBBMw6txsChc5o3q8DvqdN9hGlkLF42bkrrmwaSt3xVbzL9sg5rVFmJy4OJ
         Gl7yAPoxa77wejn0tWyHgrgnxOmgIFq1qu2gdOXWtpyTQBwvvm9hokj4DLomIDMuuPg1
         ZtG5Nd82QsU0hzYDdrgVcESKUYwAQGaauozTYsy3GlZmFi/yz7jsmjj3hpEag0URP7Mc
         ABMa/idOyL1A9SuoUkdhtP2VQu9Jde7MLO6PpsfgL7+Bb5tDCFQFUeclBZu7r0BgdSLz
         qG9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=CdOX4rMLP4VapPB4JqTn/Ny5p+V7xzCjx2wIKbGgTe8=;
        b=KTwnPKt2NM7dGZloO2qWPBLTJr1A5d0lKEmy95qbgaQ5sjmBVVrxA7alnnHmOh2HA/
         nw/rIn6QMcibCyLxS85EiYgtq4vMuCFYJbjmGsexoKcTomvkvrZdZs7kwu5OdrradXBr
         S7kDyQ8X+mIsZL4waGs1ln1h3a44J7LxM9Zwc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=CdOX4rMLP4VapPB4JqTn/Ny5p+V7xzCjx2wIKbGgTe8=;
        b=JXwSOLVsIVVlQVHixrGJBAAUKX5IOn34mtG3Hf/Wl7dU1KCIxn/BCQ4UY1IdjsN8+g
         BnrUh6wLQPpSCmgu7PT2uXoHKkGtD2qSLG8B661M7boi1nS44NeJr1quCHCKsU7MWZYY
         D3v9AmQ8y92BBNMBI/sJg5Kr5B8c09H5rD1blbl1igxxEIjGc9x6RvMcofuDVzX08KsP
         i17a6paBTU+lRZkyYAF82P+2TGA9i3UoFko1PE6tQDSs8SVuF9RMRmaPooWhU6lmVj5T
         JpWMoMXswLU5mdQyI18fxgUIv1nB8yuTwM2AI9aOP7E3tfOgeAtBCADbsl7WgfUtICrG
         tWKg==
X-Gm-Message-State: ALoCoQlz56x5y7NEJc6aG0KTpY6VDD9GZC+eM9jrQqLdp+7pNQIdp+4CAjyXYvsRA7qhQ+5xv98O
MIME-Version: 1.0
X-Received: by 10.60.42.8 with SMTP id j8mr4463825oel.41.1423271261852; Fri,
 06 Feb 2015 17:07:41 -0800 (PST)
Received: by 10.182.87.201 with HTTP; Fri, 6 Feb 2015 17:07:41 -0800 (PST)
In-Reply-To: <20150206231720.GB3829@altlinux.org>
References: <CALCETrXFzcXngHsX=_72hYZqms32Zf7oFYDBgC3XNw7zOGdDCA@mail.gmail.com>
        <CAGXu5jJtHT9o8WMoynifN13=uZoARt4G9iVcgZsc9xYOBEwWsg@mail.gmail.com>
        <20150205233945.GA31540@altlinux.org>
        <CAGXu5jLTH+mUF0JxeR2qA_r=ocWjPHPSK2OPgE0Fu_JKoQyQ9w@mail.gmail.com>
        <CALCETrXsCUje+_V=Ud+TB4A2jH2M7yqyoCFMLEyxOD6pd7Di5w@mail.gmail.com>
        <20150206023249.GB31540@altlinux.org>
        <CALCETrWTnqKDoatK+5FN=yYDOeENoW5=r5YMToYKhZ8Zfv5wWA@mail.gmail.com>
        <CAGXu5j+nopAMFukwMu=Cy0GOapziOLTb-ryJhA-aywk_uerg9A@mail.gmail.com>
        <CALCETrVaF+3ETn5nfcbvyWKUYb71jNXK-zo9V6uOK0cEW4TCNQ@mail.gmail.com>
        <CAGXu5jJXspS_34KBJ5VxvyKuj4bA+zg267dNiEkqR1LuvjoA1Q@mail.gmail.com>
        <20150206231720.GB3829@altlinux.org>
Date:   Fri, 6 Feb 2015 17:07:41 -0800
X-Google-Sender-Auth: LWVi83JGpVr4e9hvxperfByZZRA
Message-ID: <CAGXu5jKHkJcnpbiuYY8BVX0-wOEUDFMx7r8_HJJe2ZDT8p3uvQ@mail.gmail.com>
Subject: Re: a method to distinguish between syscall-enter/exit-stop
From:   Kees Cook <keescook@chromium.org>
To:     "Dmitry V. Levin" <ldv@altlinux.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Will Drewry <wad@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@plumgrid.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Michael Kerrisk-manpages <mtk.manpages@gmail.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <keescook@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45761
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: keescook@chromium.org
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

On Fri, Feb 6, 2015 at 3:17 PM, Dmitry V. Levin <ldv@altlinux.org> wrote:
> On Fri, Feb 06, 2015 at 12:07:03PM -0800, Kees Cook wrote:
>> On Fri, Feb 6, 2015 at 11:32 AM, Andy Lutomirski <luto@amacapital.net> wrote:
>> > On Fri, Feb 6, 2015 at 11:23 AM, Kees Cook <keescook@chromium.org> wrote:
> [...]
>> >> And an unrelated thought:
>> >>
>> >> 3) Can't we find some way to fix the inability of a ptracer to
>> >> distinguish between syscall-enter-stop and syscall-exit-stop?
>> >
>> > Couldn't we add PTRACE_O_TRACESYSENTRY and PTRACE_O_TRACESYSEXIT along
>> > the lines of PTRACE_O_TRACESYSGOOD?
>>
>> That might be a nice idea. I haven't written a test to see, but what
>> does PTRACE_GETEVENTMSG return on syscall-enter/exit-stop?
>
> The value returned by PTRACE_GETEVENTMSG is the value set along with the
> latest PTRACE_EVENT_*.
> In case of syscall-enter/exit-stop (which is not a PTRACE_EVENT_*),
> there is no particular value set for PTRACE_GETEVENTMSG.

Could we define one to help distinguish?

-Kees

-- 
Kees Cook
Chrome OS Security
