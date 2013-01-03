Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Jan 2013 00:00:40 +0100 (CET)
Received: from dns1.mips.com ([12.201.5.69]:47424 "EHLO dns1.mips.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6816521Ab3ACXAjvunWN convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Jan 2013 00:00:39 +0100
Received: from mailgate1.mips.com (mailgate1.mips.com [12.201.5.111])
        by dns1.mips.com (8.13.8/8.13.8) with ESMTP id r03N0WwU022536;
        Thu, 3 Jan 2013 15:00:32 -0800
X-WSS-ID: 0MG2NWS-01-1TI-02
X-M-MSG: 
Received: from exchdb01.mips.com (unknown [192.168.36.84])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mailgate1.mips.com (Postfix) with ESMTP id 29D0236464B;
        Thu,  3 Jan 2013 15:00:28 -0800 (PST)
Received: from EXCHDB03.MIPS.com ([fe80::6df1:ae84:797e:9076]) by
 exchhub01.mips.com ([::1]) with mapi id 14.02.0247.003; Thu, 3 Jan 2013
 15:00:26 -0800
From:   "Hill, Steven" <sjhill@mips.com>
To:     David Daney <ddaney.cavm@gmail.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "jchandra@broadcom.com" <jchandra@broadcom.com>
Subject: RE: [PATCH v2] MIPS: Optimise TLB handlers for MIPS32/64 R2 cores.
Thread-Topic: [PATCH v2] MIPS: Optimise TLB handlers for MIPS32/64 R2 cores.
Thread-Index: AQHN6fuyFYyNoBfwFkawzkGY5WNW8Jg4uBmA//99ra8=
Date:   Thu, 3 Jan 2013 23:00:24 +0000
Message-ID: <31E06A9FC96CEC488B43B19E2957C1B801146AF09D@exchdb03.mips.com>
References: <1357249536-2308-1-git-send-email-sjhill@mips.com>,<50E60845.9060700@gmail.com>
In-Reply-To: <50E60845.9060700@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.36.79]
x-ems-proccessed: 6LP3oGfGVdcdb8o1aBnt6w==
x-ems-stamp: 4+XaOD2R76cQfdm1fZtJYA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-archive-position: 35361
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

>> +     if (cpu_has_mips_r2) {
>> +             /* PTE ptr offset is obtained from BadVAddr */
>> +             UASM_i_MFC0(p, tmp, C0_BADVADDR);
>> +             UASM_i_LW(p, ptr, 0, ptr);
>> +#ifdef CONFIG_CPU_MIPS64
>
> Is this the right condition?  Is is correct for a 32-bit kernel running
> on a 64-bit CPU?  Will OCTEON be covered? (no, but it should)
>
You're right. The condition should be using CONFIG_64BIT instead. With regards to OCTEON, please test on your platforms and give me a patch.

> Can this whole thing be made more clear by defining UASM_i_EXT(...) that
> does the proper thing for either 32 or 64 bit kernels as the rest of the
> capitolized versions of the macros do?
>
Certainly.

> Is (PAGE_SHIFT - PTE_ORDER - PTE_T_LOG2 - 1) != (PGDIR_SHIFT -
> PAGE_SHIFT - 1) for any combinations of config options?  Why are they
> different for the two cases?
>
I do not have 64-bit R2 hardware access. I plugged in the value that jchandra gave to me that worked for him. Other platform testers and their input would be appreciated and welcomed.

-Steve
