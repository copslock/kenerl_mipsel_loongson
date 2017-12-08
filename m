Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Dec 2017 08:54:38 +0100 (CET)
Received: from mail-it0-x244.google.com ([IPv6:2607:f8b0:4001:c0b::244]:40133
        "EHLO mail-it0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990436AbdLHHycEiC0p (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 Dec 2017 08:54:32 +0100
Received: by mail-it0-x244.google.com with SMTP id f190so3010708ita.5
        for <linux-mips@linux-mips.org>; Thu, 07 Dec 2017 23:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=s/m059sReSBytf4LefzkXDNi+XZeSgeSkUatUhw7j7Y=;
        b=bGwfxul2F6PUSj1TBO6Ec9UiyIL1vPFoIAwml2iTuHl4y2ribVZjLLdjRMotsvmrqL
         oJ1zDgSs6+EV/EWYQf2tRib9DQx9znQPsu0EuMw0nS08d7QcW2Vi/aaG8hH5gW5AlQRr
         f9Ad7MeEcnd4JxZVf/j7HrbIzGf4q5Gnziib/mXIl0scKp0aD/RKsSdGS4DE2RVFjHQX
         V1/5rXtNbE8TiPtaGZfL1k3NoBECouki4zhTQLOlF0JB9J+iTnjKTS5H2wH9Ugc3/Bdu
         6CcGZux4m11cf+UZSR1xSFREansLjBdOdANv6di9LZxLRgMAKY921VL2jTmAx1Lnm/y9
         5JPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=s/m059sReSBytf4LefzkXDNi+XZeSgeSkUatUhw7j7Y=;
        b=KcEdL+JInE36larXv9ZwIzSOHooBBKbbdLLNA1Zoflr3DsGBtOXTXUJwyzyO/0MeNR
         sqZvIgkF8aYHQS6a8iqmcp2tV71teGGKTyQykhutKPQ76Z5e1e9Q0MHsDo5oORy1h/ao
         cex3ptGP+ZLBOiZ9PtDKivU/oceONn0uoph34bCcSST9GKwZujE8PXOBem6j8rHvqh/o
         gAIZ7dqWmj6ktALopoOSv1+guS5BCJLi5avkg/iNvQUKCY8gEl+tUucUNETx/fc4g5wY
         fwqRpVeIdG5hOaQ8HYXvR0OtmdxSkd2Agr6GubgFuK35rYnkpgsnBKOW9JRjTtHP6H/9
         vLgg==
X-Gm-Message-State: AKGB3mIIdwLGPKe6SZt57IAGt+fKqQ4EN+Kei7YARZlTuMlRuxvbVk+h
        Ydll83vcqo1U7+ZOk5hmycATUm6FSFVOanGTx2563g==
X-Google-Smtp-Source: AGs4zMYJM46X/rnoPtx8lhExQMC/M88OsZ37mcKXL12cLQEfhZxgjj1QfjEYDAgJugLTan7hxZqAM5Ilzc4gOBfHgRc=
X-Received: by 10.36.189.140 with SMTP id x134mr5166672ite.26.1512719665556;
 Thu, 07 Dec 2017 23:54:25 -0800 (PST)
MIME-Version: 1.0
Received: by 10.2.152.46 with HTTP; Thu, 7 Dec 2017 23:54:05 -0800 (PST)
In-Reply-To: <CAEdQ38G4VTXDGOarmmTac=hP92VJbQHRFxQTaSWQ3j4d63pogg@mail.gmail.com>
References: <CAEdQ38HcOgAT6wJWWKY3P0hzYwkBGSQkRSQ2a=eaGmD6c6rwXA@mail.gmail.com>
 <CAEdQ38G4VTXDGOarmmTac=hP92VJbQHRFxQTaSWQ3j4d63pogg@mail.gmail.com>
From:   Matt Turner <mattst88@gmail.com>
Date:   Thu, 7 Dec 2017 23:54:05 -0800
Message-ID: <CAEdQ38HcPswBk3pUHzQerFZ=4KjPc5nVYTqNnGQNMk7QbPXuOQ@mail.gmail.com>
Subject: Re: NFS corruption, fixed by echo 1 > /proc/sys/vm/drop_caches --
 next debugging steps?
To:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        linux-nfs@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Hannes Frederic Sowa <hannes@stressinduktion.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Manuel Lauss <manuel.lauss@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <mattst88@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61353
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mattst88@gmail.com
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

On Thu, Dec 7, 2017 at 11:00 PM, Matt Turner <mattst88@gmail.com> wrote:
> On Sun, Mar 12, 2017 at 6:43 PM, Matt Turner <mattst88@gmail.com> wrote:
>> On a Broadcom BCM91250a MIPS system I can reliably trigger NFS
>> corruption on the first file read.
>>
>> To demonstrate, I downloaded five identical copies of the gcc-5.4.0
>> source tarball. On the NFS server, they hash to the same value:
>>
>> server distfiles # md5sum gcc-5.4.0.tar.bz2*
>> 4c626ac2a83ef30dfb9260e6f59c2b30  gcc-5.4.0.tar.bz2
>> 4c626ac2a83ef30dfb9260e6f59c2b30  gcc-5.4.0.tar.bz2.1
>> 4c626ac2a83ef30dfb9260e6f59c2b30  gcc-5.4.0.tar.bz2.2
>> 4c626ac2a83ef30dfb9260e6f59c2b30  gcc-5.4.0.tar.bz2.3
>> 4c626ac2a83ef30dfb9260e6f59c2b30  gcc-5.4.0.tar.bz2.4
>>
>> On the MIPS system (the NFS client):
>>
>> bcm91250a-le distfiles # md5sum gcc-5.4.0.tar.bz2.2
>> 35346975989954df8a8db2b034da610d  gcc-5.4.0.tar.bz2.2
>> bcm91250a-le distfiles # md5sum gcc-5.4.0.tar.bz2*
>> 4c626ac2a83ef30dfb9260e6f59c2b30  gcc-5.4.0.tar.bz2
>> 4c626ac2a83ef30dfb9260e6f59c2b30  gcc-5.4.0.tar.bz2.1
>> 35346975989954df8a8db2b034da610d  gcc-5.4.0.tar.bz2.2
>> 4c626ac2a83ef30dfb9260e6f59c2b30  gcc-5.4.0.tar.bz2.3
>> 4c626ac2a83ef30dfb9260e6f59c2b30  gcc-5.4.0.tar.bz2.4
>>
>> The first file read will contain some corruption, and it is persistent until...
>>
>> bcm91250a-le distfiles # echo 1 > /proc/sys/vm/drop_caches
>> bcm91250a-le distfiles # md5sum gcc-5.4.0.tar.bz2*
>> 4c626ac2a83ef30dfb9260e6f59c2b30  gcc-5.4.0.tar.bz2
>> 4c626ac2a83ef30dfb9260e6f59c2b30  gcc-5.4.0.tar.bz2.1
>> 4c626ac2a83ef30dfb9260e6f59c2b30  gcc-5.4.0.tar.bz2.2
>> 4c626ac2a83ef30dfb9260e6f59c2b30  gcc-5.4.0.tar.bz2.3
>> 4c626ac2a83ef30dfb9260e6f59c2b30  gcc-5.4.0.tar.bz2.4
>>
>> the caches are dropped, at which point it reads back properly.
>>
>> Note that the corruption is different across reboots, both in the size
>> of the corruption and the location. I saw 1900~ and 1400~ byte
>> sequences corrupted on separate occasions, which don't correspond to
>> the system's 16kB page size.
>>
>> I've tested kernels from v3.19 to 4.11-rc1+ (master branch from
>> today). All exhibit this behavior with differing frequencies. Earlier
>> kernels seem to reproduce the issue less often, while more recent
>> kernels reliably exhibit the problem every boot.
>>
>> How can I further debug this?
>
> I think I was wrong about the statement about kernels v3.19 to
> 4.11-rc1+. I found out I couldn't reproduce with 4.7-rc1 and then
> bisected to 4cd13c21b207e80ddb1144c576500098f2d5f882 ("softirq: Let
> ksoftirqd do its job"). Still reproduces with current tip of Linus'
> tree.
>
> Any ideas? The board's ethernet is an uncommon device supported by
> CONFIG_SB1250_MAC. Something about the ethernet driver maybe?

With the patch reverted on master (reverts cleanly), NFS corruption no
longer happens.
