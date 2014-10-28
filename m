Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Oct 2014 14:49:05 +0100 (CET)
Received: from mail-oi0-f54.google.com ([209.85.218.54]:63865 "EHLO
        mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011346AbaJ1NtDaw3r9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Oct 2014 14:49:03 +0100
Received: by mail-oi0-f54.google.com with SMTP id v63so511503oia.41
        for <linux-mips@linux-mips.org>; Tue, 28 Oct 2014 06:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=EEYQIxTWpjRjUBjrCypC/ZDE0PooHl7HxaB5bHO97qg=;
        b=0KebsoGWZbP6r+L93JKQvXaclojtOZZkSz0lg2bSd4l52nX2r6UaP2RIncSJQfAwvM
         8SMKf61L4qSRcMmMwmrbdmC1RfH9k093pKOpt0nDLYmBdSGD4fTUIEPv4zXFMIHMeCU9
         Uicv5EKrnih9zGB44QL1Ix4eKOhjJmbqMhywOVQgLYug+B72cYGwPdWSVltGeuxIuoII
         IjjXkBGPwwekTCbPk96Wiu5Bs6Qdr6OpQPODF3QYifbQHfSAxCJjHIqnNdo82FUb6svC
         JFfDFRyrqd+BCy7sPFMktOl37fNZRlQTp9LOW//EwKPxvrKBQw1ex6VaZxmaNyHdSopa
         kdZg==
MIME-Version: 1.0
X-Received: by 10.182.20.76 with SMTP id l12mr1698141obe.63.1414504135856;
 Tue, 28 Oct 2014 06:48:55 -0700 (PDT)
Received: by 10.202.231.73 with HTTP; Tue, 28 Oct 2014 06:48:55 -0700 (PDT)
In-Reply-To: <544F991E.3070500@imgtec.com>
References: <544F73CD.1010409@imgtec.com>
        <CAAmzW4NdBNhsPtx1yw+drN+J=a23SS3yLkgQdvQx-Giokwxu-Q@mail.gmail.com>
        <544F97D4.4030408@imgtec.com>
        <544F991E.3070500@imgtec.com>
Date:   Tue, 28 Oct 2014 22:48:55 +0900
Message-ID: <CAAmzW4O6EFq-aaAi5gNFng1dhyXJdUmEMTR8meJfir=47iwmZw@mail.gmail.com>
Subject: Re: Boot problems on Malta with EVA (bisected to 12220dea07f1
 "mm/slab: support slab merge")
From:   Joonsoo Kim <js1304@gmail.com>
To:     Markos Chandras <Markos.Chandras@imgtec.com>
Cc:     Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <js1304@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43635
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: js1304@gmail.com
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

2014-10-28 22:24 GMT+09:00 Markos Chandras <Markos.Chandras@imgtec.com>:
> On 10/28/2014 01:19 PM, Markos Chandras wrote:
>> On 10/28/2014 01:01 PM, Joonsoo Kim wrote:
>>> 2014-10-28 19:45 GMT+09:00 Markos Chandras <Markos.Chandras@imgtec.com>:
>>>> Hi,
>>>>
>>>> It seems I am unable to boot my Malta with EVA. The problem appeared in
>>>> the 3.18 merge window. I bisected the problem (between v3.17 and
>>>> v3.18-rc1) and I found the following commit responsible for the broken boot.
>>>
>>> Hello,
>>>
>>> Did you start to bisect from v3.18-rc1?
>>> I'd like to be sure that this is another bug which is fixed by following commit.
>>>
>>> commit 85c9f4b04a08f6bc770b77530c22d04103468b8f
>>> Author: Joonsoo Kim <iamjoonsoo.kim@lge.com>
>>> Date:   Mon Oct 13 15:51:01 2014 -0700
>>>
>>>     mm/slab: fix unaligned access on sparc64
>>>
>>> This fix is merged into v3.18-rc1 sometime later that
>>> 'support slab merge' is merged.
>>>
>>> Thanks.
>>>
>> Hi,
>>
>> I bisected from v3.17 until 3.18-rc1. But 3.18-rc2 and the latest
>> mainline (f7e87a44ef60ad379e39b45437604141453bf0ec) still have the same
>> problem
>>
>> btw i did more tests and this is not EVA specific. A maltaup_defconfig
>> fails in the same way. I suspect all malta*_defconfigs will fail in a
>> similar way which makes it probably easier for you to reproduce it on a
>> QEMU.
>>
>
> sorry maltaup_defconfig does not fail. maltasmvp_defconfig does. So it
> might be a similar problem like the one fixed in
> 85c9f4b04a08f6bc770b77530c22d04103468b8f

Oops. Sorry. Above commit ('mm/slab: fix unaligned access on sparc64')
is irrelevant to this problem.

Anyway, your problem would be related to merging with incompatible slab cache.
Best way to debug is printing source/target slab cache's object size and
alignment and find the problem. I will try to reproduce it using QEMU.

Thanks.
