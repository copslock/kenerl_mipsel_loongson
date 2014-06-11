Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Jun 2014 00:29:02 +0200 (CEST)
Received: from mail-ve0-f175.google.com ([209.85.128.175]:47027 "EHLO
        mail-ve0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6854785AbaFKW26YZqBr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 12 Jun 2014 00:28:58 +0200
Received: by mail-ve0-f175.google.com with SMTP id us18so902647veb.34
        for <linux-mips@linux-mips.org>; Wed, 11 Jun 2014 15:28:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=22JSQrNcCE8ejnkskJ7h3DP0xWCJqqSyD8Dry4Rf0fM=;
        b=O2/lcFJACTsIKc+Yquw/Q04/d3OaNoIUOFP4ezKgL6oJpUT5bBzQkUa70gNHdToWNp
         +HEUCLqMQGUS2JEkHVLKEik+4NQwfcRNm0SF3bR+6yNciz+5FJXUn8/3bsqcaCN7SkJW
         0dyrYqDOdqod46ptmup2Oz4UTUwAi6pIQT49dY02FbrSOiVeS9/DlIkOEt+UzwCApd3R
         F8DvUyg6W57Xj/y6l6cbXrJqdnCFlBjqmgEw9HIOZtRmFyQRstmBh++UHYNOfLpK5pNy
         ZgbJuPmZ/DpSd7y987Xrgc3CdUngSwLeGH7Ltoy0x4m/MSri3rAycqPHPOe4vLWaNFSI
         xTjg==
X-Gm-Message-State: ALoCoQnMmsST979xg80vQcSt6cAnK/QkKSr+HOZg1B840IbAkWm+2PvMD8+A+pf/fHZm/T/xfxw0
X-Received: by 10.52.138.232 with SMTP id qt8mr4278052vdb.44.1402525732521;
 Wed, 11 Jun 2014 15:28:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.58.91.40 with HTTP; Wed, 11 Jun 2014 15:28:32 -0700 (PDT)
In-Reply-To: <5398D7B4.5000303@zytor.com>
References: <cover.1402517933.git.luto@amacapital.net> <9e11cd988a0f120606e37b5e275019754e2774da.1402517933.git.luto@amacapital.net>
 <CAADnVQKt5FnShkZeQewbfnU1kHM-gLs3hCZMf5xcgFzyRDLX7A@mail.gmail.com>
 <CALCETrXoqqKC=T5Wvj+CDYQFte1s_=npDvQ2UYW0j=AanEgR1g@mail.gmail.com>
 <5398D59A.3030900@zytor.com> <CALCETrVMxkHcPXsEGtEc0Pr=Z80CzC0zWaQ9OdVdxi1CGuB4kQ@mail.gmail.com>
 <5398D7B4.5000303@zytor.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Wed, 11 Jun 2014 15:28:32 -0700
Message-ID: <CALCETrWaQZc124=6r4h+fTAY4H4LzWGFw=MB7KY5TBtB0jx9hA@mail.gmail.com>
Subject: Re: [RFC 5/5] x86,seccomp: Add a seccomp fastpath
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Will Drewry <wad@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>, X86 ML <x86@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, linux-mips@linux-mips.org,
        linux-arch <linux-arch@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <luto@amacapital.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40501
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

On Wed, Jun 11, 2014 at 3:27 PM, H. Peter Anvin <hpa@zytor.com> wrote:
> On 06/11/2014 03:22 PM, Andy Lutomirski wrote:
>> On Wed, Jun 11, 2014 at 3:18 PM, H. Peter Anvin <hpa@zytor.com> wrote:
>>> On 06/11/2014 02:56 PM, Andy Lutomirski wrote:
>>>>
>>>> 13ns is with the simplest nonempty filter.  I hope that empty filters
>>>> don't work.
>>>>
>>>
>>> Why wouldn't they?
>>
>> Is it permissible to fall off the end of a BPF program?  I'm getting
>> EINVAL trying to install an actual empty filter.  The filter I tested
>> with was:
>>
>
> What I meant was that there has to be a well-defined behavior for the
> program falling off the end anyway, and that that should be preserved.
>
> I guess it is possible to require that all code paths must provably
> reach a termination point.
>

Dunno.  I haven't ever touched any of the actual BPF code.  This whole
patchset only changes the code that invokes the BPF evaluator.

--Andy
