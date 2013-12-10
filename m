Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Dec 2013 09:48:46 +0100 (CET)
Received: from mail-oa0-f45.google.com ([209.85.219.45]:55516 "EHLO
        mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823162Ab3LJIslRkvpX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 10 Dec 2013 09:48:41 +0100
Received: by mail-oa0-f45.google.com with SMTP id o6so5227778oag.32
        for <multiple recipients>; Tue, 10 Dec 2013 00:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ag3fQn5EnQjvDgtumvuok85+Kwk+plmswNc5IjULU4Q=;
        b=qhyOdNsMjRUbcIFkP5ISd+WEZ8reC47ch7+/57apI3P/os1HAdfqwG52SF7SGOhJGJ
         BPCmM8H18VSrVmgUmQMP6kb9B164Fbr3h0Ui3v9hmaY2RTOZ+UiaE7Us8zQNYUSguLgT
         PuIvQDkUsFK9h61SMoweIeOqHac6i+sYdTfJUyXNlGD9igPD5jIkm2r59iD16MZjC8uC
         bAho3PCwGrKFeZ2Y+4bbt6jDO9nLUxHiw8t7q3EinEGwH+MxWgTt8qGCfKxmqfHXR3h2
         8/RN17gYzVNX5Qtcfqt/xVJ/oxG/7Kd9HlakjdEWWIbjjoSmDjfLooiFU/neFUExP/YU
         HDiw==
MIME-Version: 1.0
X-Received: by 10.60.56.70 with SMTP id y6mr15833604oep.32.1386665314691; Tue,
 10 Dec 2013 00:48:34 -0800 (PST)
Received: by 10.76.10.41 with HTTP; Tue, 10 Dec 2013 00:48:34 -0800 (PST)
In-Reply-To: <1385396045-15852-1-git-send-email-msalter@redhat.com>
References: <1385396045-15852-1-git-send-email-msalter@redhat.com>
Date:   Tue, 10 Dec 2013 09:48:34 +0100
Message-ID: <CACM3HyGCPMbw3t+DFFSySEytvDMnGGQMS6pVFpGbhkAoDzjhXg@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] Consolidate asm/fixmap.h files
From:   Jonas Bonn <jonas.bonn@gmail.com>
To:     Mark Salter <msalter@redhat.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Russell King <linux@arm.linux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Richard Kuo <rkuo@codeaurora.org>,
        linux-hexagon@vger.kernel.org,
        James Hogan <james.hogan@imgtec.com>,
        linux-metag@vger.kernel.org, Michal Simek <monstr@monstr.eu>,
        microblaze-uclinux@itee.uq.edu.au, linux-mips@linux-mips.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <jonas.bonn@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38689
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.bonn@gmail.com
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

Hi Mark,

Is there some reason you've excluded OpenRISC here?  Did you just miss
it, or does the implementation diverage too much to be usable with
your generic version?

Regards,
Jonas

On 25 November 2013 17:13, Mark Salter <msalter@redhat.com> wrote:
> Many architectures provide an asm/fixmap.h which defines support for
> compile-time 'special' virtual mappings which need to be made before
> paging_init() has run. This suport is also used for early ioremap
> on x86. Much of this support is identical across the architectures.
> This patch consolidates all of the common bits into asm-generic/fixmap.h
> which is intended to be included from arch/*/include/asm/fixmap.h.
>
> This has been compiled on x86, arm, powerpc, and sh, but tested
> on x86 only.
>
> This is version two of the patch series:
>
>    git://github.com/mosalter/linux.git#fixmap-v2
>
> Version 1 is here:
>
>    git://github.com/mosalter/linux.git#fixmap
>
> Changes from v1:
>
>   * Added acks from feedback.
>   * Use BUILD_BUG_ON in fix_to_virt()
>   * Fixed ARM patch to make FIXMAP_TOP inclusive of fixmap
>     range as is the case in the other architectures.
>
> Mark Salter (11):
>   Add generic fixmap.h
>   x86: use generic fixmap.h
>   arm: use generic fixmap.h
>   hexagon: use generic fixmap.h
>   metag: use generic fixmap.h
>   microblaze: use generic fixmap.h
>   mips: use generic fixmap.h
>   powerpc: use generic fixmap.h
>   sh: use generic fixmap.h
>   tile: use generic fixmap.h
>   um: use generic fixmap.h
>
>  arch/arm/include/asm/fixmap.h        | 29 +++--------
>  arch/arm/mm/init.c                   |  2 +-
>  arch/hexagon/include/asm/fixmap.h    | 40 +--------------
>  arch/metag/include/asm/fixmap.h      | 32 +-----------
>  arch/microblaze/include/asm/fixmap.h | 44 +---------------
>  arch/mips/include/asm/fixmap.h       | 33 +-----------
>  arch/powerpc/include/asm/fixmap.h    | 44 +---------------
>  arch/sh/include/asm/fixmap.h         | 39 +--------------
>  arch/tile/include/asm/fixmap.h       | 33 +-----------
>  arch/um/include/asm/fixmap.h         | 40 +--------------
>  arch/x86/include/asm/fixmap.h        | 59 +---------------------
>  include/asm-generic/fixmap.h         | 97 ++++++++++++++++++++++++++++++++++++
>  12 files changed, 118 insertions(+), 374 deletions(-)
>  create mode 100644 include/asm-generic/fixmap.h
>
> --
> 1.8.3.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arch" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Jonas Bonn
Stockholm, Sweden
