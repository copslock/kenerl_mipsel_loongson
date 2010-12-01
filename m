Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Dec 2010 17:06:45 +0100 (CET)
Received: from mail96.messagelabs.com ([216.82.254.19]:47330 "EHLO
        mail96.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493015Ab0LAQGm convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 1 Dec 2010 17:06:42 +0100
X-VirusChecked: Checked
X-Env-Sender: Viral.Mehta@lntinfotech.com
X-Msg-Ref: server-12.tower-96.messagelabs.com!1291219592!71160213!1
X-StarScan-Version: 6.2.9; banners=lntinfotech.com,-,-
X-Originating-IP: [203.199.118.205]
Received: (qmail 30912 invoked from network); 1 Dec 2010 16:06:35 -0000
Received: from unknown (HELO VSHINMSHTCAS01.vshodc.lntinfotech.com) (203.199.118.205)
  by server-12.tower-96.messagelabs.com with AES128-SHA encrypted SMTP; 1 Dec 2010 16:06:35 -0000
Received: from vshinmsmbx01.vshodc.lntinfotech.com ([172.17.24.117]) by
 VSHINMSHTCAS01.vshodc.lntinfotech.com ([172.17.24.112]) with mapi; Wed, 1 Dec
 2010 21:36:31 +0530
From:   Viral Mehta <Viral.Mehta@lntinfotech.com>
To:     naveen yadav <yad.naveen@gmail.com>,
        "kernelnewbies@nl.linux.org" <kernelnewbies@nl.linux.org>,
        "linux-arm-kernel-request@lists.arm.linux.org.uk" 
        <linux-arm-kernel-request@lists.arm.linux.org.uk>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Date:   Wed, 1 Dec 2010 21:36:31 +0530
Subject: RE: Change of Default kernel page size i.e 4KB
Thread-Topic: Change of Default kernel page size i.e 4KB
Thread-Index: AcuRMnA5Kidnzr40Rg2OCnrUNQ3tNAAPF7wM
Message-ID: <D69C90565D53114396BF743585AF5A09122E61E8C3@VSHINMSMBX01.vshodc.lntinfotech.com>
References: <AANLkTi=4gtEC9fZyvc9g6uHecvjPrr0dDc==KsDOvq2Q@mail.gmail.com>
In-Reply-To: <AANLkTi=4gtEC9fZyvc9g6uHecvjPrr0dDc==KsDOvq2Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Return-Path: <Viral.Mehta@lntinfotech.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28583
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Viral.Mehta@lntinfotech.com
Precedence: bulk
X-list: linux-mips

________________________________________
From: kernelnewbies-bounce@nl.linux.org [kernelnewbies-bounce@nl.linux.org] On Behalf Of naveen yadav
Hi,

>Hi All,
>
>I have few drivers and very big application running on ARM and MIPS target.
>I want to check the performance by changing the page size ie.

I remember it is possible on powerpc.
There is config option like CONFIG_PPC_64K_PAGES.
Not sure about ARM/MIPS archs, but you can certianly grep for something like 4K_PAGE all around defconfigs

>8K, 16K, 32K etc.
>
>Is it possile, If yes then what all care i need to take .
>
>Thanks.

--
Viral

This Email may contain confidential or privileged information for the intended recipient (s) If you are not the intended recipient, please do not use or disseminate the information, notify the sender and delete it from your system.

______________________________________________________________________
