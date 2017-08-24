Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Aug 2017 00:19:31 +0200 (CEST)
Received: from mail-oi0-x229.google.com ([IPv6:2607:f8b0:4003:c06::229]:34649
        "EHLO mail-oi0-x229.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994798AbdHXWTXzF7iJ convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 25 Aug 2017 00:19:23 +0200
Received: by mail-oi0-x229.google.com with SMTP id j144so7496199oib.1;
        Thu, 24 Aug 2017 15:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=aeDM+e9RYgq9B1fgDslt4HHzzy3X46qRhxqISfHBOds=;
        b=Sb9eDL84jYTWETKbeSddvMlxu9gTZCFV0rQq4+ZJJ59orgOnayxwXjuL+efejtAefm
         KG0mah30aPDuaHvSrPm+SJOO3xwNhSLenvPQ2b5vCm0BCCB5vKRSrBE/gmnppNYYqM8F
         GaEaZmjY2FSlAwfKR+tmVOEUGCLqZYLLqx0STSwuqWtUcVHcoW/F4+HEDltDARU0oshP
         z92ygiIe8BAHzPMEGySNY/CaDlhRLdHC9LdSExnyvMJHJTnnI/m/pjEdYK+yFRdbhhRR
         g4uQHZ8at2g5OSWYqqEvT3ECo1qZUvRfcDiMQtgwgz3vnfoI7Wf/0XDhLkxU+ul503ok
         QkGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=aeDM+e9RYgq9B1fgDslt4HHzzy3X46qRhxqISfHBOds=;
        b=gceo+BU8CLolGmrTVMODriSi4us14sPeJtwlVvrGKW/mAxzPRojYQmpB280XReW1Fo
         8AtqQ3i2k9u4M0GUXmN+jDYcTTqCgN3r0Vm8TPJTh9+c0aedKR9SY3i6ipL0RxSxZy0j
         /68o/JIXsOQb+nUw2cHuUZHJ5NYCyiCxyhAfYB+bHfzXgNJfc8bnZn1Yqd43WG0wBuSQ
         E/x/LKGZx8BmvLgLAkvbucxR5zImD5hvHejy7UYqcbcMilNcEkWW8uJgE3euPqncsam1
         7bXf57Ez/l3VR6oHDdm85KuKkg3r3ok+I/VDmQdwT7eI5r6qYB908V9epqW0ZlcPrKKZ
         G/WA==
X-Gm-Message-State: AHYfb5jhOgMSAn0ue0PYtTJZLPMyxYt0UURIxu79Hm/FcHwdATupjODq
        1oTZaJmx35oPoeDf13gIWZo0AS4HkQ==
X-Received: by 10.202.44.18 with SMTP id s18mr10660457ois.206.1503613157892;
 Thu, 24 Aug 2017 15:19:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.157.83.21 with HTTP; Thu, 24 Aug 2017 15:19:17 -0700 (PDT)
In-Reply-To: <599ea3e4.b785df0a.aff31.4380@mx.google.com>
References: <599ea3e4.b785df0a.aff31.4380@mx.google.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 25 Aug 2017 00:19:17 +0200
X-Google-Sender-Auth: jI9Y-jseb1Z9cF-2qiNnPltBQrU
Message-ID: <CAK8P3a3G8Mo7qsgnbEXNHzU9MRRCppWhBgAT4DF-z3xgiK+WLA@mail.gmail.com>
Subject: Re: next/master build: 212 builds: 3 failed, 209 passed, 384 errors,
 58 warnings (next-20170824)
To:     Paul Burton <paul.burton@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     Kernel Build Reports Mailman List 
        <kernel-build-reports@lists.linaro.org>,
        "kernelci.org bot" <bot@kernelci.org>,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-Path: <arndbergmann@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59796
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

On Thu, Aug 24, 2017 at 12:01 PM, kernelci.org bot <bot@kernelci.org> wrote:
>
> next/master build: 212 builds: 3 failed, 209 passed, 384 errors, 58 warnings (next-20170824)
> Full Build Summary: https://kernelci.org/build/next/branch/master/kernel/next-20170824/
> Tree: next
> Branch: master
> Git Describe: next-20170824
> Git Commit: 9506597de2cde02d48c11d5c250250b9143f59f7
> Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> Built: 4 unique architectures
>
> Build Failures Detected:
>
> mips: gcc version 6.3.0 (GCC)
> cavium_octeon_defconfig FAIL
> decstation_defconfig FAIL
> jmr3927_defconfig FAIL

We currently get three build failures on linux-next, all on MIPS, and
caused by the same patch series from Paul Burton if I read this right:

> cavium_octeon_defconfig (mips) — FAIL, 378 errors, 0 warnings, 0 section mismatches
>
> Errors:
> arch/mips/kernel/octeon_switch.S:19: Error: unrecognized opcode `leaf(resume)'
> arch/mips/kernel/octeon_switch.S:21: Error: invalid operands `mfc0 t1,CP0_STATUS'
> arch/mips/kernel/octeon_switch.S:22: Error: unrecognized opcode `long_s t1,THREAD_STATUS(a0)'
> arch/mips/kernel/octeon_switch.S:23: Error: unrecognized opcode `cpu_save_nonscratch a0'
> ...

Apparently caused by dc2dd0508e19 ("MIPS: Move r4k FP code from
r4k_switch.S to r4k_fpu.S")

> decstation_defconfig (mips) — FAIL, 3 errors, 0 warnings, 0 section mismatches
>
> Errors:
> arch/mips/kernel/r2300_fpu.S:40: Error: unrecognized opcode `export_symbol(_save_fp)'
> arch/mips/kernel/r2300_fpu.S:41: Error: unrecognized opcode `fpu_save_single $4,$9'
> arch/mips/kernel/r2300_fpu.S:49: Error: unrecognized opcode `fpu_restore_single $4,$9'

Same for jmr3927_defconfig, both caused by 4e967a53718f ("MIPS: Move r2300
FP code from r2300_switch.S to r2300_fpu.S").

I have no idea what exactly causes the problem. Paul, can you have a look?

       Arnd
