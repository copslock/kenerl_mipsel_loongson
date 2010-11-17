Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Nov 2010 19:49:18 +0100 (CET)
Received: from mail-yx0-f177.google.com ([209.85.213.177]:37336 "EHLO
        mail-yx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491979Ab0KQStP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 17 Nov 2010 19:49:15 +0100
Received: by yxj4 with SMTP id 4so1011814yxj.36
        for <multiple recipients>; Wed, 17 Nov 2010 10:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=oVBZz93BdDpTlmmXtAJGUAXJaXcUcKVPmRlxN9Pp/f4=;
        b=GXRC522MHjKfwfR2TpDs8cx8o08flgx6saHvHYHhvg5sI6lT6+nJFO+QMsYE+mcsUr
         C28SLcIbw6xYvTOi0sPOjmuTrMrrcNteSdXa2iK4/soZcCjtYWoCQlbrMSbv/9g5OR44
         ph1Ovp8d8Gg+CgROsQtf+gQOIIaq2CaAVffok=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=YhQQMtJnhLhL7U3x1Afiiofb6kwmKts4ebMLhhTrXZcHekpOyGcVbneLFRIR+hZST+
         IMn6DYvnbMRsqDWHrwSiDYWAE6mXBlWWwgl35Yz2syilUo44mb552l5gefoSeFSJ6SPy
         hRx85xcGkVyQ3VxA45Q8N4LuLRTkSUfy4tPi8=
MIME-Version: 1.0
Received: by 10.100.17.4 with SMTP id 4mr6408000anq.119.1290019749723; Wed, 17
 Nov 2010 10:49:09 -0800 (PST)
Received: by 10.100.7.13 with HTTP; Wed, 17 Nov 2010 10:49:09 -0800 (PST)
Date:   Wed, 17 Nov 2010 10:49:09 -0800
Message-ID: <AANLkTi=yHm72=sM=QwLpm=aDRnxVf7ZM5=W6eNzgVoTN@mail.gmail.com>
Subject: [PATCH] MIPS: ASID conflict after CPU hotplug
From:   Maksim Rayskiy <maksim.rayskiy@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <maksim.rayskiy@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28406
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: maksim.rayskiy@gmail.com
Precedence: bulk
X-list: linux-mips

This is a repost of my original message which somehow did not reach
the mailing list (filtered out?).

Hello,

I am running SMP Linux 2.6.37-rc1 on BMIPS5000 (single core dual
thread) and observe some abnormalities when doing system
suspend/resume which I narrowed down to cpu hotplugging. The suspend
brings the second thread processor down and then restarts it, after
which I see memory corruption in userspace. I started digging and
found out that problem occurs because while doing execve() the child
process is getting the same ASID as the parent, which obviously
corrupts parent's address space.

Further digging showed that:
activate_mm() calls get_new_mmu_context() to get a new ASID, but at
this time ASID field in entryHi is 1, and asid_cache(cpu) is 0x100 (it
was just reset to ASID_FIRST_VERSION when the secondary TP was
booting).
So, get_new_mmu_context() increments the asid_cache(cpu) value to
0x101, and thus puts 0x01 into entryHi. The result - ASID field does
not get changed as it was supposed to.

My solution was very simple - do not reset asid_cache(cpu) on TP warm
restart. But I would welcome any comments because my understanding of
the code is somewhat fuzzy.

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index d83f325..ccf9272 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -1577,7 +1577,8 @@ void __cpuinit per_cpu_trap_init(void)
        }
 #endif /* CONFIG_MIPS_MT_SMTC */

-       cpu_data[cpu].asid_cache = ASID_FIRST_VERSION;
+       if (!cpu_data[cpu].asid_cache)
+               cpu_data[cpu].asid_cache = ASID_FIRST_VERSION;
        TLBMISS_HANDLER_SETUP();

        atomic_inc(&init_mm.mm_count);

Regards,
Max Rayskiy.
