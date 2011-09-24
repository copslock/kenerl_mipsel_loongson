Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Sep 2011 04:54:53 +0200 (CEST)
Received: from mail-gw0-f49.google.com ([74.125.83.49]:43565 "EHLO
        mail-gw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490970Ab1IXCyr convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 24 Sep 2011 04:54:47 +0200
Received: by gwa2 with SMTP id 2so2847052gwa.36
        for <multiple recipients>; Fri, 23 Sep 2011 19:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=fey+TXDz5cFMaowLJfIVBegfWp70uNKx74DBolJ+wn8=;
        b=vl6JKTBcex/nm1wYyhb3bJCgNeeAMvcLFAlT9uP2KM9oiJ+gaj43i8jpflSpiemj8M
         Pm/jXqA+gtgKOQQvVAGecG76vN1KyxQvHJ0GT7oRULFLASIngN9SerhtlZkhDrdX1dzC
         na7YoNC6Q1z/DHiYSwElpVn2R/LG4N/zLJREc=
MIME-Version: 1.0
Received: by 10.236.129.242 with SMTP id h78mr25757994yhi.89.1316832881217;
 Fri, 23 Sep 2011 19:54:41 -0700 (PDT)
Received: by 10.236.69.232 with HTTP; Fri, 23 Sep 2011 19:54:41 -0700 (PDT)
In-Reply-To: <1316712378-7282-5-git-send-email-david.daney@cavium.com>
References: <1316712378-7282-1-git-send-email-david.daney@cavium.com>
        <1316712378-7282-5-git-send-email-david.daney@cavium.com>
Date:   Sat, 24 Sep 2011 10:54:41 +0800
Message-ID: <CAOfQC98YwVoFWz+ZYv5JYCPG=NhzoeMKy70oE7aJbwAB+yZ6gA@mail.gmail.com>
Subject: Re: [PATCH v5 4/5] MIPS: perf: Add support for 64-bit perf counters.
From:   Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
To:     David Daney <david.daney@cavium.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@elte.hu>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-archive-position: 31146
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 13762

2011/9/23 David Daney <david.daney@cavium.com>:
> The hard coded constants are moved to struct mips_pmu.  All counter
> register access move to the read_counter and write_counter function
> pointers, which are set to either 32-bit or 64-bit access methods at
> initialization time.
>
> Many of the function pointers in struct mips_pmu were not needed as
> there was only a single implementation, these were removed.
>
> I couldn't figure out what made struct cpu_hw_events.msbs[] at all
> useful, so I removed it too.

The idea behind msbs is to simulate 32-bit counters based on the fact
of MIPS using the MSB to trigger the overflow interrupt. By doing this, the
average length of the overflow ISR can be shorter in the case of event
period is bigger than 0x80000000. Also, it simplifies counter value related
algorithms in the code - most of other architectures have 32-bit counters
instead of 31-bit. In addition, taking over those bugfixes can be easier as
a concequence.


Deng-Cheng
