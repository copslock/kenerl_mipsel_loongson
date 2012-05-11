Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 May 2012 19:45:24 +0200 (CEST)
Received: from dns0.mips.com ([12.201.5.70]:38415 "EHLO dns0.mips.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903659Ab2EKRpR convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 11 May 2012 19:45:17 +0200
Received: from exchdb01.mips.com (exchhub01.mips.com [192.168.36.84])
        by dns0.mips.com (8.13.8/8.13.8) with ESMTP id q4BHj8WJ017678;
        Fri, 11 May 2012 10:45:10 -0700
Received: from EXCHDB03.MIPS.com ([fe80::6df1:ae84:797e:9076]) by
 exchhub01.mips.com ([::1]) with mapi id 14.01.0270.001; Fri, 11 May 2012
 10:45:05 -0700
From:   "Yegoshin, Leonid" <yegoshin@mips.com>
To:     Sergei Shtylyov <sshtylyov@mvista.com>
CC:     "Hill, Steven" <sjhill@mips.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>
Subject: Re: [PATCH v2] Add MIPS64R2 core support.
Thread-Topic: [PATCH v2] Add MIPS64R2 core support.
Thread-Index: AQHNLz96CllJsX0FZEaOw1mYtE0YCZbFTREA//+MbJCAAHbZAP//jMPc
Date:   Fri, 11 May 2012 17:45:04 +0000
Message-ID: <j9ltxtmuep0qhf4mgqhj4du5.1336758301121@email.android.com>
References: <1336717784-853-1-git-send-email-sjhill@mips.com>,<4FAD4B9E.70803@mvista.com>
 <ajcsenx2bmwqyi5629d3ywgh.1336757525517@email.android.com>,<4FAD4E5C.9040607@mvista.com>
In-Reply-To: <4FAD4E5C.9040607@mvista.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ems-proccessed: 6LP3oGfGVdcdb8o1aBnt6w==
x-ems-stamp: DpYiQjki0//C18NS6rBfgQ==
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
MIME-Version: 1.0
X-archive-position: 33266
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yegoshin@mips.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

I don't see any advantage in separation of it.


Sergei Shtylyov <sshtylyov@mvista.com> wrote:


Hello.

On 05/11/2012 09:32 PM, Yegoshin, Leonid wrote:

> Not exactly - it adds 64R2 support in Malta, plus small verification that build kernel could run 32bit binaries.

> I don't think it has sense to multiply patches here, there is no sense to have this separated.

> 5KEc is just test-bed.

    Well, rule of thumb is do one thing per patch. You do three. All that
without proper description.

WBR, Sergei
