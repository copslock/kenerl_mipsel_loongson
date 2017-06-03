Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 03 Jun 2017 04:59:28 +0200 (CEST)
Received: from mail-pg0-x241.google.com ([IPv6:2607:f8b0:400e:c05::241]:33557
        "EHLO mail-pg0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990522AbdFCC7WDaUlA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 3 Jun 2017 04:59:22 +0200
Received: by mail-pg0-x241.google.com with SMTP id s62so3522140pgc.0
        for <linux-mips@linux-mips.org>; Fri, 02 Jun 2017 19:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:cc:cc:cc:cc:cc:cc:cc:cc:cc:cc:cc:subject
         :in-reply-to:message-id:mime-version;
        bh=KjMQHJ5O/0NL7s7lru+hruxxQaXfJddPB5LHkIwJn4g=;
        b=n2sYdwvSsKXeWms1kpKDXn3FGDS+0XF6fXP3MySk6Xz4R9FHQtmXItC423tQc+k8GK
         x33QeKaMgID+trnpHOmjEdO2BiGpRqKKK0CcQUggz/NsmuSzBlIxT4oyvf4q3J6MNLot
         EX/WcRJ4njhFGD6wZoyg8ZpSrBFVMdK3+R73Og63px9Vxz+EYIgLRSbjjrmahiVhNiGN
         yuMQ4zbgf/NG/ViaPz4K1AjElhhr+qLZkl2SiUu7s7acQDZNTTG+laHQNrnZ7wbPbc/A
         /8+BkQui/AYxLFuMoWNefj3HFw/xvqDesB4JqiGrIe72D/1KkamvoyVSSXnnggnEYZgN
         XR3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:cc:cc:cc:cc:cc:cc:cc:cc:cc:cc:cc
         :subject:in-reply-to:message-id:mime-version;
        bh=KjMQHJ5O/0NL7s7lru+hruxxQaXfJddPB5LHkIwJn4g=;
        b=RDjR3qnWEGXUVrICtXJNqfvhSlZ4ZQO7WhV5iX+rT6tMdrBu9Mmj2wdwmOaLf3HfvE
         F+5qUve4saFzfBUP+AHLfiZLgIL4UIIPvwNfp+FpYPll2vQJCNy74yHL8TnLBvWVYzUx
         5DfV2/MZWyPHxKHbh1rxO0eXjO6vzAktDsfswiZxo7QWooQRuK6usq7sjLe63S6v2t2N
         iou5BChVemk2gvY69+tX83f1k8ZnPAW6YRtwZjonHB8LXVsCJ6uJkd9NFntGK1sRNlC1
         nuQKnbkZ9muEiFSx4/1YZnLAsvPPKErUkAHF/pRDMlDD+AvR83NATA9Zb5y3SggLHtBn
         17Sg==
X-Gm-Message-State: AODbwcBufi3Y96xZv2n+XtW1rOQZn1LQAf6vw6UlpvxP9oyk3taeeYeW
        nwGKvvPtdoni4XrJ
X-Received: by 10.84.198.35 with SMTP id o32mr2977685pld.67.1496458756026;
        Fri, 02 Jun 2017 19:59:16 -0700 (PDT)
Received: from localhost ([216.38.154.21])
        by smtp.gmail.com with ESMTPSA id v188sm37430191pgv.51.2017.06.02.19.59.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Jun 2017 19:59:15 -0700 (PDT)
Date:   Fri, 02 Jun 2017 19:59:15 -0700 (PDT)
X-Google-Original-Date: Fri, 02 Jun 2017 19:59:11 PDT (-0700)
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     geert@linux-m68k.org
CC:     monstr@monstr.eu
CC:     ralf@linux-mips.org
CC:     liqin.linux@gmail.com
CC:     lennox.wu@gmail.com
CC:     ysato@users.sourceforge.jp
CC:     dalias@libc.org
CC:     davem@davemloft.net
CC:     linux-mips@linux-mips.org
CC:     linux-sh@vger.kernel.org
CC:     sparclinux@vger.kernel.org
CC:     linux-kernel@vger.kernel.org
CC:     linux-arch@vger.kernel.org
Subject:     Re: Unify the various copies of libgcc into lib
In-Reply-To: <CAMuHMdUP2RbjV+09UGkzjJcRrsoyy9F6XT8fbCPEd0mQCDFvFw@mail.gmail.com>
Message-ID: <mhng-d2e4c1c0-792e-4de2-ae3f-7cceb4c7508a@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Return-Path: <palmer@dabbelt.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58181
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: palmer@dabbelt.com
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

On Wed, 24 May 2017 02:21:22 PDT (-0700), geert@linux-m68k.org wrote:
> Hi Palmer,
>
> On Wed, May 24, 2017 at 12:05 AM, Palmer Dabbelt <palmer@dabbelt.com> wrote:
>> I'm in the process of submitting the RISC-V Linux port, and someone noticed
>> that we were adding copies of some libgcc emulation routines that were the same
>> as some of the other ports.  This prompted me to go through and check all the
>> ports for libgcc.h and to merge the versions that were functionally identical.
>>
>> The only difference in libgcc.h was that there was a #define for little vs big
>> endian.  The differences in the emulation routines were all just whitespace.
>>
>> This patch set comes in two parts:
>>
>>  * Patch 1 adds new copies of all the C files copied from libgcc, as well as
>>    moving libgcc.h to include/lib (that's a new folder, which probably means
>>    it's the wrong place to put it, but I couldn't find anything better).  There
>>    are Kconfig entries for each of these library functions so architectures can
>>    select them one at a time.
>
> I would call the Kconfig symbols GENERIC_* instead of LIB_*, for consistency
> with other generic implementations.

OK.  I'll include that in my v2 patch set.

>>  * The rest of the patches convert each architecture over to the new system.
>
> Thanks! For all but "[PATCH 4/7] mips: ...":
>
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Thanks!

>> Unless I screwed something up, this patch set shouldn't actually change any
>> functionality.  Unfortunately I don't actually have all these cross compilers
>> setup so I can't actually test any of this, but I did convert the RISC-V port
>> over to using this system and it appears to be OK there so at least this isn't
>> completely broken.
>
> https://www.kernel.org/pub/tools/crosstool/

Cool.  I'll build everything before I submit a v2.
