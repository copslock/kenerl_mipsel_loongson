Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 03 Jun 2017 04:18:20 +0200 (CEST)
Received: from mail-pg0-x242.google.com ([IPv6:2607:f8b0:400e:c05::242]:33194
        "EHLO mail-pg0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990506AbdFCCSN5XVUu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 3 Jun 2017 04:18:13 +0200
Received: by mail-pg0-x242.google.com with SMTP id s62so3449274pgc.0
        for <linux-mips@linux-mips.org>; Fri, 02 Jun 2017 19:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:cc:cc:cc:cc:cc:cc:cc:cc:cc:cc:cc:cc:subject
         :in-reply-to:message-id:mime-version;
        bh=INoz5uPlqkLFWzmoLLjq32dbhpnnNk/iSao+NGy/tmE=;
        b=S+6waR3dYW5/FLw3zddcG4EyfFcgKJFLF3Y66OSaibqD5HCE8JuDf+8m/kEBFcPkDS
         8e3DBrqCqQ5RBwE/JyWchBmxhUCcytEH6PLapYWSMOWjXg1ifrcq6j4kMtEQRgtNj7OB
         ycph2owda3BoTs6x6q8uzq1nJ9M7ioilmHwpBbPnvn4UG8O5EtdFPcydJVlghJ/DmfuZ
         pF9JLaQ7jQRzaBHslLuh8ktviqJZPNpyhNjQa4sNDXhj49fLWXtJTrWpEpweouQx8Jjy
         B2E+ztFT2u+E3qFMZk4eZaERXw++sSVCBi+Xn5p1HCQt5zN+iPKQHfcyvWtkb5swN1Dn
         8Vhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:cc:cc:cc:cc:cc:cc:cc:cc:cc:cc:cc
         :cc:subject:in-reply-to:message-id:mime-version;
        bh=INoz5uPlqkLFWzmoLLjq32dbhpnnNk/iSao+NGy/tmE=;
        b=s8dcrJ+ZSV4HcF9PDMEPyhI5FSSJl5t+aUBiKCKcu7B0bqN8kUeBGAg1gye2QsVRtT
         absmX7L2+/AlvSt+sq9qYGAzh4l42LvizgWod7JnFWu71TJ2H57cbFYxnEtYPrclU/Xf
         b8IsYmu0at8Uc9MkhhzVZVmEWBFOiivtpZytZZqK2d/0Tg9KyoFWzoWh/Z4fslXERP2H
         aMW5XTQ6S7cdrGNm/kBz9xSew279FW2IbMOnECSNf96EMfoxXqURGtamEA4B++/ElKXs
         p/EZ2y/daiC6eXQDW7oyeBoTnxNVKyzsv7qsKmr53+jqx37luSDjbRdcxuzf+J5wHTvI
         s3AA==
X-Gm-Message-State: AODbwcATC5pizugg+411dW26OHaOKlpge+5OEBu5KbXw9VdhPKChmVVO
        T5rAKYXMUdEgQXf7
X-Received: by 10.98.30.129 with SMTP id e123mr9951909pfe.240.1496456288115;
        Fri, 02 Jun 2017 19:18:08 -0700 (PDT)
Received: from localhost ([216.38.154.21])
        by smtp.gmail.com with ESMTPSA id g70sm43753892pfc.47.2017.06.02.19.18.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Jun 2017 19:18:07 -0700 (PDT)
Date:   Fri, 02 Jun 2017 19:18:07 -0700 (PDT)
X-Google-Original-Date: Fri, 02 Jun 2017 19:06:34 PDT (-0700)
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     matt.redfearn@imgtec.com
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
CC:     geert@linux-m68k.org
CC:     linux-kernel@vger.kernel.org
CC:     linux-arch@vger.kernel.org
Subject:     Re: [PATCH 1/7] lib: Add shared copies of some GCC library routines
In-Reply-To: <4448bb28-fa2f-3a4c-753e-46bc4c3815a3@imgtec.com>
Message-ID: <mhng-30ac217d-aaf3-47bd-bfe7-cc86e4660f58@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Return-Path: <palmer@dabbelt.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58179
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

On Wed, 24 May 2017 01:52:13 PDT (-0700), matt.redfearn@imgtec.com wrote:
> Hi Palmer
>
>
> On 23/05/17 23:05, Palmer Dabbelt wrote:
>> Many ports (m32r, microblaze, mips, parisc, score, and sparc) use
>> functionally identical copies of various GCC library routine files,
>> which came up as we were submitting the RISC-V port (which also uses
>> some of these).
>>
>> This patch adds a new copy of these library routine files, which are
>> functionally identical to the various other copies.  These are
>> availiable via Kconfig as CONFIG_LIB_$ROUTINE, which currently isn't
>> used anywhere.
>
> Note that, on MIPS, we had to mark the compiler intrinsics as notrace
> (see commit aedcfbe06558a9f53002e82d5be64c6c94687726) because if the
> compiler requires the intrinsic in the ftrace path, it then tries to
> trace itself leading to infinite recursion and stack overflow. So I'd
> suggest you mark the generic versions notrace as well.

Sorry, I didn't notice that.  I got a bit swamped responding to the RISC-V
port's code reviews, but assuming nobody has merged any of this I'll submit a
v2 patch set that fixes this (and some other errors I believe I introduced)
once I get through all my email.

Thanks!
