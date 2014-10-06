Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Oct 2014 01:54:33 +0200 (CEST)
Received: from mail-lb0-f182.google.com ([209.85.217.182]:36871 "EHLO
        mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010553AbaJFXycNHr8R (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Oct 2014 01:54:32 +0200
Received: by mail-lb0-f182.google.com with SMTP id z11so5044818lbi.41
        for <linux-mips@linux-mips.org>; Mon, 06 Oct 2014 16:54:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=okE0E3YccKTe2KcBbl4o1pv9dI/dQesIciyYv0CtjCg=;
        b=bXs42Ln7eLyhLR/IhwMgBQZi5QFAj/fg8bj+9C18DEZThV15let/L5bZGQaZJQ1NE5
         NS70UP8QF5K9y/rzdRuxcyI5TG3X1Ovw2GeruJ7elwrtAGTwFArcQCv9WoubTVxNbRtQ
         2xuDUerS0jhBuibEd8pSVopf/S5h+0+dSwx7n1PUDe+JD+zvSw5gsT8jmSRQoy8YSPEM
         hSK3JiGyfxNxqX1PTv8yHayHN4NhXOvieG0l1mRExv5k3rNppMXkKRKQMfhIvDo5ACAE
         p/KZVvN3lm4mkG0/vnfqAZAG7CGtiA93IIEZFiLZfC9nCx53rvr4cb9/B7QX6c4D7bFp
         W6pg==
X-Gm-Message-State: ALoCoQk5VW1cKlYHWJhntyYgbyAMdFaDey+vxqiVp8Vxs3gFU4NM0Omp1zSSBPE6NPvU19t4SRBP
X-Received: by 10.152.205.9 with SMTP id lc9mr100577lac.37.1412639666719; Mon,
 06 Oct 2014 16:54:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.152.36.106 with HTTP; Mon, 6 Oct 2014 16:54:06 -0700 (PDT)
In-Reply-To: <54332A64.5020605@caviumnetworks.com>
References: <1412627010-4311-1-git-send-email-ddaney.cavm@gmail.com>
 <20141006205459.GZ23797@brightrain.aerifal.cx> <5433071B.4050606@caviumnetworks.com>
 <20141006213101.GA23797@brightrain.aerifal.cx> <54330D79.80102@caviumnetworks.com>
 <20141006215813.GB23797@brightrain.aerifal.cx> <543327E7.4020608@amacapital.net>
 <54332A64.5020605@caviumnetworks.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Mon, 6 Oct 2014 16:54:06 -0700
Message-ID: <CALCETrXt4xNCW9+UbEzhST5Eo6s9ymNOc16C+EGi2Pr=GrEZuA@mail.gmail.com>
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
X-archive-position: 42978
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

On Mon, Oct 6, 2014 at 4:48 PM, David Daney <ddaney@caviumnetworks.com> wrote:
> On 10/06/2014 04:38 PM, Andy Lutomirski wrote:
>>
>> On 10/06/2014 02:58 PM, Rich Felker wrote:
>>>
>>> On Mon, Oct 06, 2014 at 02:45:29PM -0700, David Daney wrote:
>
> [...]
>>>
>>> This is a huge ill-designed mess.
>>
>>
>> Amen.
>>
>> Can the kernel not just emulate the instructions directly?
>
>
> In theory it could, but since there can be implementation defined
> instructions, there is no way to achieve full instruction set coverage for
> all possible machines.

Can modern user code just avoid constructs that require this kind of
trampoline hack?  If so, can this be solved the same way that x86
added no-exec stacks?  (I.e. mark all the binaries as supporting
non-executable stacks and letting them crash if they screw it up.)

Knowing very little about MIPS, it sounds like this is the kernel
compensating for a dumb assembler.

--Andy
