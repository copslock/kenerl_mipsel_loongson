Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Jan 2013 19:25:49 +0100 (CET)
Received: from dns1.mips.com ([12.201.5.69]:59818 "EHLO dns1.mips.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6816521Ab3ADSZscWZwy convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Jan 2013 19:25:48 +0100
Received: from mailgate1.mips.com (mailgate1.mips.com [12.201.5.111])
        by dns1.mips.com (8.13.8/8.13.8) with ESMTP id r04IPeQ1009287;
        Fri, 4 Jan 2013 10:25:40 -0800
X-WSS-ID: 0MG45TP-01-24M-02
X-M-MSG: 
Received: from exchdb01.mips.com (unknown [192.168.36.84])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mailgate1.mips.com (Postfix) with ESMTP id 229D236465C;
        Fri,  4 Jan 2013 10:25:00 -0800 (PST)
Received: from EXCHDB03.MIPS.com ([fe80::6df1:ae84:797e:9076]) by
 exchhub01.mips.com ([::1]) with mapi id 14.02.0247.003; Fri, 4 Jan 2013
 10:24:55 -0800
From:   "Hill, Steven" <sjhill@mips.com>
To:     David Daney <ddaney.cavm@gmail.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "jchandra@broadcom.com" <jchandra@broadcom.com>
Subject: RE: [PATCH v3] MIPS: Optimise TLB handlers for MIPS32/64 R2 cores.
Thread-Topic: [PATCH v3] MIPS: Optimise TLB handlers for MIPS32/64 R2 cores.
Thread-Index: AQHN6qU9UKBlTq5FeUuwhULMCz9AMZg5/24A//97J4Y=
Date:   Fri, 4 Jan 2013 18:24:54 +0000
Message-ID: <31E06A9FC96CEC488B43B19E2957C1B801146AF100@exchdb03.mips.com>
References: <1357322355-31622-1-git-send-email-sjhill@mips.com>,<50E71BF8.3050308@gmail.com>
In-Reply-To: <50E71BF8.3050308@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.36.79]
x-ems-proccessed: 6LP3oGfGVdcdb8o1aBnt6w==
x-ems-stamp: NtxUHQ/gjj18I5uxbWYO/Q==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-archive-position: 35370
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@mips.com
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

>> +#ifdef CONFIG_64BIT
>> +                     (PAGE_SHIFT - PTE_ORDER - PTE_T_LOG2 - 1));
>> +#else
>> +                     (PGDIR_SHIFT - PAGE_SHIFT - 1));
>> +#endif
>> +             UASM_i_INS(p, ptr, tmp, (PTE_T_LOG2 + 1),
>
> As far as I can tell, (PAGE_SHIFT - PTE_ORDER - PTE_T_LOG2 - 1) and
> (PGDIR_SHIFT - PAGE_SHIFT - 1) are the same thing.  So why the two cases?
>
>Can you give an example of where they might differ?
>
David,

Actually, no I cannot. The calculation was given to me by 'jchandra' and since I do not have 64-bit R2 hardware let alone the Broadcom platform, he said it worked on his platform and I took it from him as is. So does this patch work on Cavium platforms using both calculation methods? It would be nice if 'jchandra' could chime in, but he may be on holiday or something.

-Steve
