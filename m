Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Nov 2011 06:34:07 +0100 (CET)
Received: from mail-yw0-f49.google.com ([209.85.213.49]:32949 "EHLO
        mail-yw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903542Ab1KIFd7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 Nov 2011 06:33:59 +0100
Received: by ywn1 with SMTP id 1so1629675ywn.36
        for <multiple recipients>; Tue, 08 Nov 2011 21:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Mq3e9ZoZVSSvinYgYPKAPBj7nYZPg+InLl0gPij+1fo=;
        b=yFqrETnUpP/++Znwf1Tr1euJoEEJ0Ytw2TrhV7rXuTNyy34i0HsM8cP8ukyQTu2xyq
         gwLMdUShWe1d3g2AcHR2ttCQpXQdyH0Q2bfRq9TD9R3y9ZgT5+SGXVGX7Q0EUe3cvPaP
         HCA3CvE4sCex2nwMEkxm3BEZPC16cXSgpvYtI=
MIME-Version: 1.0
Received: by 10.68.11.233 with SMTP id t9mr2311140pbb.121.1320816832696; Tue,
 08 Nov 2011 21:33:52 -0800 (PST)
Received: by 10.68.62.169 with HTTP; Tue, 8 Nov 2011 21:33:52 -0800 (PST)
In-Reply-To: <20111108164711.GA13937@linux-mips.org>
References: <c2c8833593cb8eeef5c102468e105497@localhost>
        <20111108164711.GA13937@linux-mips.org>
Date:   Tue, 8 Nov 2011 21:33:52 -0800
Message-ID: <CAJiQ=7B0Kcd4FnCtFedHqj_69U7Rt2fw4hwmx5WCh5sZZBXSow@mail.gmail.com>
Subject: Re: [PATCH RESEND 1/9] MIPS: Add local_flush_tlb_all_mm to clear all
 mm contexts on calling cpu
From:   Kevin Cernekee <cernekee@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        "Kevin D. Kissell" <kevink@paralogos.com>
Cc:     linux-mips@linux-mips.org,
        Maksim Rayskiy <maksim.rayskiy@gmail.com>,
        Sergey Shtylyov <sshtylyov@mvista.com>
Content-Type: text/plain; charset=UTF-8
X-archive-position: 31446
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 7465

I read through mmu_context.h and the threads from November/December
2010 a couple of times, and I'm starting to think Maksim's original
approach (don't reset asid_cache(cpu) when warm-restarting a CPU)
makes the most sense.

The basic issue is that we want to assign unique, strictly increasing
values to each mm's cpu_context(cpu, mm).  The per-cpu counter starts
at ASID_FIRST_VERSION (0x100 on R4K), and counts up.  Assigning a new
mm the same ASID value as an existing mm on the same CPU is illegal.
Two obvious ways to meet this requirement when hotplugging CPUs are:

Option #1: Retain the asid_cache(cpu) value across warm restarts.
This is simple and inexpensive.  We pick up where we left off, and
whatever existing cpu_context(cpu, mm) values are out there do not
cause any trouble.

I believe Maksim's original logic (assign ASID_FIRST_VERSION, a
nonzero number, if asid_cache(cpu) == 0) would work correctly as
written, because cpu_data is an array in .bss .  It will be 0 until
the CPU is booted, and get_new_mmu_context() ensures that it will
never be 0 again after that.

Kevin K brought up the idea of a warm restart bitmask so the code
could tell whether asid_cache(cpu) was valid.  I'm not sure that this
would be required.

I think we can also get away with not explicitly preserving EntryHi,
since switch_mm() and activate_mm() will set it anyway.

Option #2: When warm restarting a CPU, set asid_cache(cpu) to
ASID_FIRST_VERSION again.  And at some point (cpu_up or cpu_down),
iterate through all processes to set cpu_context(cpu, mm) to something
that will not conflict with a newly assigned ASID.  This is what the
most recent patch did.  It gets the job done, but it's more work than
what is really needed.

Please let me know your thoughts...
