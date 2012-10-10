Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Oct 2012 16:37:16 +0200 (CEST)
Received: from dns1.mips.com ([12.201.5.69]:52425 "EHLO dns1.mips.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6872754Ab2JJOhBYPlTC convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Oct 2012 16:37:01 +0200
Received: from mailgate1.mips.com (mailgate1.mips.com [12.201.5.111])
        by dns1.mips.com (8.13.8/8.13.8) with ESMTP id q9AEaquj009169;
        Wed, 10 Oct 2012 07:36:53 -0700
X-WSS-ID: 0MBOLXD-01-14Y-02
X-M-MSG: 
Received: from exchdb01.mips.com (unknown [192.168.36.67])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mailgate1.mips.com (Postfix) with ESMTP id 20E5B364666;
        Wed, 10 Oct 2012 07:36:48 -0700 (PDT)
Received: from EXCHDB03.MIPS.com ([fe80::6df1:ae84:797e:9076]) by
 exchdb01.mips.com ([fe80::2897:a30d:a923:303%16]) with mapi id
 14.01.0270.001; Wed, 10 Oct 2012 07:36:45 -0700
From:   "Hill, Steven" <sjhill@mips.com>
To:     Suprasad Mutalik Desai <suprasad.desai@gmail.com>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "Dearman, Chris" <chris@mips.com>,
        John Crispin <blogic@openwrt.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: RE: [PATCH] MIPS: kspd: Remove kspd support.
Thread-Topic: [PATCH] MIPS: kspd: Remove kspd support.
Thread-Index: AQHNpmxAeixNgwt+XE+io4KwpbtWYZeynPcAgAAYkgD//+ajzQ==
Date:   Wed, 10 Oct 2012 14:36:44 +0000
Message-ID: <31E06A9FC96CEC488B43B19E2957C1B801146A3B97@exchdb03.mips.com>
References: <1349821203-23083-1-git-send-email-sjhill@mips.com>
        <20121010073826.GB6740@linux-mips.org>,<CAJMXqXYQC6L3iS92p9R7FuQkuwJWN7SEZy2+E_v-0UKTp7SaSw@mail.gmail.com>
In-Reply-To: <CAJMXqXYQC6L3iS92p9R7FuQkuwJWN7SEZy2+E_v-0UKTp7SaSw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.36.79]
x-ems-proccessed: 6LP3oGfGVdcdb8o1aBnt6w==
x-ems-stamp: uGo2j33ClXfeKm13powxRQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-archive-position: 34673
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

Hello Suprasad.

Certainly the AP/SP API can be left in. We wish to remove the kspd support. Do you or anyone on your team use kspd? Thanks.

-Steve
