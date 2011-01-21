Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Jan 2011 12:16:12 +0100 (CET)
Received: from mail-ew0-f49.google.com ([209.85.215.49]:55028 "EHLO
        mail-ew0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491784Ab1AULQI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 21 Jan 2011 12:16:08 +0100
Received: by ewy20 with SMTP id 20so737712ewy.36
        for <multiple recipients>; Fri, 21 Jan 2011 03:16:06 -0800 (PST)
Received: by 10.213.22.209 with SMTP id o17mr692541ebb.41.1295608566393;
        Fri, 21 Jan 2011 03:16:06 -0800 (PST)
Received: from [192.168.2.2] ([91.79.98.21])
        by mx.google.com with ESMTPS id u1sm7409388eeh.16.2011.01.21.03.16.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 21 Jan 2011 03:16:04 -0800 (PST)
Message-ID: <4D396AAF.6080603@mvista.com>
Date:   Fri, 21 Jan 2011 14:14:55 +0300
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-GB; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
MIME-Version: 1.0
To:     Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
CC:     ralf@linux-mips.org, a.p.zijlstra@chello.nl, fweisbec@gmail.com,
        will.deacon@arm.com, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, wuzhangjin@gmail.com,
        paulus@samba.org, mingo@elte.hu, acme@redhat.com,
        matt@console-pimps.org, ddaney@caviumnetworks.com
Subject: Re: [PATCH v4 3/5] MIPS/Perf-events: Fix event check in validate_event()
References: <1295597961-7565-1-git-send-email-dengcheng.zhu@gmail.com> <1295597961-7565-4-git-send-email-dengcheng.zhu@gmail.com>
In-Reply-To: <1295597961-7565-4-git-send-email-dengcheng.zhu@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29007
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

On 21-01-2011 11:19, Deng-Cheng Zhu wrote:

> Ignore events that are in off/error state or belong to a different PMU.

> This patch originates from the following commit for ARM by Will Deacon:

> - 65b4711ff513767341aa1915c822de6ec0de65cb
>      ARM: 6352/1: perf: fix event validation

>      The validate_event function in the ARM perf events backend has the
>      following problems:

>      1.) Events that are disabled count towards the cost.
>      2.) Events associated with other PMUs [for example, software events or
>          breakpoints] do not count towards the cost, but do fail validation,
>          causing the group to fail.

>      This patch changes validate_event so that it ignores events in the
>      PERF_EVENT_STATE_OFF state or that are scheduled for other PMUs.

> Changes:
> v4 - v3:
> o None
> v3 - v2:
> o Keep all mentioned commits in the form of number + title + original
> summary + (MIPS specific info when needed).
> v2 - v1:
> o Corrected the return value of the event check in validate_event().

    The patch changes should follow the --- tearline, not precede it.

> Acked-by: Will Deacon<will.deacon@arm.com>
> Acked-by: David Daney<ddaney@caviumnetworks.com>
> Signed-off-by: Deng-Cheng Zhu<dengcheng.zhu@gmail.com>
> ---

WBR, Sergei
