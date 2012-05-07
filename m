Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 May 2012 22:16:48 +0200 (CEST)
Received: from dns0.mips.com ([12.201.5.70]:53270 "EHLO dns0.mips.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903682Ab2EGUQo convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 May 2012 22:16:44 +0200
Received: from exchdb01.mips.com (exchdb01.mips.com [192.168.36.67])
        by dns0.mips.com (8.13.8/8.13.8) with ESMTP id q47KGaaL011761;
        Mon, 7 May 2012 13:16:36 -0700
Received: from EXCHDB03.MIPS.com ([fe80::6df1:ae84:797e:9076]) by
 exchdb01.mips.com ([fe80::2897:a30d:a923:303%16]) with mapi id
 14.01.0270.001; Mon, 7 May 2012 13:16:31 -0700
From:   "Hill, Steven" <sjhill@mips.com>
To:     Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "Leung, Douglas" <douglas@mips.com>,
        "Dearman, Chris" <chris@mips.com>
Subject: RE: [PATCH 01/10] MIPS: Add core files for MIPS SEAD-3 development
 platform.
Thread-Topic: [PATCH 01/10] MIPS: Add core files for MIPS SEAD-3 development
 platform.
Thread-Index: AQHNFN5TXaIyKURn50SCHT0BxYKwcJaTtvkAgCs4fmA=
Date:   Mon, 7 May 2012 20:16:31 +0000
Message-ID: <31E06A9FC96CEC488B43B19E2957C1B8011469208F@exchdb03.mips.com>
References: <1333817315-30091-1-git-send-email-sjhill@mips.com>
 <1333817315-30091-2-git-send-email-sjhill@mips.com>,<4F8386C8.9020401@renesas.com>
In-Reply-To: <4F8386C8.9020401@renesas.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.36.79]
x-ems-proccessed: 6LP3oGfGVdcdb8o1aBnt6w==
x-ems-stamp: N72dU3eGhiU9Dlrmtg/aPA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-archive-position: 33180
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@mips.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Kuribayashi-san,

I will certainly remove CONFIG_CPU_HAS_LLSC, thank you. I attempted to enable 'cpu_has_clo_clz' for SEAD-3, but it breaks my microMIPS-only kernel builds. Specifically, since microMIPS LL/SC instructions do not have 16-bit address offsets, in the '__cmpxchg_asm' macro function I get constraint errors because then the assembler has to use the %LO register in order to calculate the offset address. I am going to hold off on enabling the option until after the 3.5 release and then revisit for a solution. Thank you.

-Steve
