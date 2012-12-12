Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Dec 2012 17:57:51 +0100 (CET)
Received: from dns1.mips.com ([12.201.5.69]:44609 "EHLO dns1.mips.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823668Ab2LLQpdQrdFY convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 Dec 2012 17:45:33 +0100
Received: from mailgate1.mips.com (mailgate1.mips.com [12.201.5.111])
        by dns1.mips.com (8.13.8/8.13.8) with ESMTP id qBCGjPo9007815;
        Wed, 12 Dec 2012 08:45:25 -0800
X-WSS-ID: 0MEXFVP-01-17B-02
X-M-MSG: 
Received: from exchdb01.mips.com (unknown [192.168.36.67])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mailgate1.mips.com (Postfix) with ESMTP id 26838364636;
        Wed, 12 Dec 2012 08:45:24 -0800 (PST)
Received: from EXCHDB03.MIPS.com ([fe80::6df1:ae84:797e:9076]) by
 exchdb01.mips.com ([fe80::2897:a30d:a923:303%16]) with mapi id
 14.01.0270.001; Wed, 12 Dec 2012 08:45:21 -0800
From:   "Hill, Steven" <sjhill@mips.com>
To:     Florian Fainelli <florian@openwrt.org>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>
Subject: RE: [PATCH] MIPS: Make CP0 config registers readable via sysfs.
Thread-Topic: [PATCH] MIPS: Make CP0 config registers readable via sysfs.
Thread-Index: AQHN1DwdFeowWwCT60yFwo2HgIhlxJgVxuWA//+glV4=
Date:   Wed, 12 Dec 2012 16:45:20 +0000
Message-ID: <31E06A9FC96CEC488B43B19E2957C1B801146AA787@exchdb03.mips.com>
References: <1354858280-29576-1-git-send-email-sjhill@mips.com>,<50C89401.70705@openwrt.org>
In-Reply-To: <50C89401.70705@openwrt.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.36.79]
x-ems-proccessed: 6LP3oGfGVdcdb8o1aBnt6w==
x-ems-stamp: mFQmxRa3Uy4dygvk5+9FNg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-archive-position: 35269
X-Approved-By: ralf@linux-mips.org
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

By golly you're right! I can use a macro for the other code block. Thanks.
