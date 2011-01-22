Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 22 Jan 2011 01:18:02 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:15669 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491834Ab1AVAR5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 22 Jan 2011 01:17:57 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4d3a22620000>; Fri, 21 Jan 2011 16:18:42 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 21 Jan 2011 16:17:53 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 21 Jan 2011 16:17:53 -0800
Message-ID: <4D3A2231.1040802@caviumnetworks.com>
Date:   Fri, 21 Jan 2011 16:17:53 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH 0/6] MIPS: perf: Make perf work for 64-bit/Octeon counters.
References: <1294367707-2593-1-git-send-email-ddaney@caviumnetworks.com> <AANLkTimZKz_Epg8DOvwkWWcS0viUa2V2TygUS80osEwh@mail.gmail.com>
In-Reply-To: <AANLkTimZKz_Epg8DOvwkWWcS0viUa2V2TygUS80osEwh@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Jan 2011 00:17:53.0438 (UTC) FILETIME=[CFB323E0:01CBB9C9]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29022
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

On 01/20/2011 01:59 AM, Deng-Cheng Zhu wrote:
> Hi, David
>
>
> Today I did a quick test against your patch set on my MIPS32 Malta board.
> After fixing a small compiling issue (see my comment for patch #5), I
> successfully built the kernel based on my previous mainline-sync changes.
> And when doing the test, I was using the an previously compiled 'perf'
> tool, because the latest perf tool needs arch specific DWARF register
> mapping definitions (and currently we have not yet submitted this patch).
>
> And here's the test result:
>
> # When this patch set is built in, the simple 'perf stat' command takes
> very long time (182 seconds for the ls command). See following:
>
> -sh-4.0# perf stat -e cycles -e instructions ls /
> bin   dev  home  lost+found  opt   root  share  tmp    usr
> boot  etc  lib   mnt         proc  sbin  sys    trans  var
>
>   Performance counter stats for 'ls /':
>
>           2825998290  cycles
>           2148970283  instructions             #      0.760 IPC
>
>        181.901999444  seconds time elapsed
>
> # When this patch is NOT used, namely, only the mainline-sync changes are
> built in, the time looks reasonable:
>
> -sh-4.0# perf stat -e cycles -e instructions ls /
> bin   dev  home  lost+found  opt   root  share  tmp    usr
> boot  etc  lib   mnt         proc  sbin  sys    trans  var
>
>   Performance counter stats for 'ls /':
>
>              2051461  cycles
>              1041512  instructions             #      0.508 IPC
>
>          0.046426513  seconds time elapsed
>
> I noticed that you changed quite a lot of original logics in MIPS
> Perf-events, including the deletion of the 'msbs' member in the struct
> cpu_hw_events. Honestly speaking, I have not yet taken a careful look into
> the patch set to find out how you deal with the MIPS specific 0x80000000
> counter overflow (certainly, the value is for MIPS32), instead of
> 0xffffffff. But maybe this code logic could be related to the test result.
>
>

Can you test the new version of my patches I just posted?  I think I may 
have fixed this issue, but I cannot actually test 32-bit counters.

I think I was initializing the counters to the wrong value in the 32-bit 
case.  This would have caused an almost unending stream of counter 
overflow interrupts, thus slowing things down

David Daney
