Return-Path: <SRS0=Wt1X=WU=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 674D2C3A59E
	for <linux-mips@archiver.kernel.org>; Sat, 24 Aug 2019 07:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BF902146E
	for <linux-mips@archiver.kernel.org>; Sat, 24 Aug 2019 07:41:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=vdorst.com header.i=@vdorst.com header.b="NB/3M+Pc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbfHXHlG (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sat, 24 Aug 2019 03:41:06 -0400
Received: from mx.0dd.nl ([5.2.79.48]:35660 "EHLO mx.0dd.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726018AbfHXHlG (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Sat, 24 Aug 2019 03:41:06 -0400
Received: from mail.vdorst.com (mail.vdorst.com [IPv6:fd01::250])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.0dd.nl (Postfix) with ESMTPS id B91985FBFB;
        Sat, 24 Aug 2019 09:41:03 +0200 (CEST)
Authentication-Results: mx.0dd.nl;
        dkim=pass (2048-bit key; secure) header.d=vdorst.com header.i=@vdorst.com header.b="NB/3M+Pc";
        dkim-atps=neutral
Received: from www (www.vdorst.com [192.168.2.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.vdorst.com (Postfix) with ESMTPSA id 73B691D8AB7C;
        Sat, 24 Aug 2019 09:41:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.vdorst.com 73B691D8AB7C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vdorst.com;
        s=default; t=1566632463;
        bh=qIA9b/hnzdc6JPIQXZGuy0VUvB2oMhN3+uI0Vi3Y2S8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NB/3M+PccmfTsXHEG8/Dt6nXF+TorTmYyddrD5jtILMDoXxmAL2rjVqx0GE9r2hR0
         VjF97jks+woX3OuhAfM399NVCfBaGsQ+iqG15fMmKwKb7uw7tYn8JMZp0nog/nfx1e
         6GT1iWi3yX1Q3CvMdMuCgXbz8UK1ZAlSxyJFRCrtvAIDHdmMh2KiHLM7CHTKIr847R
         0BKs1lYe31LmPVlqlEI0mlnKvxlaEkVReteoKHZ5wYC7bWN+MwNjZtgbe6Hb/LuiNr
         B8fHGlRq1zFSLzCG4UqQyy2nGUFYgZPGO3FeQWOVhi5Ikqhq/Lxs7eIjrAmHi6MpGw
         X18MxL+T5IIJQ==
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1]) by
 www.vdorst.com (Horde Framework) with HTTPS; Sat, 24 Aug 2019 07:41:03 +0000
Date:   Sat, 24 Aug 2019 07:41:03 +0000
Message-ID: <20190824074103.Horde.ytG2fquC9xJKq5TL79l6J0M@www.vdorst.com>
From:   =?utf-8?b?UmVuw6k=?= van Dorst <opensource@vdorst.com>
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Nelson Chang <nelson.chang@mediatek.com>,
        "David S . Miller" <davem@davemloft.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-mips@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>, Stefan Roese <sr@denx.de>
Subject: Re: Aw: [PATCH net-next v3 0/3] net: ethernet: mediatek: convert to
 PHYLINK
References: <20190823134516.27559-1-opensource@vdorst.com>
 <trinity-df75d11a-c27f-4941-a880-b017ebabd3dc-1566583013438@3c-app-gmx-bs75>
In-Reply-To: <trinity-df75d11a-c27f-4941-a880-b017ebabd3dc-1566583013438@3c-app-gmx-bs75>
User-Agent: Horde Application Framework 5
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Hi Frank,

Quoting Frank Wunderlich <frank-w@public-files.de>:

> tested on bpi-r2 (mt7623/mt7530) and bpi-r64 (mt7622/rtl8367)
>

Thanks for testing!

> as reported to rene directly rx-path needs some rework because  
> current rx-speed
> on bpi-r2 is 865 Mbits/sec instead of ~940 Mbits/sec

I still think it is a result of the extra code in the rx path when mt76x8
was introduced.

Greats,

René

>
> Tested-by: Frank Wunderlich <frank-w@public-files.de>
>
> regards Frank
>
>
>> Gesendet: Freitag, 23. August 2019 um 15:45 Uhr
>> Von: "René van Dorst" <opensource@vdorst.com>
>> An: "John Crispin" <john@phrozen.org>, "Sean Wang"  
>> <sean.wang@mediatek.com>, "Nelson Chang"  
>> <nelson.chang@mediatek.com>, "David S . Miller"  
>> <davem@davemloft.net>, "Matthias Brugger" <matthias.bgg@gmail.com>
>> Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,  
>> linux-mediatek@lists.infradead.org, linux-mips@vger.kernel.org,  
>> "Russell King" <linux@armlinux.org.uk>, "Frank Wunderlich"  
>> <frank-w@public-files.de>, "Stefan Roese" <sr@denx.de>, "René van  
>> Dorst" <opensource@vdorst.com>
>> Betreff: [PATCH net-next v3 0/3] net: ethernet: mediatek: convert to PHYLINK
>>
>> These patches converts mediatek driver to PHYLINK API.
>>
>> v2->v3:
>> * Phylink improvements and clean-ups after review
>> v1->v2:
>> * Rebase for mt76x8 changes
>> * Phylink improvements and clean-ups after review
>> * SGMII port doesn't support 2.5Gbit in SGMII mode only in BASE-X mode.
>>   Refactor the code.
>>
>> René van Dorst (3):
>>   net: ethernet: mediatek: Add basic PHYLINK support
>>   net: ethernet: mediatek: Re-add support SGMII
>>   dt-bindings: net: ethernet: Update mt7622 docs and dts to reflect the
>>     new phylink API
>>
>>  .../arm/mediatek/mediatek,sgmiisys.txt        |   2 -
>>  .../dts/mediatek/mt7622-bananapi-bpi-r64.dts  |  28 +-
>>  arch/arm64/boot/dts/mediatek/mt7622.dtsi      |   1 -
>>  drivers/net/ethernet/mediatek/Kconfig         |   2 +-
>>  drivers/net/ethernet/mediatek/mtk_eth_path.c  |  75 +--
>>  drivers/net/ethernet/mediatek/mtk_eth_soc.c   | 529 ++++++++++++------
>>  drivers/net/ethernet/mediatek/mtk_eth_soc.h   |  68 ++-
>>  drivers/net/ethernet/mediatek/mtk_sgmii.c     |  65 ++-
>>  8 files changed, 477 insertions(+), 293 deletions(-)
>>
>> --
>> 2.20.1
>>
>>



