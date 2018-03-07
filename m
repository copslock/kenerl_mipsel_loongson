Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Mar 2018 16:53:27 +0100 (CET)
Received: from forward101j.mail.yandex.net ([5.45.198.241]:57911 "EHLO
        forward101j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994724AbeCGPxU511Wy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 7 Mar 2018 16:53:20 +0100
Received: from mxback10j.mail.yandex.net (mxback10j.mail.yandex.net [IPv6:2a02:6b8:0:1619::113])
        by forward101j.mail.yandex.net (Yandex) with ESMTP id 1B8561242FE2;
        Wed,  7 Mar 2018 18:53:15 +0300 (MSK)
Received: from smtp4o.mail.yandex.net (smtp4o.mail.yandex.net [2a02:6b8:0:1a2d::28])
        by mxback10j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id MMlBj7Jo1w-rC4uxfGO;
        Wed, 07 Mar 2018 18:53:15 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1520437995;
        bh=LhaSkkH6bNOjGva+/I033TKzuz7JhdjKQHdX2SXoMjs=;
        h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=NInvy2KpTQKLud3ODoQ4rVz9d4sunJCSmzINld0WPzRjMoXsHBzxQUAk7uZhY50Zw
         5w+zuBTi6PxZLaHv3Oe7D9OYSvsMqiZmRrg9MuA5GhY41j3pNRKG+TKdICOQAoTw+6
         kWQqYfJa2GJiQTn4YBojvlkvCSqeu7m3Y3lZCJFk=
Received: by smtp4o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id ocAtXY9o3I-qvZCVTwG;
        Wed, 07 Mar 2018 18:53:09 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1520437990;
        bh=LhaSkkH6bNOjGva+/I033TKzuz7JhdjKQHdX2SXoMjs=;
        h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=hyU6P2kVD2wU33FDOVxTSNUboVxsstie4DodvfzYfMNoHmTCI2hEJS01mjVfy+kXb
         1b1sjWXR/ilfy6ldhMKUCvbBGTy2DWMgHbmaTRbKunqQVCTb1rvF0ogI5QgK8DfJ9p
         z5nKm1S1t6rrkOSHrnRHL6nTKU1xW21EM4Lppl8I=
Authentication-Results: smtp4o.mail.yandex.net; dkim=pass header.i=@flygoat.com
Message-ID: <1520437971.3731.22.camel@flygoat.com>
Subject: Re: [RFC 3/4] MIPS: Ingenic: Initial X1000 SoC support
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>,
        James Hogan <jhogan@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Michael Turquette <mturquette@baylibre.com>,
        sboyd@codeaurora.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        linux-clk@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Mathieu Malaterre <malat@debian.org>,
        Dominik Peklo <dom.peklo@gmail.com>
Date:   Wed, 07 Mar 2018 23:52:51 +0800
In-Reply-To: <CANc+2y5wsvGWszu3pePYhs2wb1_AgPdjG+ugfOCzbZVfVHDMvw@mail.gmail.com>
References: <20170927151527.25570-1-prasannatsmkumar@gmail.com>
         <20170927151527.25570-4-prasannatsmkumar@gmail.com>
         <20180306000832.GL4197@saruman>
         <CANc+2y5_R5xYQuLbW7NAjO4mcW5RNn3Da77tAhYU5zj=0rkBDQ@mail.gmail.com>
         <20180307143541.GN4197@saruman>
         <CANc+2y5wsvGWszu3pePYhs2wb1_AgPdjG+ugfOCzbZVfVHDMvw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-Path: <jiaxun.yang@flygoat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62841
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jiaxun.yang@flygoat.com
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

在 2018-03-07三的 20:35 +0530，PrasannaKumar Muralidharan写道：
> Hi James,
> 
> Seems Jiaxun is interested in the board and is willing to help.
> 
> I have been told that Ingenic is focusing on IoT market and X1000 is
> intended for IoT segment. I think that they would be selling several
> 100Ks of chip over the coming years. But I feel Ingenic spends time
> only on maintaining their Linux port which is usually based on very
> old kernel version.

Ingenic is going to release their XBrust2 core with it's products such
as X2000 a few days later. Witch is a pure MIPS64r5 with MXU2(A
superset of MIPS's MSA SIMD instruction set). The newest kernel port of
X1000 maintain by Ingenic is based on Linux-4.4 [1]. After communicated
with Ingenic, they said they are forcusing on China domestic market.
But they're looking for partners to enter foriegn market. 

[1] https://pan.baidu.com/s/1o8MeYts (Well you can download from this
Chinese website, ingenic have a gerrit but I don't have access to it.
As my experience, it's hard to develop on Chinese-made chips wihout
reading Chinese documents.)  
> 
> > 
