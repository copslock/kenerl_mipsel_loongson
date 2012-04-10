Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Apr 2012 04:59:42 +0200 (CEST)
Received: from dns0.mips.com ([12.201.5.70]:38888 "EHLO dns0.mips.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903635Ab2DJC7f convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 10 Apr 2012 04:59:35 +0200
Received: from exchdb01.mips.com (exchdb01.mips.com [192.168.36.67])
        by dns0.mips.com (8.13.8/8.13.8) with ESMTP id q3A2xQYv020812;
        Mon, 9 Apr 2012 19:59:26 -0700
Received: from EXCHDB03.MIPS.com ([fe80::6df1:ae84:797e:9076]) by
 exchdb01.mips.com ([::1]) with mapi id 14.01.0270.001; Mon, 9 Apr 2012
 19:59:24 -0700
From:   "Yegoshin, Leonid" <yegoshin@mips.com>
To:     Kevin Cernekee <cernekee@gmail.com>
CC:     "Hill, Steven" <sjhill@mips.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>
Subject: Re: [PATCH] Revert fixrange_init() limiting to the FIXMAP region.
Thread-Topic: [PATCH] Revert fixrange_init() limiting to the FIXMAP region.
Thread-Index: AQHNFmvjyxzTeoUc7kiyOTfHHJfdRZaT0n6A//+Mh9c=
Date:   Tue, 10 Apr 2012 02:59:23 +0000
Message-ID: <3cvb8sm16wfjrw35b2tyxnfu.1334026758779@email.android.com>
References: <1333988075-1289-1-git-send-email-sjhill@mips.com>,<CAJiQ=7A-Bmn9ULb3+YXaXgYTKiHZm1Dbsd-NQBjeL0TLjKAafQ@mail.gmail.com>
In-Reply-To: <CAJiQ=7A-Bmn9ULb3+YXaXgYTKiHZm1Dbsd-NQBjeL0TLjKAafQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ems-proccessed: 6LP3oGfGVdcdb8o1aBnt6w==
x-ems-stamp: I/kRmqYLz3SozM+xsDoljQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-archive-position: 32918
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yegoshin@mips.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Sorry, it was a couple of months ago while I worked on HIGHMEM with cache aliasing. I got a soak test failure and rollback of this patch helped. Besides that it is clearly wrong to add unmodified memory area length to aligned start address of that memory. It seems easy to fix but I hadn't time.

- Leonid.


Kevin Cernekee <cernekee@gmail.com> wrote:


On Mon, Apr 9, 2012 at 9:14 AM, Steven J. Hill <sjhill@mips.com> wrote:
> This patch reverts 464fd83e841a16f4ea1325b33eb08170ef5cd1f4 which
> may not take calculate the right length while taking into account
> page table alignment by PMD.

If the logic is incorrect, I'd like to fix it.  Would you be able to
provide a test case that breaks the current head of tree?

Thanks.
