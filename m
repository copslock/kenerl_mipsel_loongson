Return-Path: <SRS0=SfrM=P7=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLACK autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F60C282C0
	for <linux-mips@archiver.kernel.org>; Wed, 23 Jan 2019 03:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F85A217D4
	for <linux-mips@archiver.kernel.org>; Wed, 23 Jan 2019 03:40:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="YQv4Vrz/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbfAWDkc (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Tue, 22 Jan 2019 22:40:32 -0500
Received: from forward105p.mail.yandex.net ([77.88.28.108]:48449 "EHLO
        forward105p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726908AbfAWDkc (ORCPT
        <rfc822;linux-mips@vger.kernel.org>);
        Tue, 22 Jan 2019 22:40:32 -0500
Received: from mxback8g.mail.yandex.net (mxback8g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:169])
        by forward105p.mail.yandex.net (Yandex) with ESMTP id 1F9844D424FD;
        Wed, 23 Jan 2019 06:40:29 +0300 (MSK)
Received: from smtp1o.mail.yandex.net (smtp1o.mail.yandex.net [2a02:6b8:0:1a2d::25])
        by mxback8g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id YPGo9ww6PR-eSSS6aPo;
        Wed, 23 Jan 2019 06:40:28 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1548214828;
        bh=5Czxgyc7xmx/RW8Y/rOaq7jA1toVuuRRABTHHZOjo84=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:Message-ID;
        b=YQv4Vrz/WJ4vasJy3YKahw3NP3+88V3zSKVcCSPPxznK8FFAK6FPHETMrG+hyeU6t
         Hd1hTD9uPXNcHQ7S5RY85tLqzBdH7LN+Z4hIugCuUF0DZFLDKAZGWZoI0xYcaWgTFl
         I1tSCbrpg9ht+lH4NslW0/+p1hbUxyfiodMsTq8E=
Authentication-Results: mxback8g.mail.yandex.net; dkim=pass header.i=@flygoat.com
Received: by smtp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id CwNE9vx5hC-eQPWxR0p;
        Wed, 23 Jan 2019 06:40:26 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Date:   Wed, 23 Jan 2019 11:40:12 +0800
User-Agent: K-9 Mail for Android
In-Reply-To: <CAJhJPsU1DPBp6it0agNrDfLpQGRV0c45mH6mTi=wcwt0OZikkQ@mail.gmail.com>
References: <20190122130415.3440-1-jiaxun.yang@flygoat.com> <CY4PR2201MB12723EF92091D72E29C5B2A6C1990@CY4PR2201MB1272.namprd22.prod.outlook.com> <CAJhJPsU1DPBp6it0agNrDfLpQGRV0c45mH6mTi=wcwt0OZikkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/6] MIPS: Loongson32: Remove unused platform devices
To:     Kelvin Cheung <keguang.zhang@gmail.com>,
        Paul Burton <paul.burton@mips.com>
CC:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        Paul Burton <pburton@wavecomp.com>, linux-mips@linux-mips.org
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
Message-ID: <32183566-60A0-4652-8B75-2CDA04208EF9@flygoat.com>
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org



On January 23, 2019 11:26:01 AM GMT+08:00, Kelvin Cheung <keguang=2Ezhang@=
gmail=2Ecom> wrote:
>Hi Paul, Jiaxun,
>The platform=2E[ch] is the common code for both Loongson1B and
>Loongson1C=2E
>And the DMA and NAND device are used by Loongson1B=2E

Hi Kevin:
It seemed like there are no drivers for these devices in mainline kernel=
=2E
It would be nice if you can submit these driver before revert this patch=
=2E

BTW: I'm currently working on refactor Loongson32 platform with DeviceTree=
=2E

Thanks
>Could you please revert this patch=2E
>Thanks!
>
>Paul Burton <paul=2Eburton@mips=2Ecom> =E4=BA=8E2019=E5=B9=B41=E6=9C=8823=
=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=889:34=E5=86=99=E9=81=93=EF=BC=
=9A
>
>> Hello,
>>
>> Jiaxun Yang wrote:
>> > platform=2Ec contains several unused platform device with no
>> > drivers submited=2E
>> >
>> > Signed-off-by: Jiaxun Yang <jiaxun=2Eyang@flygoat=2Ecom>
>>
>> Applied to mips-next=2E
>>
>> Thanks,
>>     Paul
>>
>> [ This message was auto-generated; if you believe anything is
>incorrect
>>   then please email paul=2Eburton@mips=2Ecom to report it=2E ]
>>

--=20
Jiaxun Yang
