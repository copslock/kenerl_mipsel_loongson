Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Aug 2013 02:43:32 +0200 (CEST)
Received: from mms3.broadcom.com ([216.31.210.19]:1066 "EHLO mms3.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6853184Ab3HVAn3tTQQx convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 22 Aug 2013 02:43:29 +0200
Received: from [10.9.208.55] by mms3.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Wed, 21 Aug 2013 17:33:01 -0700
X-Server-Uuid: B86B6450-0931-4310-942E-F00ED04CA7AF
Received: from SJEXCHCAS04.corp.ad.broadcom.com (10.16.203.10) by
 IRVEXCHCAS07.corp.ad.broadcom.com (10.9.208.55) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Wed, 21 Aug 2013 17:43:11 -0700
Received: from SJEXCHMB12.corp.ad.broadcom.com (
 [fe80::bc15:c1e1:c29a:36f7]) by SJEXCHCAS04.corp.ad.broadcom.com (
 [::1]) with mapi id 14.01.0438.000; Wed, 21 Aug 2013 17:43:11 -0700
From:   "Sherman Yin" <syin@broadcom.com>
To:     "Linus Walleij" <linus.walleij@linaro.org>
cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "matt.porter@linaro.org" <matt.porter@linaro.org>,
        "Christian Daudt" <csd@broadcom.com>,
        "Markus Mayer" <mmayer@broadcom.com>,
        "James Hogan" <james.hogan@imgtec.com>
Subject: RE: [PATCH] pinctrl: Pass all configs to driver on
 pin_config_set()
Thread-Topic: [PATCH] pinctrl: Pass all configs to driver on
 pin_config_set()
Thread-Index: AQHOmgj9JDWSFPXUuUqlaxMrv7HnmJmguMIA//+yQ0A=
Date:   Thu, 22 Aug 2013 00:43:10 +0000
Message-ID: <051069C10411E24D9749790C498526FA1BDD9D27@SJEXCHMB12.corp.ad.broadcom.com>
References: <1376606573-15093-1-git-send-email-syin@broadcom.com>
 <CACRpkdaUacAbLd+i4Y=DXv=aSaUwBSz6-icPV9SVjxZkUjheww@mail.gmail.com>
In-Reply-To: <CACRpkdaUacAbLd+i4Y=DXv=aSaUwBSz6-icPV9SVjxZkUjheww@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.16.203.100]
MIME-Version: 1.0
X-WSS-ID: 7E0B83B72L876757561-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-Path: <syin@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37637
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: syin@broadcom.com
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

Hi Linus,

>Right now this does not apply to my "devel" branch, so I'd like you
>to rebase on that right now. (This is what will go into v3.12).
>
>This is also late in the development cycle so I believe this is going to
>be v3.13 material unless there are more release candidates.
>
>You can also hold on until after the v3.12 merge window and then
>rebase it and we'll merge it as a first patch in the v3.13 development
>cycle.
>
>What do you say?

You mean the "devel" branch in this tree, right?  Please let me know 
if you're talking about another tree/branch.

git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git

I cherry-picked my commit on top of devel, and there was just a simple
conflict in pinctrl-sunxi.c.  It's easy enough to fix, so I'll send out v2 
that's based on "devel" instead of rc6 anyway.  I can just do another
rebase after v3.12 merge window if needed. 

Thanks!
Sherman
