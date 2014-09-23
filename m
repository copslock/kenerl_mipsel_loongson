Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Sep 2014 18:12:42 +0200 (CEST)
Received: from mail-oi0-f45.google.com ([209.85.218.45]:53401 "EHLO
        mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009624AbaIWQMkBC601 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 23 Sep 2014 18:12:40 +0200
Received: by mail-oi0-f45.google.com with SMTP id g201so3654407oib.4
        for <linux-mips@linux-mips.org>; Tue, 23 Sep 2014 09:12:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=4UXwi/VyOuUWVAfrxdRdrLA6iXyWI92TsVc6EAyz+I0=;
        b=AWDYOIT3AvNQP+mEhc1W84ovIySrDu0uzBHFhaKpNFp7YsHeqE6Fvx7DpYf7cVqpIz
         uVyM6COvWTL1QIKGUcbURbaC9ylOH8eevprRHsMhyDUpKBJjs88mTr92pmZqTEmlyc1E
         jBkAgu297pxvtWNmr0MHsQE8ivTEq+W/sgDEyKD5x7DTLJT7HNCeMNiE3rjNjWkdq9Cv
         HXsPAR/zCV7w5usHuSzSebk4iqzMoWQD6Xgr7jw8pJ4BpwBn9et+jNqERvyyTqwL3A0l
         hjh8JYOVNoe/cRxcFdFQnq59PAcZpP2w57wDUBquxHlBd6hu+hJPuT+qLsAZ3f6qZHJ7
         c24g==
X-Gm-Message-State: ALoCoQmDGUEheCUxC1l4kUxJwxxFOV738/zZeytCPY5gB2+qa2AN8am8DHQBvmrQ+oLWdL/HpEEQ
X-Received: by 10.182.142.40 with SMTP id rt8mr774123obb.80.1411488753480;
        Tue, 23 Sep 2014 09:12:33 -0700 (PDT)
Received: from t430.minyard.home (pool-173-57-152-84.dllstx.fios.verizon.net. [173.57.152.84])
        by mx.google.com with ESMTPSA id bu7sm8000199oec.9.2014.09.23.09.12.32
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 23 Sep 2014 09:12:32 -0700 (PDT)
Message-ID: <54219BEE.7090309@mvista.com>
Date:   Tue, 23 Sep 2014 11:12:30 -0500
From:   Corey Minyard <cminyard@mvista.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.7.0
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>, minyard@acm.org
CC:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mips: Save all registers when saving the frame
References: <1410903925-10744-1-git-send-email-minyard@acm.org> <20140918095813.GA9804@linux-mips.org> <541AD6E9.2010609@mvista.com>
In-Reply-To: <541AD6E9.2010609@mvista.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <cminyard@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42748
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cminyard@mvista.com
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

Ping?  I haven't heard anything on this.

Thanks,

-corey

On 09/18/2014 07:58 AM, Corey Minyard wrote:
> On 09/18/2014 04:58 AM, Ralf Baechle wrote:
>> On Tue, Sep 16, 2014 at 04:45:25PM -0500, minyard@acm.org wrote:
>>
>>> From: Corey Minyard <cminyard@mvista.com>
>>>
>>> The MIPS frame save code was just saving a few registers, enough to
>>> do a backtrace if every function set up a frame.  However, this is
>>> not working if you are using DWARF unwinding, because most of the
>>> registers are wrong.  This was causing kdump backtraces to be short
>>> or bogus.
>>>
>>> So save all the registers.
>> The stratey of partial and full stack frames was developed in '97 to bring
>> down the syscall overhead.  It certaily was very effective - it brought
>> down the syscall latency to the level of Alphas running at much higher
>> clock.
>>
>> That certainly worked well back then for kernel 2.0 / 2.2.  But the syscall
>> code has become much more complex.  Since then support for 64 bit kernels,
>> two 32 bit ABIs running on a 64 bit kernels and numerous features that
>> changed the once simple syscall path have been implemented.  My gut feeling
>> is it might be worth to yank out the whole optimization to see how much
>> code complexity we get rid of in exchange for how much extra syscall
>> latency.
> I"m not sure I understand.  From what I can tell, this code is only
> called by
> things that print stack traces, kdb, and kexec/kdump.  So it shouldn't be in
> any normal syscall path.
>
> This patch will currently only help kdump, but it will be necessary if
> anyone
> adds MIPS support for DWARF unwinding for stack traces.  And you'd have
> to fix some things in context switching, too, I think.
>
> From what I can tell the partial save for syscalls is a good idea.  You
> don't have
> to save half the registers and it doesn't affect tracebacks, kdump, or
> anything else
> like that.
>
> -corey
