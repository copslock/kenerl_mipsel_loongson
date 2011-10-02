Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 02 Oct 2011 09:22:04 +0200 (CEST)
Received: from mail-ww0-f43.google.com ([74.125.82.43]:43352 "EHLO
        mail-ww0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490993Ab1JBHV7 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 2 Oct 2011 09:21:59 +0200
Received: by wwf27 with SMTP id 27so3529300wwf.24
        for <multiple recipients>; Sun, 02 Oct 2011 00:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=euy7Hl4NzFcXDUOHfEVex9cOLdl6lYeJ0kj/bD0cG1U=;
        b=OPycXfhDCN4bBLefH9LuptFq2MmFMy9BSGv/g0tVIZEAn4xebnn6RYnYp8oLMCZJk4
         d3KpfdjNuQ2L/GzZhCDpdoCokdpCQdvrErntjvO4sazw3njkfHgZOTCIneqcqWfjKcui
         976vpt2cpJxEgmP1OE4tlA04E0zzUuppWiqpQ=
MIME-Version: 1.0
Received: by 10.216.80.90 with SMTP id j68mr15681062wee.28.1317540113558; Sun,
 02 Oct 2011 00:21:53 -0700 (PDT)
Received: by 10.216.73.193 with HTTP; Sun, 2 Oct 2011 00:21:53 -0700 (PDT)
In-Reply-To: <20111001081801.GB15674@jayachandranc.netlogicmicro.com>
References: <CAJd=RBAkhesOGZiDEkQzzhGLmXVTV3=CrN9Bk9iwJULSnAT8sw@mail.gmail.com>
        <20111001081801.GB15674@jayachandranc.netlogicmicro.com>
Date:   Sun, 2 Oct 2011 15:21:53 +0800
Message-ID: <CAJd=RBBovhXw+r4HtAOWWPQk=3N4MybCFegYMkLnfkupY0qEKA@mail.gmail.com>
Subject: Re: [RFC] activate performance counter registers on Netlogic XLR chip
From:   Hillf Danton <dhillf@gmail.com>
To:     "Jayachandran C." <jayachandranc@netlogicmicro.com>
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-archive-position: 31197
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dhillf@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 432

On Sat, Oct 1, 2011 at 4:18 PM, Jayachandran C.
<jayachandranc@netlogicmicro.com> wrote:
> On Sat, Oct 01, 2011 at 02:18:49PM +0800, Hillf Danton wrote:
>> On Netlogic XLR chip two pairs of performance counter registers,
>>
>>    perf_ctrl0: c0 reg 25 sel 0, perf_cntr0: c0 reg 25 sel 1
>>    perf_ctrl1: c0 reg 25 sel 2, perf_cntr0: c0 reg 25 sel 3
>>
>> provide a means for software to count processor events.
>>
>> At most 64 events can be counted, such as,
>>    Instruction fetched and retired, branch instructions
>>    Instruction and Data Cache Unit statistics
>>    Instruction and Data TLB statistics
>>    Instruction Fetch Unit statistics
>>    Instruction Execution Unit statistics
>>    Load/store Unit statistics
>>    Cycle Count
>>
>> They are activated based on the model of mips/74k, and
>> any comment is appreciated.
>
> I have not looked at 74k, but on XLR there is only one set of perf counter
> registers in a core (or 4 hardware threads). These perf counters can count
> either the events on one thread or all of the threads put together.
>

It is encoded in the patch to count events on all threads.
Yeah it is better to count events according to user's favor.

Thanks
Hillf
