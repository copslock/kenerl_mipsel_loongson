Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 May 2012 17:38:36 +0200 (CEST)
Received: from dns0.mips.com ([12.201.5.70]:60264 "EHLO dns0.mips.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903564Ab2EUPic convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 21 May 2012 17:38:32 +0200
Received: from exchdb01.mips.com (exchhub01.mips.com [192.168.36.84])
        by dns0.mips.com (8.13.8/8.13.8) with ESMTP id q4LFcOVn003547;
        Mon, 21 May 2012 08:38:25 -0700
Received: from EXCHDB03.MIPS.com ([fe80::6df1:ae84:797e:9076]) by
 exchhub01.mips.com ([::1]) with mapi id 14.01.0270.001; Mon, 21 May 2012
 08:38:22 -0700
From:   "Hill, Steven" <sjhill@mips.com>
To:     Sergei Shtylyov <sshtylyov@mvista.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: RE: [PATCH v2,1/5] MIPS: Add support for the 1074K core.
Thread-Topic: [PATCH v2,1/5] MIPS: Add support for the 1074K core.
Thread-Index: AQHNLvHbUDGxC7VKF0eKSmUebROp2pbGh5gAgA3pUkc=
Date:   Mon, 21 May 2012 15:38:20 +0000
Message-ID: <31E06A9FC96CEC488B43B19E2957C1B80114694AD3@exchdb03.mips.com>
References: <1336684439-25109-1-git-send-email-sjhill@mips.com>,<4FAE52F4.6020301@mvista.com>
In-Reply-To: <4FAE52F4.6020301@mvista.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.36.79]
x-ems-proccessed: 6LP3oGfGVdcdb8o1aBnt6w==
x-ems-stamp: gao59MdsbIPSDiAmHmSxoA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-archive-position: 33403
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@mips.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

I have cleaned up this patch for 1074K change only. The code that is refactored for 74K is part of the 1074K support. 1074K is a multi-cored 74K and thus the changes are necessary.

-Steve
