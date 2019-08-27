Return-Path: <SRS0=TBB5=WX=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02374C41514
	for <linux-mips@archiver.kernel.org>; Tue, 27 Aug 2019 21:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCF8A20828
	for <linux-mips@archiver.kernel.org>; Tue, 27 Aug 2019 21:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566942666;
	bh=ImSxZ5uNfP/r6975Fr/xXD5gvPOYtS6wRjTUI/V0w6M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BscZ0qHtbAAS8xYy4qX9shuqe3SDrz9KcMfhhJ4Ovcgzb3w8a7DbXEDY10ZHqjoun
	 ivLLjb4lqbOUlOFoHgwZmgVps0vHK0OW5MecrIiZtvbxP+nc9euP4y3gSvajrNMTxJ
	 Ha4z6U2YbTt7W02SIUOEIGxvB6vw9VI14lX2HpHI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbfH0VvF (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Tue, 27 Aug 2019 17:51:05 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42865 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbfH0VvF (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Tue, 27 Aug 2019 17:51:05 -0400
Received: by mail-ot1-f65.google.com with SMTP id j7so672123ota.9;
        Tue, 27 Aug 2019 14:51:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=6UdyZcW8GFUoOtzUiYA5oJv2+sr88zTJhUxT/a3/xms=;
        b=haBhAWvbeMDkQy34cFiGETDjgcGS+OUwoYesplqqIM/B8lMStXztJPUUzY+AOeD+aJ
         hDZqSggNYijakBb+IZ4F9sMIIep0WWz3y/ed6FbtqmraA2l+rk7N9ziwXr28Rcq8R5LB
         HUIifvMs2NqOgx51k5ujUivgKKMrnOP7Nlv1Ew5dCEKeDPcgBFXnDZkMg5oTFOnBZVh5
         YyXYOcIbEWQoRdNz4ZcyMkuN4ZR7GpHQVH71I5qEwCdmyPSHMHFErQIHiaTOBcxhOEre
         gL6JbDGfDkBYtP/5LkWFI2tk7Wy4Mx4CR975S+CMOxMcVMl7Cw10xeerRaeuTc5tTAci
         uE+A==
X-Gm-Message-State: APjAAAUCdjFcWrytEB5ujgenCKx0R/HSzWOHAfxdGVP+8JLqqrXSu4lk
        mijCZArLRrfiFJQg6+EspQ==
X-Google-Smtp-Source: APXvYqyNJodchzPPttfy347MDQHJuYnjjVx9z7i0CE2ylYyoXY7FQ6zIjBxdcMZshF3PlC4QaHevbA==
X-Received: by 2002:a9d:6290:: with SMTP id x16mr680894otk.292.1566942664365;
        Tue, 27 Aug 2019 14:51:04 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t18sm237696otk.73.2019.08.27.14.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 14:51:03 -0700 (PDT)
Date:   Tue, 27 Aug 2019 16:51:03 -0500
From:   Rob Herring <robh@kernel.org>
To:     =?iso-8859-1?Q?Ren=E9?= van Dorst <opensource@vdorst.com>
Cc:     John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Nelson Chang <nelson.chang@mediatek.com>,
        "David S . Miller" <davem@davemloft.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-mips@vger.kernel.org,
        Frank Wunderlich <frank-w@public-files.de>,
        Stefan Roese <sr@denx.de>, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/3] dt-bindings: net: ethernet: Update
 mt7622 docs and dts to reflect the new phylink API
Message-ID: <20190827215103.GA9401@bogus>
References: <20190821144336.9259-1-opensource@vdorst.com>
 <20190821144336.9259-4-opensource@vdorst.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190821144336.9259-4-opensource@vdorst.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On Wed, Aug 21, 2019 at 04:43:36PM +0200, Ren� van Dorst wrote:
> This patch the removes the recently added mediatek,physpeed property.
> Use the fixed-link property speed = <2500> to set the phy in 2.5Gbit.
> See mt7622-bananapi-bpi-r64.dts for a working example.
> 
> Signed-off-by: Ren� van Dorst <opensource@vdorst.com>
> Cc: devicetree@vger.kernel.org
> Cc: Rob Herring <robh@kernel.org>
> --
> v1->v2:
> * SGMII port only support BASE-X at 2.5Gbit.
> ---
>  .../arm/mediatek/mediatek,sgmiisys.txt        |  2 --

Bindings and dts files should be separate patches.


>  .../dts/mediatek/mt7622-bananapi-bpi-r64.dts  | 28 +++++++++++++------
>  arch/arm64/boot/dts/mediatek/mt7622.dtsi      |  1 -
>  3 files changed, 19 insertions(+), 12 deletions(-)

In any case,

Acked-by: Rob Herring <robh@kernel.org>
