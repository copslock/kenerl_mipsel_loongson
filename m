Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Apr 2016 01:57:07 +0200 (CEST)
Received: from mail-wm0-f54.google.com ([74.125.82.54]:37685 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27026019AbcDDX5Dk92RP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 5 Apr 2016 01:57:03 +0200
Received: by mail-wm0-f54.google.com with SMTP id n3so52789wmn.0
        for <linux-mips@linux-mips.org>; Mon, 04 Apr 2016 16:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=w6by330GbKI0EgULQvo3TcydlTYjxvncIBeKH07Qg/o=;
        b=JMKZ5p4+pATCZH5b5BBj/zGUlXNJhe6U4yL01LN7Ol6///1LGgooQN+FRofbuXcXgj
         7JSQNMpPbgteLcOwyviNoVFXQxyBQX337qgFcuNoYjqUo3airpgEopjwp1dSSOWVJGJK
         SdvB5W+hb5hdfA7wo2APxOYfbXOpVzUgPcoHmNeGA1Bf834n8sfHHDIEq7GSBSMivWUs
         BfUrgv1YhnkteNrBLbN/mYY3w2SWGvDxVaSHdrK98kGiQw4LJEJCMNUhs/IWrWm5wFoH
         wSvzcvM/XvIaGzVLjZ09TPzuLyC38gaFowSKwiPbSS98JKu4IA6cf94sjXo1wxjA5t2H
         4iKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=w6by330GbKI0EgULQvo3TcydlTYjxvncIBeKH07Qg/o=;
        b=H0IC3FJS4Fgqjxgokg6NI4aDNxvNK7uRdS59IJzswRKxUJ1eo/jUU5jW0LgeBTXPcz
         3ajHOQpX44hwHkKd92ECYnLfXXYlDU5lqXPik2b9Cbsks1ta0LntHHXxt1prs6oUVoCN
         CIndUpRihl5llabRrYUgkF4Emsm3147nHGlC0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=w6by330GbKI0EgULQvo3TcydlTYjxvncIBeKH07Qg/o=;
        b=j8H/HKvm8gtxwDQHbWxo9QHcr60Y2knPgSt5mVRbI/ZcT2mQErpWmJ8riEZdd1w9RN
         jEdd2dBNIkVgrTjWrapUZW3DVUsl9DZG5CemFdPoJrLrRpZvZfnXE0oXePZgtoQCdbSZ
         AjuLLiQl/yg1WZSyyp+J3TycOVnz0IzovBBYHJtvVmPcMD7igSqHpAVE+EaI3VSB6frz
         tOn99JebgfiL7IXZ6VoQA0675qObuHO4CJ6vxXG8sWGMdR97a52NcM5HetP9wL6ArPSS
         xFEPYZcAm/Nu33HQc4uEWnfW20hbQHBCx0CmFBSC69KgUwpqLHQKrTKNvQm+jhhUmWIk
         yoUQ==
X-Gm-Message-State: AD7BkJK6IlWmjrvh3Twb3CVZ4O/to5QUEBmME34YyJ5RLQbvCdDdHPi7QuinzXJv9nfJ6Ue9nxeNx6NX9w3zgOvU
MIME-Version: 1.0
X-Received: by 10.194.185.179 with SMTP id fd19mr16710298wjc.107.1459814218188;
 Mon, 04 Apr 2016 16:56:58 -0700 (PDT)
Received: by 10.28.157.205 with HTTP; Mon, 4 Apr 2016 16:56:58 -0700 (PDT)
In-Reply-To: <20160404233721.GB26295@linux-mips.org>
References: <1459415142-3412-1-git-send-email-matt.redfearn@imgtec.com>
        <CAGXu5jKMLcRmMkowF=fUEQdtccTJLR9FEWT4g_zeyZMW4BWQOg@mail.gmail.com>
        <20160404233721.GB26295@linux-mips.org>
Date:   Mon, 4 Apr 2016 16:56:58 -0700
X-Google-Sender-Auth: CLc3cAxs5doAJEeCvDHHHTruJp4
Message-ID: <CAGXu5jJ7P95T0ZyAVZagQ0LZhSg28wxkQxR-tRFkhZsHekrN_Q@mail.gmail.com>
Subject: Re: [kernel-hardening] [PATCH v2 00/11] MIPS relocatable kernel & KASLR
From:   Kees Cook <keescook@chromium.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Aaro Koskinen <aaro.koskinen@nokia.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Daney <ddaney@caviumnetworks.com>,
        Jaedon Shin <jaedon.shin@gmail.com>,
        James Hogan <james.hogan@imgtec.com>,
        Jonas Gorski <jogo@openwrt.org>,
        Paul Burton <paul.burton@imgtec.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <keescook@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52885
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

On Mon, Apr 4, 2016 at 4:37 PM, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Mon, Apr 04, 2016 at 12:46:29PM -0700, Kees Cook wrote:
>
>> This is great! Thanks for working on this! :)
>>
>> Without actually reading the code yet, I wonder if the x86 and MIPS
>> relocs tool could be merged at all? Sounds like it might be more
>> difficult though -- the relocation output is different and its storage
>> location is different...
>>
>> > Restrictions:
>> > * The new kernel is not allowed to overlap the old kernel, such that
>> >   the original kernel can still be booted if relocation fails.
>>
>> This sounds like physical-only relocation then? Is the virtual offset
>> randomized as well (like arm64) or just physical (like x86 currently
>> -- though there is a series to fix this).
>
> On MIPS we normally place the kernel in KSEG0 or XKPHYS which address
> segments which are not mapped through the TLB so the difference is
> kinda moot.

Ah-ha, excellent. Does this mean that MIPS is effectively doing memory
segmentation between userspace and kernel space (or some version of
x86's SMEP/SMAP or ARM's PXN/PAN)? I don't know much about the MIPS
architecture yet.

What do I need to fill in on these tables for MIPS?

http://kernsec.org/wiki/index.php/Exploit_Methods/Userspace_execution
http://kernsec.org/wiki/index.php/Exploit_Methods/Userspace_data_usage

>
>> > * Relocation is supported only by multiples of 64k bytes. This
>> >   eliminates the need to handle R_MIPS_LO16 relocations as the bottom
>> >   16bits will remain the same at the relocated address.
>>
>> IIUC, that's actually better than x86, which needs to be 2MB aligned.
>
> On MIPS a key concern was maintaining a reasonable size for the final
> kernel image.  The R_MIPS_LO16 relocatio records make a significant
> portion of the relocations in a relocatable .o file, so we wanted to
> get rid of them.  This results in a relocation granularity of 64kB.
> If we were truely, truely stingy we could come up with a relocation format
> to save a few more bits but I doubt that'd make any sense.
>
>> > * In 64 bit kernels, relocation is supported only within the same 4Gb
>> >   memory segment as the kernel link address (CONFIG_PHYSICAL_START).
>> >   This eliminates the need to handle R_MIPS_HIGHEST and R_MIPS_HIGHER
>> >   relocations as the top 32bits will remain the same at the relocated
>> >   address.
>>
>> Interesting. Could the relocation code be updated in the future to
>> bump the high addresses too?
>
> It could but yet again, the idea was to keep the size of the final
> generated file under control.  The R_MIPS_HIGHER and R_MIPS_HIGHEST
> relocations can be discarded if we constrain the addresses to be in
> a single 4GB segment.  Removing this constraint would make a kernel
> image much bigger so I suggested to add this restriction at least for
> this initial version.

Awesome, thanks for the details.

-Kees

-- 
Kees Cook
Chrome OS & Brillo Security
