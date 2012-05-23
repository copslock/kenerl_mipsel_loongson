Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 May 2012 15:34:19 +0200 (CEST)
Received: from dns0.mips.com ([12.201.5.70]:39281 "EHLO dns0.mips.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903607Ab2EWNeN convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 May 2012 15:34:13 +0200
Received: from exchdb01.mips.com (exchdb01.mips.com [192.168.36.67])
        by dns0.mips.com (8.13.8/8.13.8) with ESMTP id q4NDY670015936;
        Wed, 23 May 2012 06:34:06 -0700
Received: from EXCHDB03.MIPS.com ([fe80::6df1:ae84:797e:9076]) by
 exchdb01.mips.com ([fe80::2897:a30d:a923:303%16]) with mapi id
 14.01.0270.001; Wed, 23 May 2012 06:34:05 -0700
From:   "Hill, Steven" <sjhill@mips.com>
To:     "ralf@linux-mips.org" <ralf@linux-mips.org>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "Yegoshin, Leonid" <yegoshin@mips.com>
Subject: RE: [PATCH v2] Fix race condition with FPU thread task flag during
 context switch.
Thread-Topic: [PATCH v2] Fix race condition with FPU thread task flag during
 context switch.
Thread-Index: AQHNLz9JLhw/TVCakUeXx6K7Tj7kZJbXrH+A///GF7k=
Date:   Wed, 23 May 2012 13:34:04 +0000
Message-ID: <31E06A9FC96CEC488B43B19E2957C1B80114694EB4@exchdb03.mips.com>
References: <1336717702-731-1-git-send-email-sjhill@mips.com>,<20120523100003.GA25531@linux-mips.org>
In-Reply-To: <20120523100003.GA25531@linux-mips.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.36.79]
x-ems-proccessed: 6LP3oGfGVdcdb8o1aBnt6w==
x-ems-stamp: Y9B9Da9iBk6+DKC9WI1xrA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-archive-position: 33437
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@mips.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Leonid is the author of this patch. The r2300_switch.S is easy enough to fix, but octeon_switch.S is nothing like the others, so someone else will have to fix that.

-Steve
