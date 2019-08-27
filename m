Return-Path: <SRS0=TBB5=WX=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A64C3A5A3
	for <linux-mips@archiver.kernel.org>; Tue, 27 Aug 2019 15:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 800092186A
	for <linux-mips@archiver.kernel.org>; Tue, 27 Aug 2019 15:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566919968;
	bh=lIPCd4KUaPFpfmY4MI+EpMHmse23mv99AR3aZJxMgk0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ztyXO42p7obsnLqNMHw8tEG3JshPGJEpteyvCXpb0ftM8IPmCGE+orPCuo292yX6u
	 STLooAtvLdDVv+OeMvOBj6BvEctqfRwwaTZ28UmcL3vMgre/tzhEr4K03hdapwiw7U
	 +aBwHsPFy/H07YtDLg6yLEw5ZF87RFyoEo2q3KsQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbfH0Pcs (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Tue, 27 Aug 2019 11:32:48 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39729 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbfH0Pcs (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Tue, 27 Aug 2019 11:32:48 -0400
Received: by mail-ot1-f65.google.com with SMTP id b1so19074796otp.6;
        Tue, 27 Aug 2019 08:32:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=psxjuLv+ryXAluL3Y0/EmRRDYDCri/QRiadvV6UTfEc=;
        b=GI6MT+/SyPkPqnmuhdnlw3MZeKDPF5cqgoCXEkRkhTf+DTGcN6fcD7chF1IwwTttty
         xTEFTnZXDbYuL79ynvP2vLDDa28icPsNmjsHp5HciOtMnF8Cdi9moX1uh0nRmUyoNs0Q
         XyOjjM4N7edL3Ufau01Wn7EnLZ7dPqhwQNezwSNSZPjZojffdxrqlIA/uE/wr+KqUFYu
         BNq5vauJc49ZTPr6mUdrFxdDj490/6wXxKmNwlBUIVAMdToD9KErAHOf0nk0tIm/+Kzg
         hRZPTEG5zADb99DGv3yQ93SckuRXeB6FQWAR36kxDedvWvzhUSQzbHgvBCzN6gfw3jiT
         VJ0g==
X-Gm-Message-State: APjAAAW/hxIlWSOy1o5HZoWc6WdyXKu058QZoo2Z2eCPCHwpOBARpidd
        0j8J2OmolN62WOOTSnNLQ+gbGbY=
X-Google-Smtp-Source: APXvYqzg87wcjGtdo5ddLcywWbBI4aYwjeq88p93CB03ZutHHEeMht0pndzHOXOaGG00DgHmDANJTw==
X-Received: by 2002:a05:6830:13cb:: with SMTP id e11mr21441210otq.130.1566919967034;
        Tue, 27 Aug 2019 08:32:47 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n1sm4166267oie.12.2019.08.27.08.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 08:32:46 -0700 (PDT)
Date:   Tue, 27 Aug 2019 10:32:46 -0500
From:   Rob Herring <robh@kernel.org>
To:     Stefan Roese <sr@denx.de>
Cc:     linux-mips@vger.kernel.org, Paul Burton <paul.burton@mips.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 3/4 v4] dt-bindings: mips: Add gardena vendor prefix and
 board description
Message-ID: <20190827153246.GA3678@bogus>
References: <20190812103655.11070-1-sr@denx.de>
 <20190812103655.11070-3-sr@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812103655.11070-3-sr@denx.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On Mon, 12 Aug 2019 12:36:54 +0200, Stefan Roese wrote:
> This patch adds the vendor prefix for gardena and a short description
> including the compatible string for the "GARDENA smart Gateway" based
> on the MT7688 SoC.
> 
> Signed-off-by: Stefan Roese <sr@denx.de>
> Cc: Paul Burton <paul.burton@mips.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: devicetree@vger.kernel.org
> ---
> v4:
> - Move board description into ralink.txt instead of creating a gardena
>   board file (Rob)
> - Slightly changed board compatible
> 
> v3:
> - New patch
> 
>  Documentation/devicetree/bindings/mips/ralink.txt   | 13 +++++++++++++
>  .../devicetree/bindings/vendor-prefixes.yaml        |  2 ++
>  2 files changed, 15 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
