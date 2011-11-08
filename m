Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Nov 2011 20:40:22 +0100 (CET)
Received: from mail-qy0-f170.google.com ([209.85.216.170]:60561 "EHLO
        mail-qy0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903676Ab1KHTkS convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 8 Nov 2011 20:40:18 +0100
Received: by qyg14 with SMTP id 14so4162832qyg.15
        for <multiple recipients>; Tue, 08 Nov 2011 11:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=ltJ60YBw7pBFBctdO+QL7xweamZ1Tfvu8aAB85b7ttA=;
        b=fw6qOtZ2nVJtdgSP1QwjxKZOpjZvz2fgQCk0BTv29IwnE/6qrSL6sIekDJJ0dx1WUv
         p8AFPJVB6psu8F8Xzy9VBrkf+/1J5uj3mZ/XTb2CTqrRoNbjHG0C70TE4BHsFoPy04TB
         BjIa1BYpgwCq3HLLpxlGC+UfHs6hwVe/wo1A4=
MIME-Version: 1.0
Received: by 10.68.199.167 with SMTP id jl7mr3141307pbc.70.1320781212319; Tue,
 08 Nov 2011 11:40:12 -0800 (PST)
Received: by 10.68.62.169 with HTTP; Tue, 8 Nov 2011 11:40:11 -0800 (PST)
In-Reply-To: <20111108164711.GA13937@linux-mips.org>
References: <c2c8833593cb8eeef5c102468e105497@localhost>
        <20111108164711.GA13937@linux-mips.org>
Date:   Tue, 8 Nov 2011 11:40:11 -0800
Message-ID: <CAJiQ=7BpXhMKqQ9RDYHCzC2rpb9NdNGra7gQUqXko9eWnjhrAA@mail.gmail.com>
Subject: Re: [PATCH RESEND 1/9] MIPS: Add local_flush_tlb_all_mm to clear all
 mm contexts on calling cpu
From:   Kevin Cernekee <cernekee@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org,
        Maksim Rayskiy <maksim.rayskiy@gmail.com>,
        "Kevin D. Kissell" <kevink@paralogos.com>,
        Sergei Shtylyov <sshtylyov@mvista.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-archive-position: 31438
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 7119

On Tue, Nov 8, 2011 at 8:47 AM, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Sat, Nov 05, 2011 at 02:21:10PM -0700, Kevin Cernekee wrote:
>
>> +void local_flush_tlb_all_mm(void)
>> +{
>> +     struct task_struct *p;
>> +
>> +     for_each_process(p)
>> +             if (p->mm)
>> +                     local_flush_tlb_mm(p->mm);
>
> Aside of for_each_process being a potencially very heavy iterator - there
> can be thousands of threads on some systems, even embedded systems I'm

This is called from play_dead() on a CPU that has been hot-unplugged.

FWIW for_each_process() is also called from check_for_tasks() when
bringing down a CPU.  I wonder if that would be a better place to add
a hook to drop the MMU contexts, ala:

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 563f136..5854401 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -184,6 +184,7 @@ static inline void check_for_tasks(int cpu)
 				"(state = %ld, flags = %x)\n",
 				p->comm, task_pid_nr(p), cpu,
 				p->state, p->flags);
+		arch_drop_mmu_context(p, cpu);
 	}
 	write_unlock_irq(&tasklist_lock);
 }

But it does run on a "surviving" CPU, not the dying CPU, so I'm not
positive it would work the same way.

> missing the task_list lock being taken so bad things could happen.

Right, so without acquiring tasklist_lock, somebody else could
rearrange the list while I'm iterating through it.

Do I need to call task_lock(p) before touching p->mm, or would
acquiring a write lock on tasklist_lock be sufficient?
