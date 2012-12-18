Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Dec 2012 19:39:34 +0100 (CET)
Received: from dns1.mips.com ([12.201.5.69]:51561 "EHLO dns1.mips.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6817293Ab2LRSjdK8WDy convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 18 Dec 2012 19:39:33 +0100
Received: from mailgate1.mips.com (mailgate1.mips.com [12.201.5.111])
        by dns1.mips.com (8.13.8/8.13.8) with ESMTP id qBIIdPTv011295;
        Tue, 18 Dec 2012 10:39:25 -0800
X-WSS-ID: 0MF8P5O-01-06C-02
X-M-MSG: 
Received: from exchdb01.mips.com (unknown [192.168.36.84])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mailgate1.mips.com (Postfix) with ESMTP id 2962D364669;
        Tue, 18 Dec 2012 10:39:24 -0800 (PST)
Received: from EXCHDB03.MIPS.com ([fe80::6df1:ae84:797e:9076]) by
 exchhub01.mips.com ([::1]) with mapi id 14.02.0247.003; Tue, 18 Dec 2012
 10:39:24 -0800
From:   "Hill, Steven" <sjhill@mips.com>
To:     David Daney <ddaney.cavm@gmail.com>,
        Jayachandran C <jchandra@broadcom.com>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: RE: [PATCH] Revert "MIPS: Optimise TLB handlers for MIPS32/64 R2
 cores."
Thread-Topic: [PATCH] Revert "MIPS: Optimise TLB handlers for MIPS32/64 R2
 cores."
Thread-Index: AQHN3QUIS1qOm5BxXUKcek/ScPwLU5gfZrMA//98wuU=
Date:   Tue, 18 Dec 2012 18:39:23 +0000
Message-ID: <31E06A9FC96CEC488B43B19E2957C1B801146AB823@exchdb03.mips.com>
References: <1355824203-18912-1-git-send-email-jchandra@broadcom.com>,<50D0B588.2070906@gmail.com>
In-Reply-To: <50D0B588.2070906@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.4.41]
x-ems-proccessed: 6LP3oGfGVdcdb8o1aBnt6w==
x-ems-stamp: aQhcYonXhPxqYobTiKZC9g==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-archive-position: 35309
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

I would ask that we hold off on the revert patch as I will have the 64-bit fix today in the next 2 hours. Thank you.

-Steve
