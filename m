Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 May 2012 22:38:31 +0200 (CEST)
Received: from dns0.mips.com ([12.201.5.70]:57786 "EHLO dns0.mips.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903640Ab2EHUiZ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 May 2012 22:38:25 +0200
Received: from exchdb01.mips.com (exchhub01.mips.com [192.168.36.84])
        by dns0.mips.com (8.13.8/8.13.8) with ESMTP id q48KcFWA030704;
        Tue, 8 May 2012 13:38:16 -0700
Received: from EXCHDB03.MIPS.com ([fe80::6df1:ae84:797e:9076]) by
 exchhub01.mips.com ([::1]) with mapi id 14.01.0270.001; Tue, 8 May 2012
 13:38:13 -0700
From:   "Hill, Steven" <sjhill@mips.com>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
CC:     Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>
Subject: RE: [PATCH 01/10] MIPS: Add core files for MIPS SEAD-3 development
 platform.
Thread-Topic: [PATCH 01/10] MIPS: Add core files for MIPS SEAD-3 development
 platform.
Thread-Index: AQHNFN5TXaIyKURn50SCHT0BxYKwcJaTtvkAgCs4fmCAAXRPAIAAJgYC
Date:   Tue, 8 May 2012 20:38:12 +0000
Message-ID: <31E06A9FC96CEC488B43B19E2957C1B80114692157@exchdb03.mips.com>
References: <1333817315-30091-1-git-send-email-sjhill@mips.com>
 <1333817315-30091-2-git-send-email-sjhill@mips.com>,<4F8386C8.9020401@renesas.com>
 <31E06A9FC96CEC488B43B19E2957C1B8011469208F@exchdb03.mips.com>,<alpine.LFD.2.00.1205080945120.3701@eddie.linux-mips.org>
In-Reply-To: <alpine.LFD.2.00.1205080945120.3701@eddie.linux-mips.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.36.79]
x-ems-proccessed: 6LP3oGfGVdcdb8o1aBnt6w==
x-ems-stamp: uLjfLfQ3rFtUcXiijDWEXw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-archive-position: 33221
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@mips.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

I thought the "YC" constraint was only present in CodeSourcery toolchains, correct? If so, then that levies the requirement for a vendor-specific toolchain to build a microMIPS kernel. I do not consider that palpable. If it is not CodeSourcery-specific, then I will certainly try it out.
