Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Jan 2011 08:38:44 +0100 (CET)
Received: from mail-yx0-f177.google.com ([209.85.213.177]:48515 "EHLO
        mail-yx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491056Ab1AXHik convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 24 Jan 2011 08:38:40 +0100
Received: by yxd30 with SMTP id 30so815143yxd.36
        for <multiple recipients>; Sun, 23 Jan 2011 23:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=7GJw1h9TIvrag4opmkA55nQhuWxeLmsnmIVYdBLiWHI=;
        b=Huwg/TIVSIXliNGa4E3N2eHH4Egf1lwtiF2lilgS+W1oWWqDv99U7SMReZEJ5PVTSq
         G+Vd4FXROu8nSHpJf/XhS+kOWXJTLDfq84OjeQIS9WuHRpbhlD/KokpmNN0zQMt0RahT
         PC71HDhUczS2xoucPgNs/n/Z01SxoZ5VxYvV4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=k82kfvLvm9yUYNNf7sBqScEo+JqodQrvx5SmsFM1XXMgMbNc+y3e5y9YgoZnmNz3BG
         G+cDUkKV4KpK7nQcmYHt2ZEj/FrAZZRAF0aMqhv426wkWyioYK9wujqGNvq80Deil+n8
         z6JcQXsCwgKmdyFqQW5oZbNMlxGMClaiw9Hkk=
MIME-Version: 1.0
Received: by 10.100.105.6 with SMTP id d6mr2689311anc.89.1295854714188; Sun,
 23 Jan 2011 23:38:34 -0800 (PST)
Received: by 10.147.136.11 with HTTP; Sun, 23 Jan 2011 23:38:34 -0800 (PST)
In-Reply-To: <4D396AAF.6080603@mvista.com>
References: <1295597961-7565-1-git-send-email-dengcheng.zhu@gmail.com>
        <1295597961-7565-4-git-send-email-dengcheng.zhu@gmail.com>
        <4D396AAF.6080603@mvista.com>
Date:   Mon, 24 Jan 2011 15:38:34 +0800
Message-ID: <AANLkTin34=STRp+xstbvwD5W2scEfZj5Fjf0L7F=oo4j@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] MIPS/Perf-events: Fix event check in validate_event()
From:   Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
To:     Sergei Shtylyov <sshtylyov@mvista.com>
Cc:     ralf@linux-mips.org, a.p.zijlstra@chello.nl, fweisbec@gmail.com,
        will.deacon@arm.com, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, wuzhangjin@gmail.com,
        paulus@samba.org, mingo@elte.hu, acme@redhat.com,
        matt@console-pimps.org, ddaney@caviumnetworks.com
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <dengcheng.zhu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29032
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@gmail.com
Precedence: bulk
X-list: linux-mips

Thanks. The patch set was resent.


Deng-Cheng

2011/1/21 Sergei Shtylyov <sshtylyov@mvista.com>:
> Hello.
>
> On 21-01-2011 11:19, Deng-Cheng Zhu wrote:
>
>> Ignore events that are in off/error state or belong to a different PMU.
>
>> This patch originates from the following commit for ARM by Will Deacon:
>
>> - 65b4711ff513767341aa1915c822de6ec0de65cb
>>     ARM: 6352/1: perf: fix event validation
>
>>     The validate_event function in the ARM perf events backend has the
>>     following problems:
>
>>     1.) Events that are disabled count towards the cost.
>>     2.) Events associated with other PMUs [for example, software events or
>>         breakpoints] do not count towards the cost, but do fail
>> validation,
>>         causing the group to fail.
>
>>     This patch changes validate_event so that it ignores events in the
>>     PERF_EVENT_STATE_OFF state or that are scheduled for other PMUs.
>
>> Changes:
>> v4 - v3:
>> o None
>> v3 - v2:
>> o Keep all mentioned commits in the form of number + title + original
>> summary + (MIPS specific info when needed).
>> v2 - v1:
>> o Corrected the return value of the event check in validate_event().
>
>   The patch changes should follow the --- tearline, not precede it.
>
>> Acked-by: Will Deacon<will.deacon@arm.com>
>> Acked-by: David Daney<ddaney@caviumnetworks.com>
>> Signed-off-by: Deng-Cheng Zhu<dengcheng.zhu@gmail.com>
>> ---
>
> WBR, Sergei
>
