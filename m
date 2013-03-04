Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Mar 2013 04:05:53 +0100 (CET)
Received: from mail-bk0-f52.google.com ([209.85.214.52]:53645 "EHLO
        mail-bk0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816847Ab3CDDFs0uuBY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 4 Mar 2013 04:05:48 +0100
Received: by mail-bk0-f52.google.com with SMTP id jk13so2150003bkc.39
        for <multiple recipients>; Sun, 03 Mar 2013 19:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:date:message-id:subject:from:to:cc
         :content-type;
        bh=7M98KR4Ty3FhCgO2a6VXuMM/HsEAHpWFXACSI4wsBm4=;
        b=Aq2RNrP4hXb/X3Q5veHKfPLj7yb27FyaBPfWt3KM50nff3SN3geFsxIAVuEro41R2j
         LK3zcEV57IX1TkJL3w6AChTb5Mh3THGEOBPCrNtjnIl1SdKMLiSoWCHMCs2rRVEp+1bP
         I6MUBazmg1WneSOWJmAkxLU/7kFlt98GG7agMmUaePaGr+4wUoSCfLS8rAA+cS18FLx4
         CvakDPptdo56zdPP2kd5sZC0alt9ScsUoR+07DDNVnQ0ueAzn4S0/StAWGGzvnUJJCaP
         kf3NtGKF+UyOZs8mMjk58iPwl4Ef6Vwfh7PEJeUV+r0waaaaQ6ekbNjSEJLoq5LcNVIn
         MIFQ==
MIME-Version: 1.0
X-Received: by 10.204.156.140 with SMTP id x12mr6573047bkw.91.1362366342348;
 Sun, 03 Mar 2013 19:05:42 -0800 (PST)
Received: by 10.204.24.207 with HTTP; Sun, 3 Mar 2013 19:05:42 -0800 (PST)
Date:   Mon, 4 Mar 2013 11:05:42 +0800
Message-ID: <CAAhV-H637V17CO6o5W=xy7B6cD9O6kbia0iAixwnZfV+j6xwJg@mail.gmail.com>
Subject: [RFD] Memory Corruption of CPU Hotplug on MIPS (Loongson-3)
From:   Huacai Chen <chenhuacai@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Zhangjin Wu <wuzhangjin@gmail.com>, yong.zhang0@gmail.com
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 35839
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhuacai@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Hi, all,

I found that the "spawn" program of UnixBench may get segfault/bus
error or other memory corruptions when we do CPU hotplug on quad-core
Loongson-3. We have debug this for a long time but have no solution,
so I want to know whether this is not a Loongson-specific but a
MIPS-specific problem.

Testbed configuration:
Linux kernel-3.6.11 with Loongson-3 patches (the linux-3.6 branch of
http://dev.lemote.com/cgit/linux-official.git)
UnixBench-5.1.3 (http://code.google.com/p/byte-unixbench/)
CPU hotplug script like this (hotplug.sh):
--
while true; do
echo 0 >/sys/devices/system/cpu/cpu1/online
echo 0 >/sys/devices/system/cpu/cpu2/online
echo 0 >/sys/devices/system/cpu/cpu3/online
sleep 1
echo 1 >/sys/devices/system/cpu/cpu1/online
echo 1 >/sys/devices/system/cpu/cpu2/online
echo 1 >/sys/devices/system/cpu/cpu3/online
done
--

Test method:
1, run "hotplug.sh" and then run "spawn 10000", spawn will get
segfault after a few minutes.
2, run "hotplug.sh" and then run "taskset -c 0 spawn 10000" (spawn
runs only on core-0), spawn will get segfault in half an hour.
3, run "taskset -c 0 hotplug.sh" and then run "spawn 10000"
(hotplug.sh runs only on core-0), spawn will get segfault in half an
hour.
4, run "taskset -c 0 hotplug.sh" and then run "taskset -c 0 spawn
10000" (both spawn and hotplug.sh run only on core-0), spawn will
finish successfully after about 3 hours.

This looks like the bug fixed in the below commit, but Linux-3.6
already have merged this patch:
--
commit 5c200197130e307de6eba72fc335c83c9dd6a5bc
Author: Maksim Rayskiy <maksim.rayskiy@gmail.com>
Date:   Thu Nov 10 17:59:45 2011 +0000

    MIPS: ASID conflict after CPU hotplug
--

BTW, we found that if we do build_clear_page()/build_copy_page() in
cpu_cache_init() only on Core-0 at the first boot time (Don't do it
while CPU Hotplug, and don't do it on Core-1,2,3), the possibility of
segfault decreases.

Any ideas?

Best wishes,
Huacai Chen
