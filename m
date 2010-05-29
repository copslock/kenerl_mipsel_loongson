Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 29 May 2010 05:10:16 +0200 (CEST)
Received: from mail-gw0-f49.google.com ([74.125.83.49]:59452 "EHLO
        mail-gw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491031Ab0E2DKM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 29 May 2010 05:10:12 +0200
Received: by gwj18 with SMTP id 18so1613686gwj.36
        for <multiple recipients>; Fri, 28 May 2010 20:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=uWxniqffgpaL0nn5GnfInPGjxAmKZ9SDoQU5bi/WCAc=;
        b=H7fZOqr3kE84Now55LUT4uaDDWdpiF/D+XM5GqyFpbBHLvxoyWVHTNmJfJbDK7ehAH
         gxhSOH5Qbo/jSJbcQ7Y3/oTGcmdpsFfAiLMS+A2+yP560HdmvtrXIXQ8YeZ/ONij4VkU
         DoNBjX8/qvtFnrqOi8WMdfQrXhfGxFWx+EBy0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=KYy2nl9I7QuDrSSqE0IoqgUoJOJs53SjtY+/uWdq2skoegLezTXrVsuCc7dPDbplrv
         r0VXLRsH/RJELNMHoDCCGUTiFfESg+xwRY6a1QeDv6WCIcvIjYRiCNY4xEfzVXN/CE1c
         WiDNmO8BL5iKfd27q0rZq+WONdT1mrFzv6928=
MIME-Version: 1.0
Received: by 10.150.210.16 with SMTP id i16mr2787664ybg.70.1275102605915; Fri, 
        28 May 2010 20:10:05 -0700 (PDT)
Received: by 10.150.157.8 with HTTP; Fri, 28 May 2010 20:10:05 -0700 (PDT)
In-Reply-To: <4BFEF5D7.4050502@gmail.com>
References: <1274965420-5091-1-git-send-email-dengcheng.zhu@gmail.com>
        <1274965420-5091-7-git-send-email-dengcheng.zhu@gmail.com>
        <4BFEF5D7.4050502@gmail.com>
Date:   Sat, 29 May 2010 11:10:05 +0800
Message-ID: <AANLkTim22Di_l7pM_qGA79MA0xejpi0Lo1OTZqCvP7-L@mail.gmail.com>
Subject: Re: [PATCH v5 06/12] MIPS: add support for hardware performance 
        events (mipsxx)
From:   Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
To:     David Daney <david.s.daney@gmail.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        a.p.zijlstra@chello.nl, paulus@samba.org, mingo@elte.hu,
        acme@redhat.com, jamie.iles@picochip.com, will.deacon@arm.com
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <dengcheng.zhu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26906
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@gmail.com
Precedence: bulk
X-list: linux-mips

2010/5/28 David Daney <david.s.daney@gmail.com>:
> General comments:
>
> Can you separate the code that reads and writes the performance counter
> registers from the definitions of the various counters themselves?
[DC]:
1) Do you mean to move M_PERFCTL_* stuff out into pmu.h (or mipsregs.h)?
If yes, that's OK. Again (my reply for [1/12] mentions this for the 1st
time): After making Oprofile use Perf-events as backend (patches 8~12 do
this), register definitions and read/write functions will locate in pmu.h
(or mipsregs.h) and perf_event_$cpu.c, respectively.
2) According to your reply to [7/12], do you mean the perf counter
read/write functions (such as mipsxx_pmu_read_counter()) are generic
support functions? No, they are specific for mipsxx CPUs.


> Also take into account that the counter registers may be either 32 or 64
> bits wide.  The interfaces you are defining should take that into account
> even if the specific implementations only work with 32-bit registers.
[DC]: OK.


Deng-Cheng
