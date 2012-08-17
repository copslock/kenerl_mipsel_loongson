Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Aug 2012 23:04:39 +0200 (CEST)
Received: from mail-yw0-f49.google.com ([209.85.213.49]:35406 "EHLO
        mail-yw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903438Ab2HQVEf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 17 Aug 2012 23:04:35 +0200
Received: by yhjj52 with SMTP id j52so4704508yhj.36
        for <linux-mips@linux-mips.org>; Fri, 17 Aug 2012 14:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=F29++MBiu3TohPMTwiBlVViinVGWRvMiXk1EZtTU0lU=;
        b=HRNnFC1kmxYXp3rHfvkfBqXau1aJDS4DC8LPNaXuXFeypUspV/ZE2qOHG5XxnupISD
         qbIQGrJEvDUQDs79VziH37ddYj08BeuJgREigpeZufFkeBvhJdV/3m55QI+LIDIcnXEv
         +H9jvCqWL1qakPlzmQyoBwRvyiU2OAonZ5r6jTt94Oqhdjvd/GzMihBaLbjr650HpMT1
         HVJ/VmG++FV/ewv9QJNYuI6/AyrvhsqjUZJjZ/d88566T/vApHpr/VBcTQ+Qui1U/juQ
         7LP8LXzU3Z4fkAUSxU0D6p6NNbPRzmHurfm/aEmfvorg4Z+YoHF1XLCmVuuGVDvTPfyv
         +tSw==
MIME-Version: 1.0
Received: by 10.100.230.16 with SMTP id c16mr3184459anh.22.1345237469266; Fri,
 17 Aug 2012 14:04:29 -0700 (PDT)
Received: by 10.236.103.163 with HTTP; Fri, 17 Aug 2012 14:04:29 -0700 (PDT)
Date:   Fri, 17 Aug 2012 17:04:29 -0400
Message-ID: <CANCKTBvNar5sbb=vMhaUU5QKV5mPMca6f43sMNg0jQ6448QWig@mail.gmail.com>
Subject: A question on preemption during local_irq_disable() in non-mipsr2 multiprocessor
From:   Jim Quinlan <jim2101024@gmail.com>
To:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 34262
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jim2101024@gmail.com
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

A while ago, this question was posted

    http://old.nabble.com/Is-local_irq_disable%28%29-preemption-safe---td16599731.html

which basically asked, 'what happens if preemption occurs between the
"mfc0" and the "mtc0" in the non-mipsr2 code of
arch_local_irq_disable() in irqflags.h':

    mfc0    $1,c0_status
    ori    $1,0x1f
    xori    $1,0x1f
    mtc0    $1,c0_status

If preemption occurs, it appears that a possibly stale value of the
status register will be stored.  I am seeing this exact situation with
a BMIPS 5000 multiprocessor --  one processor has different
c0_status.IM settings than the other processor, and when this
situation occurs, the processor that is expecting certain interrupts
no longer gets them because its status.IM field is hosed.  The exact
location of this issue is occurring in the write_lock_irq() invocation
in the function release_task() in the file exit.c.  However,
arch_local_irq_disable() is not the only function like this; others
exist in irqflags.h and asmmacro.h.

Can someone confirm that this is indeed an issue?  I would post a
patch I am using but (1) I would like to hear feedback first and (2)
the patch has its own issues as it involves using preemption macros in
irqflags.h.

Thanks,
Jim Quinlan
