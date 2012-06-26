Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jun 2012 20:34:38 +0200 (CEST)
Received: from dns1.mips.com ([12.201.5.69]:57937 "EHLO dns1.mips.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903426Ab2FZSed convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Jun 2012 20:34:33 +0200
Received: from exchdb01.mips.com (exchhub01.mips.com [192.168.36.84])
        by dns1.mips.com (8.13.8/8.13.8) with ESMTP id q5QIYPEW031788
        for <linux-mips@linux-mips.org>; Tue, 26 Jun 2012 11:34:25 -0700
Received: from EXCHDB03.MIPS.com ([fe80::6df1:ae84:797e:9076]) by
 exchhub01.mips.com ([::1]) with mapi id 14.01.0270.001; Tue, 26 Jun 2012
 11:34:34 -0700
From:   "Hill, Steven" <sjhill@mips.com>
To:     Jonas Gorski <jonas.gorski@gmail.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: RE: [PATCH 00/33] Cleanup firmware support across multiple
 platforms.
Thread-Topic: [PATCH 00/33] Cleanup firmware support across multiple
 platforms.
Thread-Index: AQHNU1YNaje9iqMlpUmHl+X0eZPOQ5cNKpwA///Ckbo=
Date:   Tue, 26 Jun 2012 18:34:34 +0000
Message-ID: <31E06A9FC96CEC488B43B19E2957C1B8011469833E@exchdb03.mips.com>
References: <1340685708-14408-1-git-send-email-sjhill@mips.com>,<CAOiHx=kKxZZzJZkRe+SRjFj0JD7yq4=3CmRFbqc6hW_Dhnbz3g@mail.gmail.com>
In-Reply-To: <CAOiHx=kKxZZzJZkRe+SRjFj0JD7yq4=3CmRFbqc6hW_Dhnbz3g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.36.79]
x-ems-proccessed: 6LP3oGfGVdcdb8o1aBnt6w==
x-ems-stamp: OjaQkrz8vQkaR5/j7LdEsw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-archive-position: 33847
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

Jonas,

Did you read the COPYING file of the kernel source tree? I'm pretty sure it states "or later" in the text. Therefore, I believe that my changes to the headers are alright.

-Steve
