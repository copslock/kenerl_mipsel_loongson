Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 15 Dec 2012 06:10:26 +0100 (CET)
Received: from dns1.mips.com ([12.201.5.69]:47452 "EHLO dns1.mips.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6816206Ab2LOFKVAX5b8 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 15 Dec 2012 06:10:21 +0100
Received: from mailgate1.mips.com (mailgate1.mips.com [12.201.5.111])
        by dns1.mips.com (8.13.8/8.13.8) with ESMTP id qBF5ACR0006690;
        Fri, 14 Dec 2012 21:10:12 -0800
X-WSS-ID: 0MF23OX-01-2RQ-02
X-M-MSG: 
Received: from exchdb01.mips.com (unknown [192.168.36.84])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mailgate1.mips.com (Postfix) with ESMTP id 2882336465D;
        Fri, 14 Dec 2012 21:10:09 -0800 (PST)
Received: from EXCHDB03.MIPS.com ([fe80::6df1:ae84:797e:9076]) by
 exchhub01.mips.com ([::1]) with mapi id 14.01.0270.001; Fri, 14 Dec 2012
 21:10:06 -0800
From:   "Hill, Steven" <sjhill@mips.com>
To:     Florian Fainelli <florian@openwrt.org>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: RE: [PATCH] MIPS: dsp: Add assembler support for DSP ASEs.
Thread-Topic: [PATCH] MIPS: dsp: Add assembler support for DSP ASEs.
Thread-Index: AQHN1DbCEutikq7i/UCxLXUHzYmgqZgVxmQAgAOVCZc=
Date:   Sat, 15 Dec 2012 05:10:05 +0000
Message-ID: <31E06A9FC96CEC488B43B19E2957C1B801146AB429@exchdb03.mips.com>
References: <1354855981-28392-1-git-send-email-sjhill@mips.com>,<50C8938C.8020705@openwrt.org>
In-Reply-To: <50C8938C.8020705@openwrt.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.36.79]
x-ems-proccessed: 6LP3oGfGVdcdb8o1aBnt6w==
x-ems-stamp: 2PYP6mgVtyrb/8rE9O0mAQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-archive-position: 35291
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

>> +ifeq ($(call cc-option-yn,-mdsp2), y)
>> +CFLAGS_signal.o                      = -mdsp2 -DHAVE_AS_DSP
>> +CFLAGS_signal32.o            = -mdsp2 -DHAVE_AS_DSP
>> +CFLAGS_process.o             = -mdsp2 -DHAVE_AS_DSP
>> +CFLAGS_branch.o                      = -mdsp2 -DHAVE_AS_DSP
>> +CFLAGS_ptrace.o                      = -mdsp2 -DHAVE_AS_DSP
>
> Should not this be -mdspr2 here? My GCC man page suggests that.
>
Yes, corrected this.

> By the way, should not we also check that we are building for a
> MIPS32_R2 CPU when checking for -mdsp2?
>
Yes, fixed this also.

> I would simplify this like this:
>
> ifeq ($(CONFIG_CPU_MIPS32),y)
> CFLAGS_DSP = -DHAVE_AS_DSP
> ifeq ($(call cc-option-yn,-mdsp),y)
> CFLAGS_DSP += -mdsp
> endif
> ifeq ($(call cc-option-yn,-mdsp2),y)
> CFLAGS-DSP += -mdsp2
>endif
>
> CFLAGS_signal.o         = $(CFLAGS_DSP)
> ...
> CFLAGS_ptrace.o         = $(CFLAGS_DSP)
> endif
>
> such that the day you can take advantage of a third DSP flavor it's only
> 3 lines worth of Makefile to get it used, and you only have one place
> where you need to change CFLAGS.
>
Good idea, fixed.

I have posted a new patch for review.

-Steve
