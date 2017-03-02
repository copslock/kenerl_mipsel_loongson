Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Mar 2017 14:07:34 +0100 (CET)
Received: from mail-oi0-x241.google.com ([IPv6:2607:f8b0:4003:c06::241]:36548
        "EHLO mail-oi0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992213AbdCBNH0p8RIU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Mar 2017 14:07:26 +0100
Received: by mail-oi0-x241.google.com with SMTP id f192so5290467oic.3;
        Thu, 02 Mar 2017 05:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=2mlNnCCcLJLg8qr76ydSPB3O+ZWQC1xIMPd+ts0b/+8=;
        b=WX4y+fEY2rXVArlzsvtbBmutif16K0Ii43QztqOND3up4aumrRAX0KOWrWeMmhLnnw
         l88k3QzO5rctw8jB9nShbjVTxVGVRuSjimsCygbcZgOqJVwJujX+52/0r7T6o/Gv40eD
         x3l5VGoLAg3OYincvQL+eYodIRnmwP5uGSzF+vp7eAtI9g9QxoaJw6HP6nl7Cai6k0yI
         kf7WsSQihnfbz6kZzSH27FD5bmAvNsyUBUStkMVT+Ny3D+aajW991yvt+rT1H2xlAnL9
         vweFV8uPGLF+jv0Yw68HhGqeNq8YIPWyi4uehIC49AysM6q5DpO1v4QH3A3NcUiNsn7j
         1uag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=2mlNnCCcLJLg8qr76ydSPB3O+ZWQC1xIMPd+ts0b/+8=;
        b=miBJNKVSxhXmFX5H+EzCBCqpcUjQfoxXhmDeFRQL2/sd4efAfJbIIGNQgjlD9gomJ+
         0IzN599eb/wwYWS6BJ+pHIB6+OkWav//uqigtlEKJHwVm2fb4P7/vSDRJ/dkPjL/kPUY
         BGf8mMmcEZSiKzUhfpkbzRAzF+EgFZ821FpvZD68fOrWHOjy6s6zsG4Q2oaF8cTv6LQi
         vyKoabB3KLC0PwtSKfQjBZ2sOwFKh2ph+uNpaM++q3GJE9aBvLbtbBWgnn4XRL2ZJp4d
         5Z8M7Wfg3vNIdKXhQPGy+0IZluP5q81ak65Cfn9ZdYj0Ikb0Z8C3G60InhP7uZ4jfvYt
         J4yg==
X-Gm-Message-State: AMke39nj1KCIaPg0w83+/hg9pUgNIkU0X9tEuw/CrznEvCDZJnykhE/3bCGHqUp3HA/RkXbV4Hpbd8LUEJElOQ==
X-Received: by 10.202.83.132 with SMTP id h126mr6235760oib.136.1488460040812;
 Thu, 02 Mar 2017 05:07:20 -0800 (PST)
MIME-Version: 1.0
Received: by 10.157.6.42 with HTTP; Thu, 2 Mar 2017 05:07:20 -0800 (PST)
In-Reply-To: <20170302004607.GE27132@altlinux.org>
References: <20170302004607.GE27132@altlinux.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 2 Mar 2017 14:07:20 +0100
X-Google-Sender-Auth: jzWrqpR9uQ8M90_gXBvoyPeI8Go
Message-ID: <CAK8P3a1=-Q=gVRyk+PwqxTeTPXa4yrmqWKG7SyZng2d7bcbG=g@mail.gmail.com>
Subject: Re: [PATCH] uapi: fix another asm/shmbuf.h userspace compilation error
To:     "Dmitry V. Levin" <ldv@altlinux.org>
Cc:     linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
        linux-xtensa@linux-xtensa.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
        Hans-Christian Egtvedt <egtvedt@samfundet.no>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-s390@vger.kernel.org, linux-am33-list@redhat.com,
        x86@kernel.org, Ingo Molnar <mingo@redhat.com>,
        Haavard Skinnemoen <hskinnemoen@gmail.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Chris Zankel <chris@zankel.net>,
        Tony Luck <tony.luck@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-alpha@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linuxppc-dev@lists.ozlabs.org,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset=UTF-8
Return-Path: <arndbergmann@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56998
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

On Thu, Mar 2, 2017 at 1:46 AM, Dmitry V. Levin <ldv@altlinux.org> wrote:
> Replace size_t with __kernel_size_t to fix asm/shmbuf.h userspace
> compilation errors like this:
>
> /usr/include/asm-generic/shmbuf.h:28:2: error: unknown type name 'size_t'
>   size_t   shm_segsz; /* size of segment (bytes) */
>
> x32 is the only architecture where sizeof(size_t) is less than
> sizeof(__kernel_size_t), but as the kernel treats shm_segsz field as
> __kernel_size_t anyway, UAPI should follow.  Thanks to little-endiannes
> of x32 and 64-bit alignment of the field following shm_segsz, this
> change doesn't break ABI, and the difference doesn't manifest itself
> easily.
>
> Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>
