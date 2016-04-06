Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Apr 2016 10:09:50 +0200 (CEST)
Received: from mail-wm0-f50.google.com ([74.125.82.50]:36222 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007830AbcDFIJsihpIi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 6 Apr 2016 10:09:48 +0200
Received: by mail-wm0-f50.google.com with SMTP id v188so13777652wme.1
        for <linux-mips@linux-mips.org>; Wed, 06 Apr 2016 01:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=d8Fr4ZRaemsG0jZkd4DgjDxPDONerwY/bcQQllnenTE=;
        b=mHxH/dTxabmirlOER+vkVu+cFVzejbX+qihjsZVDE0ZxYzcFW3qRDrMMO5qKjYK7FF
         JkLBq2jEMeyGmqXIBAh0W5Q+0w7LBpkRbh/PuEfO05LaOKFXk2YwqMZA5FN9xl1MPurX
         o50YPxH6/hGnjajY/Di6X05bBexuxTUo7tW6eMSiM4lSN83ONlBUTdcax7ygfHBi5GZz
         DVWCt2dSS3I3DL5DqlIh5Hajg/u8+y9xzbYCwhRO0nAtLDHC69kG96dca8+SFFJ8jZ9s
         s9wWi9pNvVYbNa8HndCiGIlJ2BM08/xooyfUiJctD8+sqnY+lBS5DRa7VzC/VZoJwNTw
         HBKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=d8Fr4ZRaemsG0jZkd4DgjDxPDONerwY/bcQQllnenTE=;
        b=me4zoLvUvShUf/J8m9ZKnqnv4l6dQCrZpXa6izGcWYdHxi3+7Wvo4jUix9QivsYWZS
         1wctMKgPwlQoIXKEVUq0wqC6Xq37D8in/kj8nR39j55V/XfFeV8jdNYPmZQUAr+Xa+A4
         Ay7uXQlszdCLBBevR/tXyaJPUUKmAoDk5PU7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=d8Fr4ZRaemsG0jZkd4DgjDxPDONerwY/bcQQllnenTE=;
        b=dldhB+cO62IirPLDEL/39vqykh1yhGMeIWxRmfzD97nY/KKEwBY6Vzi/j/0Aa/d1/2
         PKqMONn8YY21LhcG1u2Qz/L/xXa27DlA9K4MGj50ucUCtZ+GsyxfRzIzMVJY7dwMfjEs
         bs2cTC4g2548LJIg48dtwhsQYN2mmCgg27AG+3hjfVPg2dMPksExdJgXWvKGN26I3AlK
         nY5VBHnN8tjesOeAaO4urJ3JRZGs7m8JWVpHcmLtrUNHNo8Ow+c91qdnhSn9jzG0o7dB
         yboBbDlNvgfs7RKxknwi7gvh7y0lmf2anLe1RtlP9p+IRVG/MQSctOhpZAE7e22zYVqt
         Hdxg==
X-Gm-Message-State: AD7BkJI9TLWUZB/ssaTKHOg9jev08YVnYVeF98UWlqKdXIQa5nz/B/gowNsNKB/0W9IvxiKSgZYGIV0j5jF9tyIB
MIME-Version: 1.0
X-Received: by 10.194.185.179 with SMTP id fd19mr21598277wjc.107.1459879840908;
 Tue, 05 Apr 2016 11:10:40 -0700 (PDT)
Received: by 10.28.157.205 with HTTP; Tue, 5 Apr 2016 11:10:40 -0700 (PDT)
In-Reply-To: <20160405090923.GF31316@jhogan-linux.le.imgtec.org>
References: <1459415142-3412-1-git-send-email-matt.redfearn@imgtec.com>
        <CAGXu5jKMLcRmMkowF=fUEQdtccTJLR9FEWT4g_zeyZMW4BWQOg@mail.gmail.com>
        <20160404233721.GB26295@linux-mips.org>
        <CAGXu5jJ7P95T0ZyAVZagQ0LZhSg28wxkQxR-tRFkhZsHekrN_Q@mail.gmail.com>
        <20160405090923.GF31316@jhogan-linux.le.imgtec.org>
Date:   Tue, 5 Apr 2016 11:10:40 -0700
X-Google-Sender-Auth: A93UR9GO__oPzmiYoEIs5jEBMMc
Message-ID: <CAGXu5jJ5B+MEg7SVgbmWju+y8XYnbunvfdR0ZD_tfz-u=iB03w@mail.gmail.com>
Subject: Re: [kernel-hardening] [PATCH v2 00/11] MIPS relocatable kernel & KASLR
From:   Kees Cook <keescook@chromium.org>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        "kernel-hardening@lists.openwall.com" 
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
        Jonas Gorski <jogo@openwrt.org>,
        Paul Burton <paul.burton@imgtec.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <keescook@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52892
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

On Tue, Apr 5, 2016 at 2:09 AM, James Hogan <james.hogan@imgtec.com> wrote:
> On Mon, Apr 04, 2016 at 04:56:58PM -0700, Kees Cook wrote:
>> On Mon, Apr 4, 2016 at 4:37 PM, Ralf Baechle <ralf@linux-mips.org> wrote:
>> > On Mon, Apr 04, 2016 at 12:46:29PM -0700, Kees Cook wrote:
>> >
>> >> This is great! Thanks for working on this! :)
>> >>
>> >> Without actually reading the code yet, I wonder if the x86 and MIPS
>> >> relocs tool could be merged at all? Sounds like it might be more
>> >> difficult though -- the relocation output is different and its storage
>> >> location is different...
>> >>
>> >> > Restrictions:
>> >> > * The new kernel is not allowed to overlap the old kernel, such that
>> >> >   the original kernel can still be booted if relocation fails.
>> >>
>> >> This sounds like physical-only relocation then? Is the virtual offset
>> >> randomized as well (like arm64) or just physical (like x86 currently
>> >> -- though there is a series to fix this).
>> >
>> > On MIPS we normally place the kernel in KSEG0 or XKPHYS which address
>> > segments which are not mapped through the TLB so the difference is
>> > kinda moot.
>>
>> Ah-ha, excellent. Does this mean that MIPS is effectively doing memory
>> segmentation between userspace and kernel space (or some version of
>> x86's SMEP/SMAP or ARM's PXN/PAN)? I don't know much about the MIPS
>> architecture yet.
>
> User and kernel virtual address spaces don't traditionally overlap, so
> you don't get that sort of protection at the moment.
>
> MIPS TLBs do have ASIDs though, and kernel mappings are marked global,
> so it could easily reserve an ASID with no mappings, and switch to that
> while in kernel mode. It'd have to keep switching between them when
> reading/writing userland though, as you can't directly access another
> ASID, and I don't think thats a particularly cheap operation, especially
> on cores with hardware page table walkers.

Yeah, it seems that x86 SMAP has some performance problems too. I'd be
curious to see how much of a hit it would be to use ASID switching on
MIPS.

> EVA (enhanced virtual addressing) is a feature present on recent MIPS
> 32-bit i-class and p-class cores (and p6600 too which is 64-bit),
> intended to make better use of 32-bit virtual address space. It can
> actually overlap kernel and virtual address space, requiring special
> instructions for accessing userland mappings, however each segment can't
> have distinct TLB mappings for kernel and user mode (if kernel and user
> view of segment differs, kernel would need to see it unmapped, i.e. a
> window into physical memory). As such its generally better to keep the
> lowest segment visible to both kernel and user, so that kernel NULL
> dereferences can still be caught, which would negate the point of using
> it for security. It is possible to make it work with watchpoints to
> catch NULL dereferences in lowest 4KB, so kernel can't access any user
> address space directly, but thats a bit of a hack really. Also since EVA
> is aimed at making better use of 32-bit address space, it doesn't
> address 64-bit.

Ah, so it couldn't cover a 64-bit userspace range? It seems like it
might work for 32-bit if mmap_min_addr sysctl was used to choose the
size of the low-address shared mapping.

>> What do I need to fill in on these tables for MIPS?
>>
>> http://kernsec.org/wiki/index.php/Exploit_Methods/Userspace_execution
>> http://kernsec.org/wiki/index.php/Exploit_Methods/Userspace_data_usage
>
> Both are best addressed using ASID switching in my opinion at the
> moment.

Okay, thanks, I'll make a note.

-Kees

>
> Cheers
> James
>
>>
>> >
>> >> > * Relocation is supported only by multiples of 64k bytes. This
>> >> >   eliminates the need to handle R_MIPS_LO16 relocations as the bottom
>> >> >   16bits will remain the same at the relocated address.
>> >>
>> >> IIUC, that's actually better than x86, which needs to be 2MB aligned.
>> >
>> > On MIPS a key concern was maintaining a reasonable size for the final
>> > kernel image.  The R_MIPS_LO16 relocatio records make a significant
>> > portion of the relocations in a relocatable .o file, so we wanted to
>> > get rid of them.  This results in a relocation granularity of 64kB.
>> > If we were truely, truely stingy we could come up with a relocation format
>> > to save a few more bits but I doubt that'd make any sense.
>> >
>> >> > * In 64 bit kernels, relocation is supported only within the same 4Gb
>> >> >   memory segment as the kernel link address (CONFIG_PHYSICAL_START).
>> >> >   This eliminates the need to handle R_MIPS_HIGHEST and R_MIPS_HIGHER
>> >> >   relocations as the top 32bits will remain the same at the relocated
>> >> >   address.
>> >>
>> >> Interesting. Could the relocation code be updated in the future to
>> >> bump the high addresses too?
>> >
>> > It could but yet again, the idea was to keep the size of the final
>> > generated file under control.  The R_MIPS_HIGHER and R_MIPS_HIGHEST
>> > relocations can be discarded if we constrain the addresses to be in
>> > a single 4GB segment.  Removing this constraint would make a kernel
>> > image much bigger so I suggested to add this restriction at least for
>> > this initial version.
>>
>> Awesome, thanks for the details.
>>
>> -Kees
>>
>> --
>> Kees Cook
>> Chrome OS & Brillo Security



-- 
Kees Cook
Chrome OS & Brillo Security
