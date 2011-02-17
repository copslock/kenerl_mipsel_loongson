Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Feb 2011 20:24:00 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:4300 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491109Ab1BQTX5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Feb 2011 20:23:57 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4d5d75fc0000>; Thu, 17 Feb 2011 11:24:44 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 17 Feb 2011 11:23:52 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 17 Feb 2011 11:23:52 -0800
Message-ID: <4D5D75C7.8020302@caviumnetworks.com>
Date:   Thu, 17 Feb 2011 11:23:51 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@elte.hu>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH v2 4/4] MIPS: perf: Add support for 64-bit perf counters.
References: <1295650776-28444-1-git-send-email-ddaney@caviumnetworks.com>       <1295650776-28444-5-git-send-email-ddaney@caviumnetworks.com>   <AANLkTimFnBJeU7BT6ARM=+KSod0UB-XFZTxgWWh1N=i2@mail.gmail.com>  <4D3F68BE.5080803@caviumnetworks.com>   <AANLkTim54xV64utR0GdS1r4_LBoAjEOHH9_=TYSLSqMF@mail.gmail.com>  <4D41BC6B.8010408@caviumnetworks.com>   <AANLkTi=R86zBH8ZY+CdGyeXsSd0-yHdRVVx0ZWTJf4qe@mail.gmail.com> <AANLkTikTV-=A8H=h_F+025VB37tHSmxpsNCGndi_dAFW@mail.gmail.com>
In-Reply-To: <AANLkTikTV-=A8H=h_F+025VB37tHSmxpsNCGndi_dAFW@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Feb 2011 19:23:52.0469 (UTC) FILETIME=[36042450:01CBCED8]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29213
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

On 02/17/2011 02:46 AM, Deng-Cheng Zhu wrote:
> Hi, David
[...]
>
> And here's a general comment: You are putting the majority of the
> implementation in perf_event_mipsxx.c. This will require other CPUs like
> Loongson2 to replicate quite a lot code in their corresponding files.

There is no such implementation.  But if someone were to create one, I 
would suggest they move common code to a separate file that would be 
shared among the implementations that need it.

> I
> personally think the original "skeleton + #include perf_event_$cpu.c" is a
> better choice. I understand you prefer not using code like
> "#if defined(CONFIG_CPU_MIPS32)" on the top of perf_event_$cpu.c, but that
> is what other architectures (X86/ARM etc) are doing.
>

Existing poor practice is not a good reason to do this.

David Daney
