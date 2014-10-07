Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Oct 2014 02:49:22 +0200 (CEST)
Received: from mail-lb0-f178.google.com ([209.85.217.178]:36262 "EHLO
        mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010656AbaJGAtVNJeOS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Oct 2014 02:49:21 +0200
Received: by mail-lb0-f178.google.com with SMTP id w7so5313869lbi.9
        for <linux-mips@linux-mips.org>; Mon, 06 Oct 2014 17:49:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=sr7btjtXMAdSHMWGMxIRpaPk/LnPJ63rHvAj4KSGw4c=;
        b=ewWx7jwjub5Yjcc7s9EYAkGFKaB2gEkK8voVy+lCPe2T7a38kPnndWWcdmFnUK7NZD
         5KZ+gYp6QOl490DPr3j717oI1k9Iu59XvWI/QZs/n2t0ISOCGBT8r4ncR8aqgiLaiRI3
         tzXWTJO+5S7xqTGOxA4AG94S6DLIePvHz2tlK//6dm3jrAT9YcqyzHsEC5aogrmCEW0n
         dkroMP9Fi8FWSqpQaZiv3yj58HP7x5/maPDlNhk72TQyrTVzmNB81/KUIsmyXSv10zQ9
         EAdL+2Lh10GrkYoM7LEeF8xkTYHssftsr6HDUzvOLg08wYkDVv+iF7bphro91n65Zx+g
         xmUA==
X-Gm-Message-State: ALoCoQmTGd5GCqiTWgE3isonIye0MfmzpUXHQy05KTTTNnnucYt5hD11rTY8VeU36nbfUJm5iMRJ
X-Received: by 10.112.4.33 with SMTP id h1mr275508lbh.67.1412642955473; Mon,
 06 Oct 2014 17:49:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.152.36.106 with HTTP; Mon, 6 Oct 2014 17:48:55 -0700 (PDT)
In-Reply-To: <543334CE.8060305@caviumnetworks.com>
References: <1412627010-4311-1-git-send-email-ddaney.cavm@gmail.com>
 <20141006205459.GZ23797@brightrain.aerifal.cx> <5433071B.4050606@caviumnetworks.com>
 <20141006213101.GA23797@brightrain.aerifal.cx> <54330D79.80102@caviumnetworks.com>
 <20141006215813.GB23797@brightrain.aerifal.cx> <543327E7.4020608@amacapital.net>
 <54332A64.5020605@caviumnetworks.com> <20141007000514.GD23797@brightrain.aerifal.cx>
 <543334CE.8060305@caviumnetworks.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Mon, 6 Oct 2014 17:48:55 -0700
Message-ID: <CALCETrWHYaZSVC_V2h4fSxSpHh5D6RPHG8VupKUjCJGiwpwmyg@mail.gmail.com>
Subject: Re: [PATCH resend] MIPS: Allow FPU emulator to use non-stack area.
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     Rich Felker <dalias@libc.org>, David Daney <ddaney.cavm@gmail.com>,
        libc-alpha <libc-alpha@sourceware.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        David Daney <david.daney@cavium.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <luto@amacapital.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42986
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

On Mon, Oct 6, 2014 at 5:33 PM, David Daney <ddaney@caviumnetworks.com> wrote:
> On 10/06/2014 05:05 PM, Rich Felker wrote:
>>
>> On Mon, Oct 06, 2014 at 04:48:52PM -0700, David Daney wrote:
>>>
>>> On 10/06/2014 04:38 PM, Andy Lutomirski wrote:
>>>>
>>>> On 10/06/2014 02:58 PM, Rich Felker wrote:
>>>>>
>>>>> On Mon, Oct 06, 2014 at 02:45:29PM -0700, David Daney wrote:
>>>
>>> [...]
>>>>>
>>>>> This is a huge ill-designed mess.
>>>>
>>>>
>>>> Amen.
>>>>
>>>> Can the kernel not just emulate the instructions directly?
>>>
>>>
>>> In theory it could, but since there can be implementation defined
>>> instructions, there is no way to achieve full instruction set
>>> coverage for all possible machines.
>>
>>
>> Is the issue really implementation-defined instructions with delay
>> slots?
>
>
> It is the instructions in the delay slots, not the branch instructions
> themselves that are of interest.  But, for the sake of the arguments, this
> is not a critical point.
>
>> If so it sounds like a made-up issue.
>
>
> It is not a made up issue.
>
> If you want an architecture that has a well defined instruction set, stick
> with x86, Intel will tell you what is good for you and you will take
> whatever they give you.
>
> If you want an architecture where you can add implementation defined
> instructions to do whatever you want, then you use an architecture like
> MIPS.
>
>> They're not going to
>> occur in real binaries. Certainly a compiler is not going to generate
>> implementation-defined instructions,
>
>
> Why not?  It will emit any instructions we care to make it emit.  If we want
> it to emit crypto instructions with patented algorithms, then it will do
> that.  But we would still like to use a generic kernel with generic FPU
> support.
>
> The most straight forward way (and the currently implemented way) of doing
> this is to execute the instructions in question out-of-line (on the
> userspace stack).
>
> The question here is:  What is the best way to get to a non-executable
> stack.
>
> The consensus among MIPS developers is that we should continue using the
> out-of-line execution trick, but do it somewhere other than in stack memory.
>
> One way of doing this is to have the kernel magically generate thread local
> memory regions.
>
> Another option is to have userspace manage the out-of-line execution areas.
>
> As is often the case, each approach has different pluses and minuses.

Your patch is still buggy.  Imagine this sequence:

Daft userspace code does:

emulated fp branch to elsewhere (not taken)
insn 1
insn 2

The kernel shoves insn1 and insn2 in this magic trampoline and
re-enters user code there.

An asynchronous signal happens before insn1 executes.

The signal hander runs similar daft code, gets fixed up and returns
*to the now-overwritten trampoline*.  Boom.  This kind of failure mode
is why using any kind of magic trampoline sucks on all architectures.

Even the current code might have the same bug for all I know -- are
really updating the stack pointer when you emulate these instructions?
 Do you have a redzone for exactly this purpose?  Does the MIPS signal
delivery code check to see whether you're executing off the stack
outside of the ABI-protected region?


Given that this is documented as an ABI change, I'll ask again: can
you demand that user code that wants the ABI-breaking non-executable
stack must not do this?  IOW, binaries that claim to work with
non-executable stacks must not have fp branches (or alternatively must
not have anything other than nops in the delay slots of possibly
emulated FP branches)?  Or you could be polite and explicitly define
the set of instructions that are safe in fp branch delay slots.

(Also, seriously, fp branches have usable delay slots?  Wow!)

--Andy
