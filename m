Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Apr 2010 12:36:13 +0200 (CEST)
Received: from mail-pv0-f177.google.com ([74.125.83.177]:60581 "EHLO
        mail-pv0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492343Ab0DWKgJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Apr 2010 12:36:09 +0200
Received: by pvc30 with SMTP id 30so250363pvc.36
        for <multiple recipients>; Fri, 23 Apr 2010 03:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=7rbd21VQnY9ohB/NLMCUdjEUa+W5GgndX/99m4WB6dQ=;
        b=MilS0Vr32rU4p0/Fl9kAJcQ3bWsS3H3TS/NW0m/QLjrnInInNwR4sPLe2bVEXzUtp5
         AElW9hoSN5VEU1ewSzyf1y1AvsOppT83HrnQ/Ci2j4Zyw4Lx/Sqd/SUODo419wFoK44k
         8Z9EIeAW2sP09rj0D7h2CJsMo0/o0HM1i9U+Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        b=deQSzKvskW0Pk3jgRpzvokcnQmt0JrpfMJf5pdztJ4qYfuVuDv8iwhRAYxdNBiAN24
         Dk3etXNc9rnZgXqBXXh5ebvUAeqxEDxHz5WTu5En1FziFyCrz2rVMMrBDcf+cn5Etpj/
         ofLMe3422DyRq33UoVjuDoaJvESzV5iXHeBAE=
Received: by 10.115.148.18 with SMTP id a18mr1877431wao.229.1272018961327;
        Fri, 23 Apr 2010 03:36:01 -0700 (PDT)
Received: from [192.168.1.100] ([114.84.71.49])
        by mx.google.com with ESMTPS id v13sm4146088wav.2.2010.04.23.03.35.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 23 Apr 2010 03:36:00 -0700 (PDT)
Subject: [PATCH v2 0/4] MIPS performance event support v2
From:   Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     a.p.zijlstra@chello.nl, paulus@samba.org, mingo@elte.hu,
        acme@redhat.com, jamie.iles@picochip.com
Content-Type: text/plain; charset="UTF-8"
Date:   Fri, 23 Apr 2010 18:35:52 +0800
Message-ID: <1272018952.4662.88.camel@fun-lab>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
Return-Path: <dengcheng.zhu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26463
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@gmail.com
Precedence: bulk
X-list: linux-mips

v2 - v1:
- Adjusting code structure as suggested by Wu Zhangjin. With this change,
hardware performance event support for loongson2 and rm9000 can be
conveniently implemented by adding and including new files like
perf_event_loongson2.c; Oprofile and Perf for MIPS are now sharing pmu.h;
Naming changes were made to some functions.
- Fixing the generic atomic64 issue reported by David Daney. Currently,
32bit kernel is using the generic version from lib. When Ralf Baechle's
common atomic64 version is ready, this may change.
- Adding raw event support. For more details, please refer to the code
comments for mipsxx_pmu_map_raw_event().
- Adding new software events - PERF_COUNT_SW_ALIGNMENT_FAULTS and
PERF_COUNT_SW_EMULATION_FAULTS.
- Fixing some small bugs.
- Adding new comments for the code.
- Making some code style changes.

Deng-Cheng Zhu (4):
- MIPS/Oprofile: extracting PMU defines/helper functions for sharing
- MIPS: in non-64bit kernel, using the generic atomic64 operations for
perf counter support
- MIPS: adding support for software performance events
- MIPS: implementing hardware performance event support


v1:
This patch series implemented the low-level logic for the Linux
performance counter subsystem on MIPS, which enables the collection of
all sorts of HW/SW performance events based on per-CPU or per-task.

An overview of this implementation is as follows:

- Using generic atomic64 operations from lib.
- SMVP/UP kernels are supported (not for SMTC).
- 24K/34K/74K cores are implemented.
- Currently working when Oprofile is _not_ available.
- Minimal software perf events are supported.

Tests were carried on the Malta-R board. The mentioned cores and kernel
flavors were tested. For more information, please refer to the particular
patches.

Deng-Cheng Zhu (3):
- MIPS: use the generic atomic64 operations for perf counter support
- MIPS: adding support for software perf events
- MIPS: implement hardware perf event support
