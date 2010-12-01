Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Dec 2010 17:32:03 +0100 (CET)
Received: from mail96.messagelabs.com ([216.82.254.19]:3245 "EHLO
        mail96.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493026Ab0LAQb7 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 1 Dec 2010 17:31:59 +0100
X-VirusChecked: Checked
X-Env-Sender: Viral.Mehta@lntinfotech.com
X-Msg-Ref: server-10.tower-96.messagelabs.com!1291219797!53747085!1
X-StarScan-Version: 6.2.9; banners=lntinfotech.com,-,-
X-Originating-IP: [203.199.118.205]
Received: (qmail 27086 invoked from network); 1 Dec 2010 16:09:59 -0000
Received: from unknown (HELO VSHINMSHTCAS01.vshodc.lntinfotech.com) (203.199.118.205)
  by server-10.tower-96.messagelabs.com with AES128-SHA encrypted SMTP; 1 Dec 2010 16:09:59 -0000
Received: from vshinmsmbx01.vshodc.lntinfotech.com ([172.17.24.117]) by
 VSHINMSHTCAS01.vshodc.lntinfotech.com ([172.17.24.112]) with mapi; Wed, 1 Dec
 2010 21:39:56 +0530
From:   Viral Mehta <Viral.Mehta@lntinfotech.com>
To:     naveen yadav <yad.naveen@gmail.com>,
        "kernelnewbies@nl.linux.org" <kernelnewbies@nl.linux.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-arm-kernel-request@lists.arm.linux.org.uk" 
        <linux-arm-kernel-request@lists.arm.linux.org.uk>
Date:   Wed, 1 Dec 2010 21:38:48 +0530
Subject: RE: double kfree
Thread-Topic: double kfree
Thread-Index: AcuRMm+2wNeXDG91SCe+reDrJIqR6gAP5mnw
Message-ID: <D69C90565D53114396BF743585AF5A09122E61E8C4@VSHINMSMBX01.vshodc.lntinfotech.com>
References: <AANLkTinZytSf5izqEuK5ACQzfDn-P-qmjr6HEet35k1-@mail.gmail.com>
In-Reply-To: <AANLkTinZytSf5izqEuK5ACQzfDn-P-qmjr6HEet35k1-@mail.gmail.com>
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
X-archive-position: 28589
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Viral.Mehta@lntinfotech.com
Precedence: bulk
X-list: linux-mips

________________________________________
From: kernelnewbies-bounce@nl.linux.org [kernelnewbies-bounce@nl.linux.org] On Behalf Of naveen yadav

Hi,
>Hi all,
>
>I Have following question with regard for 2.6.30 kernel
>
> If we do double kfree()

>a) Then what will happen?
>b) Can kernel detect double kfree() ?

What do you want to do ?

>I gone through google to find some way to find it, there it mention
>CONFIG_DEBUG_SLAB can help, but i am not sure how usefull is it.

Can we look at your code ?

This Email may contain confidential or privileged information for the intended recipient (s) If you are not the intended recipient, please do not use or disseminate the information, notify the sender and delete it from your system.

______________________________________________________________________
