Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Apr 2014 20:38:16 +0200 (CEST)
Received: from mail-ig0-f176.google.com ([209.85.213.176]:42093 "EHLO
        mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6815921AbaDUSiMs90pQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 21 Apr 2014 20:38:12 +0200
Received: by mail-ig0-f176.google.com with SMTP id uy17so2090828igb.3
        for <linux-mips@linux-mips.org>; Mon, 21 Apr 2014 11:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=oo/3Dd/LImMoPUfOgXKAGLH8Npg/j54fLsBo1ds0h8s=;
        b=If2TozaWm3rczbG3tVa02KPhbzGrT/krKKKYwa+YL5Z6nzjsgsnkGm6aDZs3JO8iDx
         7lP5LS57xL9leTgXuMEE3xDA7ILkVGjEUVnXk5ghqVrv8k09B7pdMKhEfEpd0unZMY2k
         PNGtlDyxLkVANuZuYCwsHR+b1FCz78l8b2HpzMfYcBnKY8pEg4eV3MyO1EKyISEoeUJV
         PyiEb1l6dAZpuUP05JF5zKgzjAGSCRgtVFbB1mGimIwO4ZnOtu4WQ3SscT8Bp7tnRGYX
         L/guYlUDukJ5XQbpPpHjn4OE116xEhPltg2pRhBI1WN/DQhorBNp/iEjCe6SmjqWqw/N
         H9wg==
X-Received: by 10.42.157.74 with SMTP id c10mr3074856icx.74.1398105486523;
        Mon, 21 Apr 2014 11:38:06 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id lp5sm23016922igb.1.2014.04.21.11.38.05
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 21 Apr 2014 11:38:05 -0700 (PDT)
Message-ID: <5355658C.9000206@gmail.com>
Date:   Mon, 21 Apr 2014 11:38:04 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Prem Karat <pkarat@mvista.com>
CC:     linux-mips@linux-mips.org
Subject: Re: [RFC PATCH 1/1] MIPS: Enable VDSO randomization.
References: <20140419093302.GH2717@064904.mvista.com> <5352FF15.2080003@gmail.com> <20140421034015.GA2489@064904.mvista.com>
In-Reply-To: <20140421034015.GA2489@064904.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39878
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

On 04/20/2014 08:40 PM, Prem Karat wrote:
> On 04/19/14 03:56pm, David Daney wrote:
>> On 04/19/2014 02:33 AM, Prem Karat wrote:
>>> Based on commit 1091458d09e1a (mmap randomization)
>>>
>>> For 32-bit address spaces randomize within a
>>> 16MB space, for 64-bit within a 256MB space.
>>>
>>
>> How was it tested (i.e. what workload did you run to verify that the
>> kernel still functions with this change)?
>>
> David, Sergei,
>
> Thank You for reviewing the patch.
>
> Am using test suite from Ubuntu which is available here.
> http://bazaar.launchpad.net/~ubuntu-bugcontrol/qa-regression-testing/master/files/head:/scripts/kernel-security/aslr/
>

As you probably know, currently the "vdso" in mips is really only used 
for signal return trampolines.  So to properly test it, you need code 
that does returns from signal handlers.

Does your test suite do that?


> Please find the test results below.
>
> Without Patch (VDSO is not randomized)
> ---------------------------------------
>
> root@Maleo:~# ./aslr vdso
> FAIL: ASLR not functional (vdso always at 0x7fff7000)
>
> root@Maleo:~# ./aslr rekey vdso
> pre_val==cur_val
> value=0x7fff7000
>
[...]
>
>>> +
>>> +	return (STACK_TOP + offset);
>>
>> How can you be sure this address doesn't collide with, or otherwise
>> interfere with, the stack?
>>
>
> It doesn't, as this program can print the maps file and here is the output of the
> maps file each time we run aslr showing maps file.
>
> root@cavium-octeon2:~# ./aslr rekey maps
> 78584000-785a5000 rwxp 00000000 00:00 0                                  [heap]
> 7f9d0000-7f9f1000 rw-p 00000000 00:00 0                                  [stack]
> 7ffa5000-7ffa6000 r-xp 00000000 00:00 0                                  [vdso]
>
> root@cavium-octeon2:~# ./aslr rekey maps
> 77de0000-77e01000 rwxp 00000000 00:00 0                                  [heap]
> 7f91b000-7f93c000 rw-p 00000000 00:00 0                                  [stack]
> 7ff99000-7ff9a000 r-xp 00000000 00:00 0                                  [vdso]
>
> root@cavium-octeon2:~# ./aslr rekey maps
> 77d7f000-77da0000 rwxp 00000000 00:00 0                                  [heap]
> 7fc2a000-7fc4b000 rw-p 00000000 00:00 0                                  [stack]
> 7fe09000-7fe0a000 r-xp 00000000 00:00 0                                  [vdso]
>
> root@cavium-octeon2:~# ./aslr rekey maps
> 7794c000-7794d000 r-xp 00000000 00:00 0                                  [vdso]
> 77e4b000-77e6c000 rwxp 00000000 00:00 0                                  [heap]
> 7f6e7000-7f708000 rw-p 00000000 00:00 0                                  [stack]
> root@cavium-octeon2:~#
>

Four test runs is not enough to satisfy my curiosity.  It could be that 
in these test cases, the random numbers never lined up for a collision.

You are attempting to generate two random memory maps (Stack and VDSO) 
that are in the same region of memory.  How does the system handle the 
possibility that the initial random values would collide for these two 
things.

Showing a few runs of a test program is not enough.  I would like an 
explanation of what happens when there is a collision, and how the 
system properly handles it.

Thanks,
David Daney


>>
>> Also, as mentioned by Sergei, run checkpatch.pl to catch obvious
>> stylistic problems before submitting patches.
>>
>
> I will make the changes and send a v2 patch.
>
>
