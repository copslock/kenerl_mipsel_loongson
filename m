Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Apr 2012 06:36:54 +0200 (CEST)
Received: from dns0.mips.com ([12.201.5.70]:51023 "EHLO dns0.mips.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903638Ab2DJEgr convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 10 Apr 2012 06:36:47 +0200
Received: from exchdb01.mips.com (exchhub01.mips.com [192.168.36.84])
        by dns0.mips.com (8.13.8/8.13.8) with ESMTP id q3A4aboX022024;
        Mon, 9 Apr 2012 21:36:38 -0700
Received: from EXCHDB03.MIPS.com ([fe80::6df1:ae84:797e:9076]) by
 exchhub01.mips.com ([::1]) with mapi id 14.01.0270.001; Mon, 9 Apr 2012
 21:36:33 -0700
From:   "Yegoshin, Leonid" <yegoshin@mips.com>
To:     Kevin Cernekee <cernekee@gmail.com>
CC:     "Hill, Steven" <sjhill@mips.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>
Subject: Re: [PATCH] Revert fixrange_init() limiting to the FIXMAP region.
Thread-Topic: [PATCH] Revert fixrange_init() limiting to the FIXMAP region.
Thread-Index: AQHNFmvjyxzTeoUc7kiyOTfHHJfdRZaT0n6A//+Mh9eAAIXyAP//lTTZ
Date:   Tue, 10 Apr 2012 04:36:32 +0000
Message-ID: <BE816C43-97B1-4D00-A0F7-FE56B7DA8D47@mips.com>
References: <1333988075-1289-1-git-send-email-sjhill@mips.com>
        <CAJiQ=7A-Bmn9ULb3+YXaXgYTKiHZm1Dbsd-NQBjeL0TLjKAafQ@mail.gmail.com>
        <3cvb8sm16wfjrw35b2tyxnfu.1334026758779@email.android.com>,<CAJiQ=7Dm0JBzxbL_ueZvvLWAQZPMY_swy0icVj_od95t3V3VOQ@mail.gmail.com>
In-Reply-To: <CAJiQ=7Dm0JBzxbL_ueZvvLWAQZPMY_swy0icVj_od95t3V3VOQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ems-proccessed: 6LP3oGfGVdcdb8o1aBnt6w==
x-ems-stamp: l4oyRUbpfxn880ZBET3WlA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-archive-position: 32920
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yegoshin@mips.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Yes, MIPS HIGHMEM patch for cache aliasing systems (published today) works beyond PKMAP region - extended kmap_atomic.

- Leonid.

On Apr 9, 2012, at 8:58 PM, "Kevin Cernekee" <cernekee@gmail.com> wrote:

> On Mon, Apr 9, 2012 at 7:59 PM, Yegoshin, Leonid <yegoshin@mips.com> wrote:
>> Sorry, it was a couple of months ago while I worked on HIGHMEM with cache aliasing. I got a soak test failure and rollback of this patch helped.
> 
> Is it possible that HIGHMEM / kmap was using pages above the PKMAP
> range, and the bug was masked by re-enabling the old behavior (create
> PMDs all the way up to the top of the virtual address space)?
> 
>> Besides that it is clearly wrong to add unmodified memory area length to aligned start address of that memory. It seems easy to fix but I hadn't time.
> 
> On the pre-464fd83e implementation, that would have been a problem
> because of the "vaddr != end" terminating condition.
> 
> On the post-464fd83e implementation, it should be fine because we are
> checking for "vaddr < end" instead.  This means we should get just
> enough PMDs to cover the requested range.
> 
> I just checked one of my systems and it is calling
> fixrange_init(0xff000000, 0xff039000, pgd_base).  This creates a
> single PMD covering a 4MB range, as expected.
