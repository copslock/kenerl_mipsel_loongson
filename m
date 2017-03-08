Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Mar 2017 09:24:14 +0100 (CET)
Received: from mail-qk0-x244.google.com ([IPv6:2607:f8b0:400d:c09::244]:36174
        "EHLO mail-qk0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991960AbdCHIYHmEAqK convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 8 Mar 2017 09:24:07 +0100
Received: by mail-qk0-x244.google.com with SMTP id n141so8716173qke.3
        for <linux-mips@linux-mips.org>; Wed, 08 Mar 2017 00:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=tVmo+mVTMXETQ9UF2+zW0JR4iSoG3E0hJPvJnf9n6zM=;
        b=FdRqotQf1teSdIYHBCPv3kDAri0TdQzyuF8IOKJpTTLd8MVPATrcYBl7/DqO0CeLo9
         37sIMAhmJ7MiKi4uLIf+znne6STRDf2d1bmECSiVynTor6jxauAmUnkzRlobJaC/zERx
         kjMMReZ53rDGdDxSGQkuB6jUwSqJfuTBa9nK6yyYD3i2CfM8X89Y/VDOJSHwtX01OmSa
         M7ZRbMETBGz/wZYXVJnDbm8tYYN/yLvqaoL+gGYQE0zpqQq7ZJWY04spW79Wn+JGoT/6
         1JEaL+h3oLu927ylM+uJ0FcTzDLaqoScPYiYMwLNe6BUeFxDq/vuucYUpQgoVwKZyONJ
         owww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=tVmo+mVTMXETQ9UF2+zW0JR4iSoG3E0hJPvJnf9n6zM=;
        b=G2KmqDP8kRqrQ8PSyaH1w8VzriENHDogdZrpUdgzwiCk6KhgnWsu9y8uxXC9Kh7hW4
         s2HG27f5smSabgKL49P5n5J1ZvIuGQwAXF0RkxXUHpUQPgxzhXYPmjwk6nhpltCugbnK
         l6zb1vUG5TrsU9IXEhCdjAPkROlJzFsIJqXxo4qBTEqV1ondN6Byp7pPItqIHz6N9Mvk
         nV+WPRtdqoLDrIwdVdPIaJY90SVSXTxLnYsbN/iQKGK2YXUgKfDVcDDbF6coxsNqOlfb
         Vshh3u0q2HQ5kGBx/18h3mWD7ZSPMszVkkbiHONLHgjA63U+ZsOq2PDFkBB/0NkxZEWs
         2E+g==
X-Gm-Message-State: AMke39nGWfdUNXW96wrbQOGFw/rzGQewvx3/TV1ycV7WKzQcXDVlKO7HOy2XiYHHReVlg3VfKcDUGb2afHM/pg==
X-Received: by 10.55.123.5 with SMTP id w5mr6325756qkc.76.1488961441977; Wed,
 08 Mar 2017 00:24:01 -0800 (PST)
MIME-Version: 1.0
Received: by 10.237.58.165 with HTTP; Wed, 8 Mar 2017 00:24:01 -0800 (PST)
In-Reply-To: <58bf7d43.8173190a.8d21e.1fde@mx.google.com>
References: <58bf7d43.8173190a.8d21e.1fde@mx.google.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 8 Mar 2017 09:24:01 +0100
X-Google-Sender-Auth: mfXewlnuc2bMIiV0ZNLYO4bQI4Q
Message-ID: <CAK8P3a16cpvK3_a0Rxx+XqRw_d97LtVgpzcpvpzmH6U4Ty-fXQ@mail.gmail.com>
Subject: Re: next build: 208 builds: 21 failed, 187 passed, 53 errors, 406
 warnings (next-20170308)
To:     "kernelci.org bot" <bot@kernelci.org>
Cc:     kernel-build-reports@lists.linaro.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mips@linux-mips.org, Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <arndbergmann@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57082
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

On Wed, Mar 8, 2017 at 4:40 AM, kernelci.org bot <bot@kernelci.org> wrote:
> next build: 208 builds: 21 failed, 187 passed, 53 errors, 406 warnings
>
> allmodconfig (arm) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
> :1325:2: warning: #warning syscall statx not implemented [-Wcpp]

The syscall was added to 4.11, and the warning will be resolved as soon
as all architectures add it to their tables.

> drivers/usb/gadget/udc/atmel_usba_udc.c:632:554: warning: 'ept_cfg' may be
> used uninitialized in this function [-Wmaybe-uninitialized]

I just resent my fix for the second time

> drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c:743:178:
> warning: the address of '__func__' will always evaluate as 'true'
> [-Waddress]

A new regresssion as of today, won't be able to look myself, but this
should be trivial to address.

> bmips_be_defconfig (mips) — FAIL, 1 error, 1 warning, 0 section mismatches
>
> Errors:
> arch/mips/kernel/smp-bmips.c:183:38: error: implicit declaration of function
> 'task_stack_page' [-Werror=implicit-function-declaration]

A new regression from the end of the merge window, also present in mainline.
I sent a fix yesterday, addressing various mips build failures.

> cavium_octeon_defconfig (mips) — FAIL, 4 errors, 4 warnings, 0 section
> mismatches
> Warnings:
> drivers/staging/octeon/ethernet-rx.c:339:28: warning: unused variable 'priv'
> [-Wunused-variable]

I sent the patch on Feb 17, resent the same one today

> defconfig (arm64) — PASS, 0 errors, 4 warnings, 0 section mismatches
>
> Warnings:
> :1325:2: warning: #warning syscall statx not implemented [-Wcpp]
> fs/overlayfs/inode.c:322:30: warning: 'ovl_i_mutex_key' defined but not used
> [-Wunused-variable]
> fs/overlayfs/inode.c:323:30: warning: 'ovl_i_mutex_dir_key' defined but not
> used [-Wunused-variable]

New regression as of today, haven't looked but seems trivial

> defconfig+CONFIG_KASAN=y (x86) — PASS, 0 errors, 5 warnings, 0 section
> mismatches
>
> Warnings:
> net/wireless/nl80211.c:1415:1: warning: the frame size of 2232 bytes is
> larger than 2048 bytes [-Wframe-larger-than=]
> net/wireless/nl80211.c:4443:1: warning: the frame size of 2232 bytes is
> larger than 2048 bytes [-Wframe-larger-than=]
> net/wireless/nl80211.c:5743:1: warning: the frame size of 2064 bytes is
> larger than 2048 bytes [-Wframe-larger-than=]
> net/wireless/nl80211.c:1904:1: warning: the frame size of 3784 bytes is
> larger than 2048 bytes [-Wframe-larger-than=]
> drivers/tty/vt/keyboard.c:1472:1: warning: the frame size of 2344 bytes is
> larger than 2048 bytes [-Wframe-larger-than=]

This is an old bug, I sent a first version of a longer patch series last
week, will need to be updated next week, but I hope to get this into v4.11.

    Arnd
