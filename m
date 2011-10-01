Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 01 Oct 2011 10:18:25 +0200 (CEST)
Received: from mx1.netlogicmicro.com ([12.203.210.36]:3169 "EHLO
        orion5.netlogicmicro.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491157Ab1JAISS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 1 Oct 2011 10:18:18 +0200
X-TM-IMSS-Message-ID: <46f28190000102de@netlogicmicro.com>
Received: from hqcas01.netlogicmicro.com ([10.10.50.14]) by netlogicmicro.com ([10.10.16.19]) with ESMTP (TREND IMSS SMTP Service 7.0; TLS: TLSv1/SSLv3,128bits,AES128-SHA) id 46f28190000102de ; Sat, 1 Oct 2011 01:18:09 -0700
Date:   Sat, 1 Oct 2011 13:48:02 +0530
From:   Jayachandran C. <jayachandranc@netlogicmicro.com>
To:     Hillf Danton <dhillf@gmail.com>
CC:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [RFC] activate performance counter registers on Netlogic XLR chip
Message-ID: <20111001081801.GB15674@jayachandranc.netlogicmicro.com>
References: <CAJd=RBAkhesOGZiDEkQzzhGLmXVTV3=CrN9Bk9iwJULSnAT8sw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAJd=RBAkhesOGZiDEkQzzhGLmXVTV3=CrN9Bk9iwJULSnAT8sw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-OriginalArrivalTime: 01 Oct 2011 08:17:58.0397 (UTC) FILETIME=[A0E412D0:01CC8012]
X-archive-position: 31195
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jayachandranc@netlogicmicro.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 134

On Sat, Oct 01, 2011 at 02:18:49PM +0800, Hillf Danton wrote:
> On Netlogic XLR chip two pairs of performance counter registers,
> 
>    perf_ctrl0: c0 reg 25 sel 0, perf_cntr0: c0 reg 25 sel 1
>    perf_ctrl1: c0 reg 25 sel 2, perf_cntr0: c0 reg 25 sel 3
> 
> provide a means for software to count processor events.
> 
> At most 64 events can be counted, such as,
>    Instruction fetched and retired, branch instructions
>    Instruction and Data Cache Unit statistics
>    Instruction and Data TLB statistics
>    Instruction Fetch Unit statistics
>    Instruction Execution Unit statistics
>    Load/store Unit statistics
>    Cycle Count
> 
> They are activated based on the model of mips/74k, and
> any comment is appreciated.

I have not looked at 74k, but on XLR there is only one set of perf counter
registers in a core (or 4 hardware threads). These perf counters can count 
either the events on one thread or all of the threads put together.

JC.
