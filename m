Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 May 2012 16:56:48 +0200 (CEST)
Received: from dns0.mips.com ([12.201.5.70]:44900 "EHLO dns0.mips.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903605Ab2EWO4l convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 May 2012 16:56:41 +0200
Received: from exchdb01.mips.com (exchdb01.mips.com [192.168.36.67])
        by dns0.mips.com (8.13.8/8.13.8) with ESMTP id q4NEuYZZ017018;
        Wed, 23 May 2012 07:56:34 -0700
Received: from EXCHDB03.MIPS.com ([fe80::6df1:ae84:797e:9076]) by
 exchdb01.mips.com ([fe80::2897:a30d:a923:303%16]) with mapi id
 14.01.0270.001; Wed, 23 May 2012 07:56:30 -0700
From:   "Hill, Steven" <sjhill@mips.com>
To:     Sergei Shtylyov <sshtylyov@mvista.com>
CC:     "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "Yegoshin, Leonid" <yegoshin@mips.com>
Subject: RE: [PATCH v2] Fix race condition with FPU thread task flag during
 context switch.
Thread-Topic: [PATCH v2] Fix race condition with FPU thread task flag during
 context switch.
Thread-Index: AQHNLz9JLhw/TVCakUeXx6K7Tj7kZJbXrH+A///GF7mAAIvegP//i29h
Date:   Wed, 23 May 2012 14:56:30 +0000
Message-ID: <31E06A9FC96CEC488B43B19E2957C1B80114694EDD@exchdb03.mips.com>
References: <1336717702-731-1-git-send-email-sjhill@mips.com>,<20120523100003.GA25531@linux-mips.org>
 <31E06A9FC96CEC488B43B19E2957C1B80114694EB4@exchdb03.mips.com>,<4FBCF9E3.5040702@mvista.com>
In-Reply-To: <4FBCF9E3.5040702@mvista.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.36.79]
x-ems-proccessed: 6LP3oGfGVdcdb8o1aBnt6w==
x-ems-stamp: ElIqoWdFTQWgYdSxkOPGEw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-archive-position: 33440
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@mips.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

How about in the future you stop using reply all?
