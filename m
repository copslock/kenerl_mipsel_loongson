Return-Path: <SRS0=PFn9=YS=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48DF5CA9EA0
	for <linux-mips@archiver.kernel.org>; Fri, 25 Oct 2019 21:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C88821D82
	for <linux-mips@archiver.kernel.org>; Fri, 25 Oct 2019 21:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572040149;
	bh=9OocIlW3MdTggjKr6xrZoWrr6c8j+hbrcGG725i/W60=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jogiHr7B2kcqA4/fO3vwJDnhEZ4D18OJDSVeTpn+dAhLbZ61/xJz++8Mlt9jjvw49
	 S482epwEsZ3Qq8Tw3lnVKKGnlD1VDGsB+5hQD6jNHgu+J9Ezda+WmBxrszo0EOoQH6
	 rqOrAwDeA35l5j2BkMvflyFrgsV+AfoGAgIzZ6WE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbfJYVtG (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 25 Oct 2019 17:49:06 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38913 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfJYVtF (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Fri, 25 Oct 2019 17:49:05 -0400
Received: by mail-oi1-f196.google.com with SMTP id v138so2577503oif.6;
        Fri, 25 Oct 2019 14:49:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wGm3OSExE/97BmM29xjH36/abWZ9nPYDMo8RkVIn7DU=;
        b=ISKp1hthhRab8G1/BzjmgcJCtX2BtVilxMqR/GAIdLmwh8PuNwXtbk5XC5KwSZWhO6
         a0pU3jvTPSFQCBKO8Fsz+R8oqem9R4JsvriLiO1abdJ9xO7pl5/2te7H6vEmiQ5dV4iU
         32/eu0DWGnl7JMvtUD4JnE5ZsUAcGOvGSDqI5uw+eqWedniSEMgIpEHZUzvljwuYaxL8
         U4f21bXknCiJr0aocYIxj8x+sbU9TYqXfCo+9O11Yi56tBIJSRgFo/1T5EwXeSFqScps
         cwoPB44//bZ7u5+/4I9FBfMUBbbAlkRx4aursLyRMfUfWlZwy0xKFhGbcJns6Ovs5Pr0
         dTZQ==
X-Gm-Message-State: APjAAAVKPO7Yy1y6MrZ7iSO9mjF1GE0nIY3vcJxgUgfHiufiM8mxh6ys
        yAl6l3/SQb6roQikEQDjmA==
X-Google-Smtp-Source: APXvYqwLbnmVyTEOV9qgJJFVyWAeKISdHnloLOn/3BypbMbjV29PEr1S6ftViDUyEbH+5o61CqsHSw==
X-Received: by 2002:a05:6808:7d9:: with SMTP id f25mr4933670oij.69.1572040144629;
        Fri, 25 Oct 2019 14:49:04 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 34sm1139469otf.55.2019.10.25.14.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 14:49:03 -0700 (PDT)
Date:   Fri, 25 Oct 2019 16:49:03 -0500
From:   Rob Herring <robh@kernel.org>
To:     Zhou Yanjie <zhouyanjie@zoho.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, paul.burton@mips.com, mturquette@baylibre.com,
        sboyd@kernel.org, mark.rutland@arm.com, paul@crapouillou.net
Subject: Re: [PATCH 1/2 v2] dt-bindings: clock: Add X1000 bindings.
Message-ID: <20191025214903.GA14052@bogus>
References: <1571421006-12771-1-git-send-email-zhouyanjie@zoho.com>
 <1571763389-43443-1-git-send-email-zhouyanjie@zoho.com>
 <1571763389-43443-2-git-send-email-zhouyanjie@zoho.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1571763389-43443-2-git-send-email-zhouyanjie@zoho.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On Wed, 23 Oct 2019 00:56:28 +0800, Zhou Yanjie wrote:
> Add the clock bindings for the X1000 Soc from Ingenic.
> 
> Signed-off-by: Zhou Yanjie <zhouyanjie@zoho.com>
> ---
>  .../devicetree/bindings/clock/ingenic,cgu.txt      |  1 +
>  include/dt-bindings/clock/x1000-cgu.h              | 41 ++++++++++++++++++++++
>  2 files changed, 42 insertions(+)
>  create mode 100644 include/dt-bindings/clock/x1000-cgu.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
