Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jun 2012 20:52:19 +0200 (CEST)
Received: from dns1.mips.com ([12.201.5.69]:41105 "EHLO dns1.mips.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903482Ab2FZSwP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Jun 2012 20:52:15 +0200
Received: from exchdb01.mips.com (exchdb01.mips.com [192.168.36.67])
        by dns1.mips.com (8.13.8/8.13.8) with ESMTP id q5QIq8lt032221
        for <linux-mips@linux-mips.org>; Tue, 26 Jun 2012 11:52:09 -0700
Received: from EXCHDB03.MIPS.com ([fe80::6df1:ae84:797e:9076]) by
 exchdb01.mips.com ([fe80::2897:a30d:a923:303%16]) with mapi id
 14.01.0270.001; Tue, 26 Jun 2012 11:52:14 -0700
From:   "Hill, Steven" <sjhill@mips.com>
To:     Jonas Gorski <jonas.gorski@gmail.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: RE: [PATCH 00/33] Cleanup firmware support across multiple
 platforms.
Thread-Topic: [PATCH 00/33] Cleanup firmware support across multiple
 platforms.
Thread-Index: AQHNU1YNaje9iqMlpUmHl+X0eZPOQ5cNKpwA///CkbqAAHnpgP//i2tq
Date:   Tue, 26 Jun 2012 18:52:13 +0000
Message-ID: <31E06A9FC96CEC488B43B19E2957C1B8011469835D@exchdb03.mips.com>
References: <1340685708-14408-1-git-send-email-sjhill@mips.com>
 <CAOiHx=kKxZZzJZkRe+SRjFj0JD7yq4=3CmRFbqc6hW_Dhnbz3g@mail.gmail.com>
 <31E06A9FC96CEC488B43B19E2957C1B8011469833E@exchdb03.mips.com>,<CAOiHx==e0ZsJy+=KAkaCzNYvjbsnY+mmjNX8oHhHPstA_WZCKQ@mail.gmail.com>
In-Reply-To: <CAOiHx==e0ZsJy+=KAkaCzNYvjbsnY+mmjNX8oHhHPstA_WZCKQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.36.79]
x-ems-proccessed: 6LP3oGfGVdcdb8o1aBnt6w==
x-ems-stamp: DYfhZYgLUgJ77x+8WUa5Ww==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-archive-position: 33852
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

I've asked Ralf if he will take 01/33 which is adds the new functions to the firmware library. I'll then drop all the other patches and if people want to use the common code, they're welcome to. Thanks for all the comments.

-Steve
