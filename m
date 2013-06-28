Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 29 Jun 2013 00:03:42 +0200 (CEST)
Received: from mail-bk0-f54.google.com ([209.85.214.54]:63925 "EHLO
        mail-bk0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6827443Ab3F1WDjRSXdP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 29 Jun 2013 00:03:39 +0200
Received: by mail-bk0-f54.google.com with SMTP id it16so953477bkc.41
        for <linux-mips@linux-mips.org>; Fri, 28 Jun 2013 15:03:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:x-originating-ip:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :x-gm-message-state;
        bh=cC0yu7l8wNjHG8bl2DL8rUDu3nsqkf4/jt5nprk4S54=;
        b=DbCfcqWd5DML/9zM8tYIPLZbCVyFIKS4MaNhDcIGqjXwE491EIQ5sWXbLydEvFwM9g
         dl2KiiX3/10mKaROW4CtdCGQRVFxlocLlvH5u78Uq/SgZzA8h+Zs/jNjmZ/jdWspyh/k
         zrLtQGisOSv9hk8qrm4ODRPKlhCN5kozrM0AfAY/h0nCWEzSpy2EpSCw3OL1O+xuw4rM
         t5cewy6Da3/Nt2PYlcdFlP1DgjjF3BJ7r9mGI/T0SDi4JBs1HphXW2hukLSy7Y7vRC5P
         bXrf6GRkgWFXixF3X00u0kfsAt1VzwP4jniPa9S9nHfA8BMURqykaWjHI7AVeQWZEJld
         ZznA==
MIME-Version: 1.0
X-Received: by 10.204.184.199 with SMTP id cl7mr2103265bkb.77.1372457013605;
 Fri, 28 Jun 2013 15:03:33 -0700 (PDT)
Received: by 10.204.188.143 with HTTP; Fri, 28 Jun 2013 15:03:33 -0700 (PDT)
X-Originating-IP: [212.159.75.221]
In-Reply-To: <201306282128.27266.vda.linux@googlemail.com>
References: <1371225825-8225-1-git-send-email-james.hogan@imgtec.com>
        <51BEE6A8.2050307@imgtec.com>
        <201306282128.27266.vda.linux@googlemail.com>
Date:   Fri, 28 Jun 2013 23:03:33 +0100
X-Google-Sender-Auth: 432fhgjfPDgoOQujuUFua-CRkvs
Message-ID: <CAAG0J9-d4BfEhbQovFqUAJ3QoOuXScrpsY1y95PrEPxA5DWedQ@mail.gmail.com>
Subject: Re: [PATCH v2] MIPS: Reduce _NSIG from 128 to 127 to avoid BUG_ON
From:   James Hogan <james.hogan@imgtec.com>
To:     Denys Vlasenko <vda.linux@googlemail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        Oleg Nesterov <oleg@redhat.com>, linux-mips@linux-mips.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Dave Jones <davej@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
X-Gm-Message-State: ALoCoQlRVGTHER+zVzeLokBLsD7bHWofVgSqou6orV+XedUFrPP4X15z4zGE1WyeocXpuN1fAlN2
Return-Path: <james@albanarts.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37215
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

On 28 June 2013 20:28, Denys Vlasenko <vda.linux@googlemail.com> wrote:
> On Monday 17 June 2013 12:36, James Hogan wrote:
>> On 14/06/13 17:03, James Hogan wrote:
>> > MIPS has 128 signals, the highest of which has the number 128 (they
>> > start from 1). The following command causes get_signal_to_deliver() to
>> > pass this signal number straight through to do_group_exit() as the exit
>> > code:
>> >
>> >   strace sleep 10 & sleep 1 && kill -128 `pidof sleep`
>> >
>> > However do_group_exit() checks for the core dump bit (0x80) in the exit
>> > code which matches in this particular case and the kernel panics:
>> >
>> >   BUG_ON(exit_code & 0x80); /* core dumps don't get here */
>> >
>> > Lets avoid this by changing the ABI by reducing the number of signals to
>> > 127 (so that the maximum signal number is 127). Glibc incorrectly sets
>> > [__]SIGRTMAX to 127 already. uClibc sets it to 128 so it's conceivable
>> > that programs built against uClibc which intentionally uses RT signals
>> > from the top (SIGRTMAX-n, n>=0) would need an updated uClibc (and a
>> > rebuild if it's crazy enough to use __SIGRTMAX).
>>
>> Hmm, although this works around the BUG_ON, this doesn't actually seem
>> to be sufficient to behave correctly.
>>
>> So it appears the exit status is constructed like this:
>> bits  purpose
>> 0x007f        signal number (0-127)
>> 0x0080        core dump
>> 0xff00        exit status
>>
>> but the macros in waitstatus.h and wait.h in libc
>> (see also "man 2 wait"):
>> WIFEXITED:   status & 0x7f == 0
>> WIFSIGNALED: status & 0x7f in [1..126] (i.e. not 0 or 127)
>> WIFSTOPPED:  status & 0xff == 127
>>
>> So termination due to SIG127 looks like it's been stopped instead of
>> terminated via a signal, unless a core dump occurs in which case none of
>> the above match.
>>
>> (And termination due to SIG128 hits BUG_ON, otherwise would appear to
>> have exited normally with core dump).
>>
>>
>> Reducing number of signals to 126 to avoid this will change the glibc
>> ABI too, in which case we may as well reduce to 64 to match other
>> arches, which is more likely to break something (I'm not really
>> comfortable making that change).
>>
>> Reducing to 127 (this patch) still leaves incorrect exit status codes
>> for SIG127 ...
>>
>> Any further thoughts/opinions?
>
> Strictly speaking, exit status of 0x007f isn't ambiguous.
>
> Currently userspace uses the following rules
> (assuming that status is 16-bit (IOW, dropping PTRACE_EVENT bits)):
>
> WIFEXITED(status)    = (status & 0x7f) == 0
> WIFSIGNALED(status)  = (status & 0x7f) != 0 && (status & 0x7f) < 0x7f
> WIFSTOPPED(status)   = (status & 0xff) == 0x7f
> WIFCONTINUED(status) = (status == 0xffff)
>
> WEXITSTATUS(status)  = status >> 8
> WSTOPSIG(status)     = status >> 8
> WCOREDUMP(status)    = status & 0x80
> WTERMSIG(status)     = status & 0x7f
>
> When process dies from signal 127, status is 0x007f and it is not a valid
> "stopped by signal" indicator, since WSTOPSIG == 0 is an impossibility.
>
> Status 0x007f get misinterpreted by the rules above, namely,
> WIFSTOPPED is true, WIFSIGNALED is false.
>
> But an alternative definition exists which works correctly with
> all previous status codes, treats 0x007f as "killed by signal 127"
> and isn't more convoluted.
> In fact, while WIFSTOPPED needs one additional check,
> WIFSIGNALED gets simpler (loses one AND'ing operation):
>
> WIFSTOPPED(status)   = (status & 0xff) == 0x7f && (status >> 8) != 0
> WIFSIGNALED(status)  = status != 0 && status <= 0xff
>
> All other rules need no change.
>
> I think it's feasible to ask {g,uc}libc to change their defines
> (on MIPS as a minimum), and live with 127 signals.

Thanks for the explanation. This makes a lot of sense and if I
understand correctly it already describes the current behaviour of the
kernel up to SIG127 (I hadn't twigged WIFSTOPPED should imply
WSTOPSIG!=0 for some reason). I like it.

Cheers
James
