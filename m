Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Jun 2014 00:33:01 +0200 (CEST)
Received: from mail-ob0-f178.google.com ([209.85.214.178]:48654 "EHLO
        mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6859996AbaFKWc4sBV0y (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 12 Jun 2014 00:32:56 +0200
Received: by mail-ob0-f178.google.com with SMTP id wn1so466418obc.9
        for <linux-mips@linux-mips.org>; Wed, 11 Jun 2014 15:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=quwYIzjGKU2lNSsuxG/1WesY2jD5wQu5wzA5LSHV5rE=;
        b=csJ6xqQrOoXlfmeWpJFq8wSwHe1jFitwmP8Gaug60OAafT8GFjdS/hYiHXQ6ixPsa2
         SX9N5bo4J38AhPdAUo9Bb5kCGnEpCWTRMRg4KnxkzsAYydSuYkZ+TPiK408WSK1AE6iq
         HEwGUuSgetenIBZkiMChDjdWk13aOPhQGg71WPmP9zCvAj+Pt+odUiyBxrWot4bbQzQb
         Lzp3k26eBdGMqAvvDNr1bwBPm2So3iTpmNocLc5R8WQjB2Xfo1zTFW/ao0VmBEsIDxBh
         0jZmkLEQGCSMSydjwecLfpepcGUe4HBavW7JQfw1HDqcuzzQ84oult3dzjbAU76VKZqd
         6rFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=quwYIzjGKU2lNSsuxG/1WesY2jD5wQu5wzA5LSHV5rE=;
        b=M96L/mg6cKTw+Qki4YVdErScE834yu5OxKOxnTlzvVFjjKduXYFF5hp96tYsTFv7av
         JLd81dOH51GaOD5ug8iKGjRZ6kkvzeP1DEvnJ3g9PKkksURWCrAgWxEmXQ9LI8GHqeJh
         Cz5ay8OE04InuBbyFySn4O3cB5TsEIjZ40SVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=quwYIzjGKU2lNSsuxG/1WesY2jD5wQu5wzA5LSHV5rE=;
        b=T3f/O7di9kkx8jE1AxMYr6RQLpBLUGv+ZrYEDhD9kQclVl0dM1Wtxt6ieaJib0kEGu
         4QE2s1RemPzuXvhkd2e+2xf9LCMJIfTZHhxP/HW8HLOfxsNyXbbOQ0pJs1nXiyd+iTDb
         x7BZrAVRved/cE/fpyZRbb1jUrf4CXRPbR7WlNJ6eRGN1EHKGouZJ0dRIB5R3Bw8r0fm
         wqS+MVA9W3STGvIyv3BzpBoCF/TbXCkGmQo9nWaEcnDYAu5LMYla5SYwPuuQuRfLbrUl
         zpR4kCwYWYjZ8JCPFdFDz+W6qRbyWVMl0a5YZNc7jiF/Edxr4dQ4pAKiwUES1Kl23sSe
         JJ/w==
X-Gm-Message-State: ALoCoQnKo56/J68YXeBdHI3Xip4GRfFT1A3HuXd/dJvUFA77Iq5qIqPUM9wSywZf5xtuBUqBX+xN
MIME-Version: 1.0
X-Received: by 10.182.65.167 with SMTP id y7mr41462775obs.29.1402525970224;
 Wed, 11 Jun 2014 15:32:50 -0700 (PDT)
Received: by 10.182.63.80 with HTTP; Wed, 11 Jun 2014 15:32:49 -0700 (PDT)
In-Reply-To: <CALCETrWaQZc124=6r4h+fTAY4H4LzWGFw=MB7KY5TBtB0jx9hA@mail.gmail.com>
References: <cover.1402517933.git.luto@amacapital.net>
        <9e11cd988a0f120606e37b5e275019754e2774da.1402517933.git.luto@amacapital.net>
        <CAADnVQKt5FnShkZeQewbfnU1kHM-gLs3hCZMf5xcgFzyRDLX7A@mail.gmail.com>
        <CALCETrXoqqKC=T5Wvj+CDYQFte1s_=npDvQ2UYW0j=AanEgR1g@mail.gmail.com>
        <5398D59A.3030900@zytor.com>
        <CALCETrVMxkHcPXsEGtEc0Pr=Z80CzC0zWaQ9OdVdxi1CGuB4kQ@mail.gmail.com>
        <5398D7B4.5000303@zytor.com>
        <CALCETrWaQZc124=6r4h+fTAY4H4LzWGFw=MB7KY5TBtB0jx9hA@mail.gmail.com>
Date:   Wed, 11 Jun 2014 15:32:49 -0700
X-Google-Sender-Auth: IVpPnf4NeYmGACYKoUQRjO5i6qU
Message-ID: <CAGXu5jL86C1yvWynBrp20CxT9COorc5++nT6OhwYCwqc7UJyHg@mail.gmail.com>
Subject: Re: [RFC 5/5] x86,seccomp: Add a seccomp fastpath
From:   Kees Cook <keescook@chromium.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Will Drewry <wad@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>, X86 ML <x86@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, linux-mips@linux-mips.org,
        linux-arch <linux-arch@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <keescook@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40502
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: keescook@chromium.org
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

On Wed, Jun 11, 2014 at 3:28 PM, Andy Lutomirski <luto@amacapital.net> wrote:
> On Wed, Jun 11, 2014 at 3:27 PM, H. Peter Anvin <hpa@zytor.com> wrote:
>> On 06/11/2014 03:22 PM, Andy Lutomirski wrote:
>>> On Wed, Jun 11, 2014 at 3:18 PM, H. Peter Anvin <hpa@zytor.com> wrote:
>>>> On 06/11/2014 02:56 PM, Andy Lutomirski wrote:
>>>>>
>>>>> 13ns is with the simplest nonempty filter.  I hope that empty filters
>>>>> don't work.
>>>>>
>>>>
>>>> Why wouldn't they?
>>>
>>> Is it permissible to fall off the end of a BPF program?  I'm getting
>>> EINVAL trying to install an actual empty filter.  The filter I tested
>>> with was:
>>>
>>
>> What I meant was that there has to be a well-defined behavior for the
>> program falling off the end anyway, and that that should be preserved.
>>
>> I guess it is possible to require that all code paths must provably
>> reach a termination point.
>>
>
> Dunno.  I haven't ever touched any of the actual BPF code.  This whole
> patchset only changes the code that invokes the BPF evaluator.

Yes, this is how BPF works: runs to the end or exit early. With
seccomp BPF specifically, the return value defaults to kill the
process. If a filter was missing (NULL), or empty, or didn't
explicitly return with a new value, the default (kill) should be
taken.

-Kees

-- 
Kees Cook
Chrome OS Security
