Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Mar 2015 21:03:51 +0100 (CET)
Received: from mail-wg0-f51.google.com ([74.125.82.51]:39406 "EHLO
        mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008038AbbCCUDt1lANh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 3 Mar 2015 21:03:49 +0100
Received: by wggx12 with SMTP id x12so42317352wgg.6
        for <linux-mips@linux-mips.org>; Tue, 03 Mar 2015 12:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        bh=FRDXt6v+WN/vMBIsp4rTCee6U0QA1M4XmjRJxr9+sYw=;
        b=RRuQsDBn8kCa97l3UUILZgOSOCDxW5dXy+XGsWQk/7QA4Pdq1Bue0qoblNJgjP9LMc
         6pJiIMKtFChslESy9zgojccmYbRcVBoF4oDNkKbLA6g4I+yybsnVNyhBCdMehGcgBDPr
         I7fKtLuBdZd+HbsoGPW1nKh7XfhbiKPWLrBAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-type;
        bh=FRDXt6v+WN/vMBIsp4rTCee6U0QA1M4XmjRJxr9+sYw=;
        b=Q3f0NUFWtN9nEjkgSYjzPUKmWAwEsNa1sf2C3aNKQLarFh2ptLlnr2pWNLjPg0/Zqw
         iabjJMcbcarFnzcXKrPyD3fSHTwWS40FOwxRaLNzcCtsGJZZrGxrfAODbnrVKIIPYozn
         NSP5B8G4muwXbdQ0H41vgLytdSBKaWsIwxaNARvi9ig3BZZUgvjfD5GaHL8CIVznnkL/
         an6rKKygi9vOGxfEQ/2UlRE7yTqin5kJ85nqB+mX5+8thglvF0Lj9UkC/vaNsWlFeqkm
         NhOUY8L0ldfEe2XigSrhsbBJzYtTI9rRgeeq3axg9djU9m9PA7GblcqLwcLA1DOg/z6j
         d/8Q==
X-Gm-Message-State: ALoCoQl4LDINevm1Hi3fqQdI9NTfvnQNnroa0YLb3tEeKL3bCdwticffLLBZtU0P9xu+P/NnRGPw
X-Received: by 10.194.200.196 with SMTP id ju4mr885169wjc.47.1425413024731;
        Tue, 03 Mar 2015 12:03:44 -0800 (PST)
Received: from mail-we0-f169.google.com (mail-we0-f169.google.com. [74.125.82.169])
        by mx.google.com with ESMTPSA id b4sm22015138wic.2.2015.03.03.12.03.42
        for <linux-mips@linux-mips.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Mar 2015 12:03:43 -0800 (PST)
Received: by wesq59 with SMTP id q59so5167328wes.3
        for <linux-mips@linux-mips.org>; Tue, 03 Mar 2015 12:03:42 -0800 (PST)
X-Received: by 10.180.84.9 with SMTP id u9mr5837645wiy.91.1425413022082; Tue,
 03 Mar 2015 12:03:42 -0800 (PST)
MIME-Version: 1.0
Received: by 10.194.175.138 with HTTP; Tue, 3 Mar 2015 12:03:21 -0800 (PST)
From:   Kevin Cernekee <cernekee@chromium.org>
Date:   Tue, 3 Mar 2015 12:03:21 -0800
Message-ID: <CAJzqFtao8YuoJbqv8PbSkXHT0Trhy087h-rZFHY0BUiGtjXZJQ@mail.gmail.com>
Subject: pm-cps code uses uninitialized cpu_data fields
To:     paul.burton@imgtec.com
Cc:     Andrew Bresticker <abrestic@chromium.org>,
        linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <cernekee@chromium.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46107
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@chromium.org
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

Hi Paul,

On a multicore interAptiv system, I noticed that booting with "nosmp"
generated a warning:

[    0.116000] ------------[ cut here ]------------
[    0.116000] WARNING: CPU: 0 PID: 1 at
/mnt/host/source/src/third_party/kernel/v3.14/arch/mips/kernel/pm-cps.c:270
cps_pm_init+0x798/0xd68()
[    0.116000] pm-cps: FSB flush unsupported for this CPU
[    0.116000] Modules linked in:
[    0.116000] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 3.14.0 #23
[    0.116000] Stack : 00000000 00000034 00000006 8048afdc 00000000
00000005 00000006 00000000
[    0.116000]  00000000 00000000 00000000 00000000 80c3054a 00000034
00000000 80ba0000
[    0.116000]  80b00000 8f8683c8 80a5ec48 00000001 00000000 80ba3604
80afea00 80b9b980
[    0.116000]  00000001 809b4c30 80ba3604 80432538 00000000 80b00000
80a64efc 8f863d0c
[    0.116000]  8f863d0c 0085b507 00000000 00000000 00000000 00000000
00000000 00000000
[    0.116000]  ...
[    0.116000] Call Trace:
[    0.116000] [<80409e44>] show_stack+0x6c/0xac
[    0.120000] [<809b54c4>] dump_stack+0xb0/0xd4
[    0.120000] [<804326c8>] warn_slowpath_common+0x98/0xc8
[    0.120000] [<80432744>] warn_slowpath_fmt+0x4c/0x70
[    0.120000] [<80b4193c>] cps_pm_init+0x798/0xd68
[    0.120000] [<80400540>] do_one_initcall+0x7c/0x1cc
[    0.120000] [<80b3bbcc>] kernel_init_freeable+0x168/0x220
[    0.120000] [<809b3a04>] kernel_init+0x24/0x114
[    0.120000] [<804034f8>] ret_from_kernel_thread+0x14/0x1c
[    0.120000]
[    0.120000] ---[ end trace 69ce861cf7aa6d6e ]---
[    0.120000] Failed to generate core 1 state 1 entry

This happened because cps_gen_core_entries() was being called for CPUs
that have not been booted:

for_each_present_cpu(cpu) {
    err = cps_gen_core_entries(cpu);
    if (err)
        return err;
}

and so fields like cpu_info->cputype and cpu_info->dcache.linesz were still 0.

I worked around it temporarily by using for_each_online_cpu instead,
but I'm not sure this will do the right thing if the CPUs are brought
up later.

Another possibility is to copy over the CPU type / cache info from
CPU0 if the secondary CPUs are not up yet.

Your thoughts?
