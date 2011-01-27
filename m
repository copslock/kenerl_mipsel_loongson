Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Jan 2011 07:25:10 +0100 (CET)
Received: from mail-gx0-f177.google.com ([209.85.161.177]:42703 "EHLO
        mail-gx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490975Ab1A0GZH convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 27 Jan 2011 07:25:07 +0100
Received: by gxk21 with SMTP id 21so476539gxk.36
        for <multiple recipients>; Wed, 26 Jan 2011 22:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=vwmYzthWQsaT5utzwmUU/y36uozIVXd2XNb+NL5FoJs=;
        b=dEIEX7cyq+ocw6apN+ZDR2EUWX9RjLxiHau8abHpSgGnmIl0YwR+sXKWXNUjAizTUb
         KX0EFkRTA2TCpB2BddSs96og5jC6zrgZa00EjEb+VIveZCUAXv+1F+0sgKopqX/7nFv/
         /rRg3ZfPDL+J5P3cI9Q7B2MvqACppvHL07QMA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=fW5Q3xULXdDcij4L6ZeOq0dL5QDGytdiP/Dx1wLbuy4sxSbuHYPNsMVwdeS72U0b6L
         eAIsH20VCjeCyonQ9HLHuY9nguh7LK1BVaXoNf8OYw81y9WBgDh0DnfPgb+UAQNpErvm
         P89A0dAsnc0e3038jbYPl+N0kRYDy1xe5Z7+w=
MIME-Version: 1.0
Received: by 10.151.77.42 with SMTP id e42mr2186692ybl.367.1296109499264; Wed,
 26 Jan 2011 22:24:59 -0800 (PST)
Received: by 10.147.136.11 with HTTP; Wed, 26 Jan 2011 22:24:59 -0800 (PST)
In-Reply-To: <4D3F68BE.5080803@caviumnetworks.com>
References: <1295650776-28444-1-git-send-email-ddaney@caviumnetworks.com>
        <1295650776-28444-5-git-send-email-ddaney@caviumnetworks.com>
        <AANLkTimFnBJeU7BT6ARM=+KSod0UB-XFZTxgWWh1N=i2@mail.gmail.com>
        <4D3F68BE.5080803@caviumnetworks.com>
Date:   Thu, 27 Jan 2011 14:24:59 +0800
Message-ID: <AANLkTim54xV64utR0GdS1r4_LBoAjEOHH9_=TYSLSqMF@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] MIPS: perf: Add support for 64-bit perf counters.
From:   Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@elte.hu>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <dengcheng.zhu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29091
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@gmail.com
Precedence: bulk
X-list: linux-mips

Using your attached patch, I experimented -c and -F by 'ls /'. The numbers
I used are 10, 1000 and 100000 for both -c and -F.

The number of samples I got was 24 all the way. That means the event period
to sample and the profiling frequency do not affect the results on MIPS32
platform. While working on the old code, the system had the following
results:

-c 10: The system seems busy dealing with interrupts. And the following log
       was printed out:
       ================================================
       hda: ide_dma_sff_timer_expiry: DMA status (0x24)
       hda: DMA interrupt recovery
       hda: lost interrupt
       ================================================
       This does need to be fixed later on.
-c 1000: ~11085 samples
-c 100000: ~48 samples ('perf report' still showed some data.)
-F 10: ~118 samples
-F 1000: ~352 samples
-F 100000: ~379 samples

I'll try to take time to look into the patch to see if anything can be
changed.


Deng-Cheng


2011/1/26 David Daney <ddaney@caviumnetworks.com>:
> On 01/24/2011 07:42 PM, Deng-Cheng Zhu wrote:
>>
>> Hi, David
>>
>>
>> This version does fix the problem with 'perf stat'. However, when working
>> with 'perf record', the following happened:
>>
>> -sh-4.0# perf record -f -e cycles -e instructions -e branches \
>>>
>>> -e branch-misses -e r12 find / -name "*sys*">/dev/null
>>
>> [ perf record: Woken up 1 times to write data ]
>> [ perf record: Captured and wrote 0.001 MB perf.data (~53 samples) ]
>
>
> I get the same thing.  What happens if you supply either '-c xxx' or '-f
> xxx'?
>
> I get:octeon:~/linux/tools/perf# ./perf record -e cycles /bin/ls -l /
> total 100
> drwxr-xr-x   2 root root  4096 2010-11-12 11:39 bin
> [...]
> drwxr-xr-x  13 root root  4096 2007-05-25 12:28 var
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.002 MB perf.data (~82 samples) ]
>
> Almost no samples as you got.
>
> But if I do:
>
> octeon:~/linux/tools/perf# ./perf record -F 100000 -e cycles /bin/ls -l /
> total 100
> drwxr-xr-x   2 root root  4096 2010-11-12 11:39 bin
> [...]
> drwxr-xr-x  13 root root  4096 2007-05-25 12:28 var
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.404 MB perf.data (~17653 samples) ]
>
> Look many more samples!
>
> The question is, what is it supposed to do?
>
> If you can get a reasonable number of samples out if you supply -c or
> -F, then I would argue that it is working and the default settings for
> -F are not a good fit for your test case.
>
> I have slightly changed the patch.  You could try the attached version
> instead and tell me the results.
>
>
> David Daney
>
>
>
