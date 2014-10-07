Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Oct 2014 02:30:08 +0200 (CEST)
Received: from mail-lb0-f174.google.com ([209.85.217.174]:42264 "EHLO
        mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010553AbaJGAaHJudKf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Oct 2014 02:30:07 +0200
Received: by mail-lb0-f174.google.com with SMTP id p9so5223107lbv.19
        for <linux-mips@linux-mips.org>; Mon, 06 Oct 2014 17:30:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=eIX9ojz/21xtQSNYqt7IqIZEAaydxUf58gJqd7jruJQ=;
        b=N/5p5/6LBvqE/ljTyZB8nG/tGRevKfNPQW065AbB97vdLCKwQZUff6m84agia68xR0
         eNX7NYVCT1Vu1CAfez3iLcQFEweNo67G4zbgK32TNkO+SUN44HjwHX2QEK3PGpKrxgcT
         UiiBfvdgI1d9fkSFYZgWGmJZhSJ+Jkhn6mJp+Hj9rZH2GqVWMg+eUnyBy8G5Txie/iOf
         0UsTqT6qSQ1iJvAJuszeD1PdNgBWQ4K+P/kBXNx2BK3/mFi+pyLUout1eNvevE93Nj+m
         Af0t357yd1wzKt+RGDQe/w8V4g7D5b2Yfa29RG3uh9uQvHj/GPQVFa5kqFJC603KOvzZ
         WLlg==
X-Gm-Message-State: ALoCoQme5Lr9tQIjZw5YW7o5Nne4GLOrKjI/U44yX6bF/b0X/zZgR64xRXGYpoa8ibFB5+2EK6R7
X-Received: by 10.152.21.42 with SMTP id s10mr230271lae.61.1412641801647; Mon,
 06 Oct 2014 17:30:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.152.36.106 with HTTP; Mon, 6 Oct 2014 17:29:41 -0700 (PDT)
In-Reply-To: <CA+=Sn1n_S-JT1pZwMtDGM+Vkbp7rsg4bPAeESwJpSkbx8vqn5g@mail.gmail.com>
References: <1412627010-4311-1-git-send-email-ddaney.cavm@gmail.com>
 <20141006205459.GZ23797@brightrain.aerifal.cx> <5433071B.4050606@caviumnetworks.com>
 <20141006213101.GA23797@brightrain.aerifal.cx> <54330D79.80102@caviumnetworks.com>
 <20141006215813.GB23797@brightrain.aerifal.cx> <543327E7.4020608@amacapital.net>
 <54332A64.5020605@caviumnetworks.com> <20141007000514.GD23797@brightrain.aerifal.cx>
 <CA+=Sn1nR2ugXUf=V9F9O6VLAP1d6WhBDioZzu0G05-8z6KMMuA@mail.gmail.com>
 <20141007002147.GE23797@brightrain.aerifal.cx> <CA+=Sn1n_S-JT1pZwMtDGM+Vkbp7rsg4bPAeESwJpSkbx8vqn5g@mail.gmail.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Mon, 6 Oct 2014 17:29:41 -0700
Message-ID: <CALCETrXz+rYB0JxuXLPZroWCsqHqajfemiG1ohS7o33QebwQkA@mail.gmail.com>
Subject: Re: [PATCH resend] MIPS: Allow FPU emulator to use non-stack area.
To:     Andrew Pinski <pinskia@gmail.com>
Cc:     Rich Felker <dalias@libc.org>,
        David Daney <ddaney@caviumnetworks.com>,
        David Daney <ddaney.cavm@gmail.com>,
        GNU C Library <libc-alpha@sourceware.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        David Daney <david.daney@cavium.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <luto@amacapital.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42983
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: luto@amacapital.net
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

On Mon, Oct 6, 2014 at 5:28 PM, Andrew Pinski <pinskia@gmail.com> wrote:
> On Mon, Oct 6, 2014 at 5:21 PM, Rich Felker <dalias@libc.org> wrote:
>> On Mon, Oct 06, 2014 at 05:11:38PM -0700, Andrew Pinski wrote:
>>> On Mon, Oct 6, 2014 at 5:05 PM, Rich Felker <dalias@libc.org> wrote:
>>> > On Mon, Oct 06, 2014 at 04:48:52PM -0700, David Daney wrote:
>>> >> On 10/06/2014 04:38 PM, Andy Lutomirski wrote:
>>> >> >On 10/06/2014 02:58 PM, Rich Felker wrote:
>>> >> >>On Mon, Oct 06, 2014 at 02:45:29PM -0700, David Daney wrote:
>>> >> [...]
>>> >> >>This is a huge ill-designed mess.
>>> >> >
>>> >> >Amen.
>>> >> >
>>> >> >Can the kernel not just emulate the instructions directly?
>>> >>
>>> >> In theory it could, but since there can be implementation defined
>>> >> instructions, there is no way to achieve full instruction set
>>> >> coverage for all possible machines.
>>> >
>>> > Is the issue really implementation-defined instructions with delay
>>> > slots? If so it sounds like a made-up issue. They're not going to
>>> > occur in real binaries. Certainly a compiler is not going to generate
>>> > implementation-defined instructions, and if you're writing the asm by
>>> > hand, you just don't put floating point instructions in the delay
>>> > slot.
>>>
>>> It is not the instruction with delay slot but rather the instruction
>>> in the delay slot itself.
>>
>> An instruction in the delay slot for the instruction being emulated?
>> How would that arise? Are there floating point instructions with delay
>> slots?
>
> Yes branches.

I admit I have no idea what's going here, but I find it hard to
believe that having the kernel fix this up for new code is desirable.
Unless MIPS can round-trip a trap *very* quickly, performance will be
awful for any code that has this problem.

--Andy
