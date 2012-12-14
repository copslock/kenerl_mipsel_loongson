Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Dec 2012 06:03:13 +0100 (CET)
Received: from dns1.mips.com ([12.201.5.69]:46322 "EHLO dns1.mips.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6816743Ab2LNFDMk-vWM convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 14 Dec 2012 06:03:12 +0100
Received: from mailgate1.mips.com (mailgate1.mips.com [12.201.5.111])
        by dns1.mips.com (8.13.8/8.13.8) with ESMTP id qBE534Fp016489;
        Thu, 13 Dec 2012 21:03:04 -0800
X-WSS-ID: 0MF08P4-01-2AY-02
X-M-MSG: 
Received: from exchdb01.mips.com (unknown [192.168.36.84])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mailgate1.mips.com (Postfix) with ESMTP id 2A72D36465D;
        Thu, 13 Dec 2012 21:03:03 -0800 (PST)
Received: from EXCHDB03.MIPS.com ([fe80::6df1:ae84:797e:9076]) by
 exchhub01.mips.com ([::1]) with mapi id 14.01.0270.001; Thu, 13 Dec 2012
 21:03:00 -0800
From:   "Hill, Steven" <sjhill@mips.com>
To:     Florian Fainelli <florian@openwrt.org>,
        Lars-Peter Clausen <lars@metafoo.de>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>
Subject: RE: [PATCH] OF: MIPS: sead3: Implement OF support.
Thread-Topic: [PATCH] OF: MIPS: sead3: Implement OF support.
Thread-Index: AQHN1DnSWGjTUvhf40CMe1gF/gDbQ5gVx+UAgAAGqwCAAADlAIAB+Dr+
Date:   Fri, 14 Dec 2012 05:02:58 +0000
Message-ID: <31E06A9FC96CEC488B43B19E2957C1B801146AB302@exchdb03.mips.com>
References: <1354857297-28863-1-git-send-email-sjhill@mips.com>
 <50C894D4.4090008@openwrt.org>
 <50C89A6C.705@metafoo.de>,<50C89B2C.1070903@openwrt.org>
In-Reply-To: <50C89B2C.1070903@openwrt.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.36.79]
x-ems-proccessed: 6LP3oGfGVdcdb8o1aBnt6w==
x-ems-stamp: 1eWDm6UTv4bHtGJs39amCg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-archive-position: 35286
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

>
> But in anyway the patch should also add documentation under
> Documentation/devicetree/bindings describing the binding.
>
There is not much in the SEAD-3 .dts file and I see zero documentation for Lantiq or Netlogic. I am skipping adding anything in the Documentation directory.
