Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Feb 2017 11:53:02 +0100 (CET)
Received: from mail-vk0-x243.google.com ([IPv6:2607:f8b0:400c:c05::243]:33851
        "EHLO mail-vk0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993419AbdBMKwzUhsHq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 13 Feb 2017 11:52:55 +0100
Received: by mail-vk0-x243.google.com with SMTP id r136so7487645vke.1;
        Mon, 13 Feb 2017 02:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=uZ6PniQpfSZgOeLcsrSnsls7R+T8+13NnD9paj4GZf4=;
        b=U5ZoWZGM5WYQ0ASMkoxy5zdmUXfOvSEDQDZibs8zTcTVR8brPc5z0AKRkCLwzi3dm4
         /baOGfUrc5acDT2FDWGAsWAyb3JSi2wSH6BnfKOi0gkyguScz05HjPGvkbRU+I9M7ZAk
         vtws+u6mdUhPoL69nLUooB0Cn322kJgMaOxzsPj7j4CktmwcgTxlH+P564JmL8ZOiC7J
         XMyTJ6iTnYPSe53pSn7TkKmKv3gFRF2f+PdgbvqgfCWG12UyXMKh5oAuI5/S2OjLvcFc
         hHY1MDbsxVAWsYQtewk9MVDGQZr0v2IhnJ8ubs8Tvx5J+CEN/PvoJo0Q3TgBzL79d7JN
         JTTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=uZ6PniQpfSZgOeLcsrSnsls7R+T8+13NnD9paj4GZf4=;
        b=SfCEagvMfLHaDG/JZ/h504b+IQ1lyiWjUlUZeYX8E/6SkhaRrd2IzAPgVRmEkxoaAl
         gE9twlGviMdB25v4wuAAg4mKOzBXdJt/UVxXrYPxmxv3PJiLCPKUb9znVhpiGPdyks0N
         p9ewpjsKXNaNpLyBQ4CIZVf7LSod78TemrGArN/+UdrPqOuE+/txDeQvWOyWMeo8AxQd
         5Mla/FHx5AaZgSGrM3nurUZKKYEMe9OGsltwbsHxxL0xY/4jZrWY1FtP3ovfvG1poesk
         UXdNCK0bMuUFMk56JWY1P90moQfJ3ZVkX7VGSJzwh2rYRKZXISFv8nbuq+jzV2gobXlz
         sr6g==
X-Gm-Message-State: AMke39m52JirI0wP5rf7tnPi8bait7Y2nopRy/bIPO3912jTvQSCEl+EnmtVh9NEcN8QWz1LErCT/9BR37datg==
X-Received: by 10.31.208.133 with SMTP id h127mr11323192vkg.96.1486983169522;
 Mon, 13 Feb 2017 02:52:49 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.3.17 with HTTP; Mon, 13 Feb 2017 02:52:29 -0800 (PST)
In-Reply-To: <20170213093736.1ee183f3@tock>
References: <1486326077-17091-1-git-send-email-albeu@free.fr>
 <CAOiHx=nwBgVnZp1x2TcDVNx1hA2KYwwQnYSbCsCOJpNo-SLJPg@mail.gmail.com> <20170213093736.1ee183f3@tock>
From:   Jonas Gorski <jonas.gorski@gmail.com>
Date:   Mon, 13 Feb 2017 11:52:29 +0100
Message-ID: <CAOiHx=kkE2z9z83ctukh4XpOUpRqRo=mXqia417ABt9jymgCtQ@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Allow compressed images to be loaded at the usual address
To:     Alban <albeu@free.fr>
Cc:     MIPS Mailing List <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <jonas.gorski@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56787
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.gorski@gmail.com
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

Hi,

On 13 February 2017 at 09:37, Alban <albeu@free.fr> wrote:
> On Thu, 9 Feb 2017 13:22:37 +0100
> Jonas Gorski <jonas.gorski@gmail.com> wrote:
>
>> Hi,
>>
>> On 5 February 2017 at 21:21, Alban <albeu@free.fr> wrote:
>> > From: Alban Bedel <albeu@free.fr>
>> >
>> > Normally compressed images have to be loaded at a different address to
>> > allow the decompressor to run. This add an option to let vmlinuz copy
>> > itself to the correct address from the normal vmlinux address.
>> >
>> > Signed-off-by: Alban Bedel <albeu@free.fr>
>> > ---
>> >  arch/mips/Kconfig                |  8 ++++++++
>> >  arch/mips/boot/compressed/head.S | 13 +++++++++++++
>> >  2 files changed, 21 insertions(+)
>> >
>> > diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
>> > index b3c5bde..8074fc5 100644
>> > --- a/arch/mips/Kconfig
>> > +++ b/arch/mips/Kconfig
>> > @@ -2961,6 +2961,14 @@ choice
>> >                 bool "Extend builtin kernel arguments with bootloader arguments"
>> >  endchoice
>> >
>> > +config ZBOOT_VMLINUZ_AT_VMLINUX_LOAD_ADDRESS
>> > +       bool "Load compressed images at the same address as uncompressed"
>> > +       depends on SYS_SUPPORTS_ZBOOT
>> > +       help
>> > +         vmlinux and vmlinuz normally have different load addresses, with
>> > +         this option vmlinuz expect to be loaded at the same address as
>> > +         vmlinux.
>> > +
>> >  endmenu
>>
>> Okay, it took me a while to understand the intention of this change. I
>> thought it was for supporting the case that VMLINUZ_LOAD_ADDRESS ==
>> VMLINUX_LOAD_ADDRESS, but it is indented for  VMLINUZ_LOAD_ADDRESS !=
>> VMLINUX_LOAD_ADDRESS, but still being loaded at VMLINUX_LOAD_ADDRESS.
>>
>> So I guess that this can only happen with vmlinuz.bin, as vmlinux's
>> ELF header will cause it to be loaded at the expected address (for
>> sane bootloaders at least).
>
> Yes, this is for bootloaders that use raw images. Having to configure
> different load addresses for compressed and uncompressed images was just
> too annoying.
>
>> >  config LOCKDEP_SUPPORT
>> > diff --git a/arch/mips/boot/compressed/head.S b/arch/mips/boot/compressed/head.S
>> > index 409cb48..a215171 100644
>> > --- a/arch/mips/boot/compressed/head.S
>> > +++ b/arch/mips/boot/compressed/head.S
>> > @@ -25,6 +25,19 @@ start:
>> >         move    s2, a2
>> >         move    s3, a3
>> >
>> > +#ifdef CONFIG_ZBOOT_VMLINUZ_AT_VMLINUX_LOAD_ADDRESS
>>
>> With a bit of BAL trickery you could easily detect this at runtime and
>> then conditionally copy without requiring any additional config
>> symbols. Then you aren't limited to being executed from
>> VMLINUX_LOAD_ADDRESS.
>
> Could you expand a bit on what you mean with "BAL trickery"? I hoped
> that it would be possible to auto detect the current running address,
> but as I know very little about MIPS assembly I didn't found how that
> could be done.

With BAL (branch and link) you can do a pc-relative jump, and the
current address will be stored in $ra. comparing it with the expected
address will give you the offset by which you were loaded. To quote
the lzma-loader from OpenWrt/Lede[1]:

        la      t0, __reloc_label       # get linked address of label
        bal     __reloc_label           # branch and link to label to
        nop                             # get actual address
__reloc_label:
        subu    t0, ra, t0              # get reloc_delta
        beqz    t0, __reloc_done         # if delta is 0 we are in the
right place
        nop

        /* Copy our code to the right place */
        la      t1, _code_start         # get linked address of _code_start
        la      t2, _code_end           # get linked address of _code_end
        addu    t0, t0, t1              # calculate actual address of
_code_start

__reloc_copy:
...
__reloc_done:
...


Regards
Jonas

[1] https://git.lede-project.org/?p=source.git;a=blob;f=target/linux/ar71xx/image/lzma-loader/src/head.S;h=47a7c9bd6300ad92e6a0d426c5f44bc0f3e7e85f;hb=HEAD#l49
