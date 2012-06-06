Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Jun 2012 04:18:26 +0200 (CEST)
Received: from dns0.mips.com ([12.201.5.70]:35384 "EHLO dns0.mips.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1901351Ab2FFCSW convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 6 Jun 2012 04:18:22 +0200
Received: from exchdb01.mips.com (exchhub01.mips.com [192.168.36.84])
        by dns0.mips.com (8.13.8/8.13.8) with ESMTP id q562IFZo032542;
        Tue, 5 Jun 2012 19:18:15 -0700
Received: from EXCHDB03.MIPS.com ([fe80::6df1:ae84:797e:9076]) by
 exchhub01.mips.com ([::1]) with mapi id 14.01.0270.001; Tue, 5 Jun 2012
 19:18:11 -0700
From:   "Hill, Steven" <sjhill@mips.com>
To:     Yuasa Yoichi <yuasa@linux-mips.org>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: RE: [PATCH 35/35] MIPS: vr41xx: Cleanup files effected by firmware
 changes.
Thread-Topic: [PATCH 35/35] MIPS: vr41xx: Cleanup files effected by firmware
 changes.
Thread-Index: AQHNQ2Uqk3LPmJqjHket7SHElRInu5btAs+A//+K8wc=
Date:   Wed, 6 Jun 2012 02:18:11 +0000
Message-ID: <31E06A9FC96CEC488B43B19E2957C1B801146957B7@exchdb03.mips.com>
References: <1338931179-9611-1-git-send-email-sjhill@mips.com>
        <1338931179-9611-36-git-send-email-sjhill@mips.com>,<CACBHAewrmejSTYdx5A95GqHmAt8ovBTzedE2w+LCE9aTf3tQuw@mail.gmail.com>
In-Reply-To: <CACBHAewrmejSTYdx5A95GqHmAt8ovBTzedE2w+LCE9aTf3tQuw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.36.79]
x-ems-proccessed: 6LP3oGfGVdcdb8o1aBnt6w==
x-ems-stamp: DyBfI2dQs/j8YioUYJQPww==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-archive-position: 33552
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

Yoichi,

How are those include files required? I built a complete vr41xx kernel and that file did not produce any errors when being compiled with those headers removed. Did you try building a kernel with this patch?

-Steve
