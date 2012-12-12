Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Dec 2012 20:15:40 +0100 (CET)
Received: from mail-oa0-f49.google.com ([209.85.219.49]:40766 "EHLO
        mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6817207Ab2LLTPjSsjll (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 Dec 2012 20:15:39 +0100
Received: by mail-oa0-f49.google.com with SMTP id l10so1167000oag.36
        for <multiple recipients>; Wed, 12 Dec 2012 11:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=TnqBGculqCCGGk4KBeU39Ppu/SnnRf1SLescYWAOj7I=;
        b=Uqrci1kOkTaBApSil5vdx8+689N4pA2b5s/F5bl652E/2X7s1i5Dna879HrsqU9QWo
         RCiZhpcZnytdZHstutfgS4k+a5QX3ZmcG9JbspzlnZg73Tq+BLb4H8exBqr+lvWEtr08
         x55NjXvmyyapcpZeQnEnW2lz5C+SYkDAT3tYFdSgoCScPVjeW1YmIIKjrQU0jMAdTLKQ
         U6qc48aLabwYMmIbL2utEsLT4IC608sWieHQcmsUAxwv/7AIzpQtDpwOJ0uHH/KzC3mB
         WCr41bQD+k8Pjbc8dGyW8q1H4w35inDJE+xdHsxOyYB2nYQVpGuXnjykqxmYOuS7iwnR
         JWdg==
Received: by 10.182.141.70 with SMTP id rm6mr1022915obb.59.1355339732755; Wed,
 12 Dec 2012 11:15:32 -0800 (PST)
MIME-Version: 1.0
Received: by 10.60.95.129 with HTTP; Wed, 12 Dec 2012 11:14:52 -0800 (PST)
In-Reply-To: <50C8D644.9060103@gmail.com>
References: <1354858280-29576-1-git-send-email-sjhill@mips.com>
 <50C89870.5000704@metafoo.de> <31E06A9FC96CEC488B43B19E2957C1B801146AA779@exchdb03.mips.com>
 <50C8D1D4.5050200@metafoo.de> <50C8D644.9060103@gmail.com>
From:   Manuel Lauss <manuel.lauss@gmail.com>
Date:   Wed, 12 Dec 2012 20:14:52 +0100
Message-ID: <CAOLZvyF9L2D4UBcGmAYQOiMnoMT6s3ehTW6k4eA6HRjg8dh18A@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Make CP0 config registers readable via sysfs.
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        "Hill, Steven" <sjhill@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 35274
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Wed, Dec 12, 2012 at 8:08 PM, David Daney <ddaney.cavm@gmail.com> wrote:
> On 12/12/2012 10:49 AM, Lars-Peter Clausen wrote:
>>
>> On 12/12/2012 05:44 PM, Hill, Steven wrote:
>>>
>>> Lars,
>>>
>>> This patch was requested by our DSP/Codec group to help with selecting
>>> the best user-space codecs at runtime. Simply reading /proc/cpuinfo was
>>> insufficient. I posted this patch more for feedback and interest with
>>> minimal expectations that it would make it upstream. This patch will always
>>> be in our supported branches, but I will defer to everyone else on its worth
>>> for upstream.
>>>
>>> -Steve
>>
>>
>> Well if it is something that is useful it makes sense to upstream it,
>> especially if you are developing applications. Many people before you have
>> learned the hard way that stashing stuff away in their private branches
>> was not
>> the best idea. If you are smart you are going to avoid that.
>>
>> It may not be the best solution though to just dump all the cp register to
>> userspace. As Florian suggested there might be a smarter way to solve
>> this.
>
>
>
> If you want to have glibc's ld.so automatically select optimal libraries for
> a given platform, then the elf_platform is the way to do it.
>
> However I don't think this is necessarily the case here.  elf_platform
> cannot easily handle a bunch of orthogonal capabilities.  So I am in favor
> of the principle of this patch.
>
> There should be a per CPU file (probably in /sys/devices/system/cpu/cpuXX)
> with the CP0_Config values.
>
> One question I have is:  Should it be a single file with one row for each
> implemented Config register, or one file per register?


I'm all for the one-file-per-register approach.  I find it easier to
just read the
right register instead of having to find out how many rows to read to get
the value I'm looking for.

Thanks!
        Manuel
