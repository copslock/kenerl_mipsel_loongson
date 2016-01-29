Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Jan 2016 22:32:39 +0100 (CET)
Received: from hauke-m.de ([5.39.93.123]:55243 "EHLO hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011109AbcA2VchuBM3c (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 29 Jan 2016 22:32:37 +0100
Received: from [192.168.178.24] (p508B66DC.dip0.t-ipconnect.de [80.139.102.220])
        by hauke-m.de (Postfix) with ESMTPSA id 3ABB610043C;
        Fri, 29 Jan 2016 22:32:37 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
Subject: vdso clock_gettime() sometimes broken after sleep
X-Enigmail-Draft-Status: N1110
To:     markos.chandras@imgtec.com, Alex Smith <alex.smith@imgtec.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Message-ID: <56ABDA74.9010203@hauke-m.de>
Date:   Fri, 29 Jan 2016 22:32:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51531
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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

When using the vdso clock_gettime() it looks like that the clock is
sometimes not going forward when the process sleeps and the clock also
sleeps. This problem only happens with the vdso clock and not with the
normal syscall clock.

I wrote a small test program which calls the syscall and the vdso
version. In the first call they are showing the same time, but after I
sleeped for 1 second, they are off by one second. This problem occurs
not 100% reliable but I see it pretty often. Only the CLOCK_REALTIME and
CLOCK_MONOTONIC seam to be affected CLOCK_REALTIME_COARSE is not affected.

I am using an MIPS BE 34Kc V5.6 CPU with two VPEs, but only one is used.
This is a Lantiq VRX200 SoC with OpenWrt Linux kernel 4.4 and musl libc.

Hauke


Here are my measurements:

start test
syscall: CLOCK_REALTIME: tv_sec: 1454098944, tv_nsec: 463189916
vdso:    CLOCK_REALTIME: tv_sec: 1454098944, tv_nsec: 463242196
syscall: CLOCK_REALTIME_COARSE: tv_sec: 1454098944, tv_nsec: 456000000
vdso:    CLOCK_REALTIME_COARSE: tv_sec: 1454098944, tv_nsec: 456000000
syscall: CLOCK_MONOTONIC: tv_sec: 107, tv_nsec: 28113172
vdso:    CLOCK_MONOTONIC: tv_sec: 107, tv_nsec: 32150208
syscall: CLOCK_MONOTONIC_COARSE: tv_sec: 107, tv_nsec: 24678324
vdso:    CLOCK_MONOTONIC_COARSE: tv_sec: 107, tv_nsec: 24678324
syscall: CLOCK_MONOTONIC_RAW: tv_sec: 107, tv_nsec: 28263008
vdso:    CLOCK_MONOTONIC_RAW: tv_sec: 107, tv_nsec: 28300760
syscall: CLOCK_BOOTTIME: tv_sec: 107, tv_nsec: 28337540
vdso:    CLOCK_BOOTTIME: tv_sec: 107, tv_nsec: 28379100
syscall: CLOCK_PROCESS_CPUTIME_ID: tv_sec: 0, tv_nsec: 3111128
vdso:    CLOCK_PROCESS_CPUTIME_ID: tv_sec: 0, tv_nsec: 3153120
syscall: CLOCK_THREAD_CPUTIME_ID: tv_sec: 0, tv_nsec: 3192208
vdso:    CLOCK_THREAD_CPUTIME_ID: tv_sec: 0, tv_nsec: 3231696
sleep(1)
syscall: CLOCK_REALTIME: tv_sec: 1454098945, tv_nsec: 464023036
vdso:    CLOCK_REALTIME: tv_sec: 1454098946, tv_nsec: 468077456
syscall: CLOCK_REALTIME_COARSE: tv_sec: 1454098945, tv_nsec: 460000000
vdso:    CLOCK_REALTIME_COARSE: tv_sec: 1454098945, tv_nsec: 460000000
syscall: CLOCK_MONOTONIC: tv_sec: 108, tv_nsec: 28874940
vdso:    CLOCK_MONOTONIC: tv_sec: 109, tv_nsec: 32911852
syscall: CLOCK_MONOTONIC_COARSE: tv_sec: 108, tv_nsec: 24678324
vdso:    CLOCK_MONOTONIC_COARSE: tv_sec: 108, tv_nsec: 24678324
syscall: CLOCK_MONOTONIC_RAW: tv_sec: 108, tv_nsec: 29023384
vdso:    CLOCK_MONOTONIC_RAW: tv_sec: 108, tv_nsec: 29061372
syscall: CLOCK_BOOTTIME: tv_sec: 108, tv_nsec: 29097912
vdso:    CLOCK_BOOTTIME: tv_sec: 108, tv_nsec: 29139864
syscall: CLOCK_PROCESS_CPUTIME_ID: tv_sec: 0, tv_nsec: 3824540
vdso:    CLOCK_PROCESS_CPUTIME_ID: tv_sec: 0, tv_nsec: 3865708
syscall: CLOCK_THREAD_CPUTIME_ID: tv_sec: 0, tv_nsec: 3904680
vdso:    CLOCK_THREAD_CPUTIME_ID: tv_sec: 0, tv_nsec: 3943892
sleep(2)
syscall: CLOCK_REALTIME: tv_sec: 1454098947, tv_nsec: 464791376
vdso:    CLOCK_REALTIME: tv_sec: 1454098950, tv_nsec: 468847600
syscall: CLOCK_REALTIME_COARSE: tv_sec: 1454098947, tv_nsec: 460000000
vdso:    CLOCK_REALTIME_COARSE: tv_sec: 1454098947, tv_nsec: 460000000
syscall: CLOCK_MONOTONIC: tv_sec: 110, tv_nsec: 29644468
vdso:    CLOCK_MONOTONIC: tv_sec: 113, tv_nsec: 33682152
syscall: CLOCK_MONOTONIC_COARSE: tv_sec: 110, tv_nsec: 24678324
vdso:    CLOCK_MONOTONIC_COARSE: tv_sec: 110, tv_nsec: 24678324
syscall: CLOCK_MONOTONIC_RAW: tv_sec: 110, tv_nsec: 29794136
vdso:    CLOCK_MONOTONIC_RAW: tv_sec: 110, tv_nsec: 29831728
syscall: CLOCK_BOOTTIME: tv_sec: 110, tv_nsec: 29868576
vdso:    CLOCK_BOOTTIME: tv_sec: 110, tv_nsec: 29909920
syscall: CLOCK_PROCESS_CPUTIME_ID: tv_sec: 0, tv_nsec: 4547416
vdso:    CLOCK_PROCESS_CPUTIME_ID: tv_sec: 0, tv_nsec: 4589684
syscall: CLOCK_THREAD_CPUTIME_ID: tv_sec: 0, tv_nsec: 4628872
vdso:    CLOCK_THREAD_CPUTIME_ID: tv_sec: 0, tv_nsec: 4668808
sleep(3)
syscall: CLOCK_REALTIME: tv_sec: 1454098950, tv_nsec: 465558716
vdso:    CLOCK_REALTIME: tv_sec: 1454098956, tv_nsec: 469613960
syscall: CLOCK_REALTIME_COARSE: tv_sec: 1454098950, tv_nsec: 460000000
vdso:    CLOCK_REALTIME_COARSE: tv_sec: 1454098950, tv_nsec: 460000000
syscall: CLOCK_MONOTONIC: tv_sec: 113, tv_nsec: 30411308
vdso:    CLOCK_MONOTONIC: tv_sec: 119, tv_nsec: 34448236
syscall: CLOCK_MONOTONIC_COARSE: tv_sec: 113, tv_nsec: 24678324
vdso:    CLOCK_MONOTONIC_COARSE: tv_sec: 113, tv_nsec: 24678324
syscall: CLOCK_MONOTONIC_RAW: tv_sec: 113, tv_nsec: 30559184
vdso:    CLOCK_MONOTONIC_RAW: tv_sec: 113, tv_nsec: 30596676
syscall: CLOCK_BOOTTIME: tv_sec: 113, tv_nsec: 30632568
vdso:    CLOCK_BOOTTIME: tv_sec: 113, tv_nsec: 30673204
syscall: CLOCK_PROCESS_CPUTIME_ID: tv_sec: 0, tv_nsec: 5262328
vdso:    CLOCK_PROCESS_CPUTIME_ID: tv_sec: 0, tv_nsec: 5304576
syscall: CLOCK_THREAD_CPUTIME_ID: tv_sec: 0, tv_nsec: 5343136
vdso:    CLOCK_THREAD_CPUTIME_ID: tv_sec: 0, tv_nsec: 5382616
