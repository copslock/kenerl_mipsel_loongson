Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 May 2012 20:23:22 +0200 (CEST)
Received: from dns0.mips.com ([12.201.5.70]:52773 "EHLO dns0.mips.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903659Ab2EKSXQ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 11 May 2012 20:23:16 +0200
Received: from exchdb01.mips.com (exchhub01.mips.com [192.168.36.84])
        by dns0.mips.com (8.13.8/8.13.8) with ESMTP id q4BINAWE018255;
        Fri, 11 May 2012 11:23:10 -0700
Received: from EXCHDB03.MIPS.com ([fe80::6df1:ae84:797e:9076]) by
 exchhub01.mips.com ([::1]) with mapi id 14.01.0270.001; Fri, 11 May 2012
 11:23:08 -0700
From:   "Hill, Steven" <sjhill@mips.com>
To:     Sergei Shtylyov <sshtylyov@mvista.com>,
        "Yegoshin, Leonid" <yegoshin@mips.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: RE: [PATCH v2] Add MIPS64R2 core support.
Thread-Topic: [PATCH v2] Add MIPS64R2 core support.
Thread-Index: AQHNLz96rGOEHILJFUOIh5XX5Dob7ZbFTREAgAABxICAAAGBAIAAAhsAgAAFtID//4yRoA==
Date:   Fri, 11 May 2012 18:23:07 +0000
Message-ID: <31E06A9FC96CEC488B43B19E2957C1B80114693470@exchdb03.mips.com>
References: <1336717784-853-1-git-send-email-sjhill@mips.com>,<4FAD4B9E.70803@mvista.com>
 <ajcsenx2bmwqyi5629d3ywgh.1336757525517@email.android.com>,<4FAD4E5C.9040607@mvista.com>
 <j9ltxtmuep0qhf4mgqhj4du5.1336758301121@email.android.com>,<4FAD54E9.6030102@mvista.com>
In-Reply-To: <4FAD54E9.6030102@mvista.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.36.79]
x-ems-proccessed: 6LP3oGfGVdcdb8o1aBnt6w==
x-ems-stamp: MH7N7RUJ/kEgx0ZVbu5vTg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-archive-position: 33269
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@mips.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Sergei,

Stop copying Ralf. Copying the mailing list is sufficient.

Leonid,

Could you please write a couple of sentences describing the 6 lines that you added in 'arch/mips/Kconfig' ? We can then add that with the sentence "Add support for MIPS64R2 on the Malta platform." That will be sufficient and prevents having to split this patch up. Just email it to me internally and I will repost the patch.

-Steve
