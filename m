Return-Path: <SRS0=3G5J=YH=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F0C2C4CECE
	for <linux-mips@archiver.kernel.org>; Mon, 14 Oct 2019 18:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F31762067B
	for <linux-mips@archiver.kernel.org>; Mon, 14 Oct 2019 18:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571076913;
	bh=ejU6qO+W8lEEYTLPbXtt+7TgI6dl+S8RZPJyJYJH8XI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lgSaDxcNfkc6xFtk8/md92a5W2YwsU2ss3YY/EFbzV6leV7ogW2VUu2oMfiM7Ogz3
	 poInpR8cnQvU/Xs58RyckojTBb75FEEssI0/TZPn539zPIED7FaJk3Ucil72N4rNv7
	 XC1e1vuqqie9SO/1XcxwwMP4at0V9cBE15sMu8ek=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733136AbfJNSPM (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 14 Oct 2019 14:15:12 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42147 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732330AbfJNSPM (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Mon, 14 Oct 2019 14:15:12 -0400
Received: by mail-ot1-f67.google.com with SMTP id c10so14596047otd.9;
        Mon, 14 Oct 2019 11:15:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=73oJVS4+Wov4CaoNHWnI0N3ommx1nafBqtjG04AIdio=;
        b=RZtpz++jl+XqSw6vWw205Hn1j35K3e0LDC3lQTF98kRMXn43JcIT/75W1p0teBw3WP
         O0pRIcYPHlZ6XE53V4jwo20G3cQHKt3InILP25j5Hy/SBLwjs9xWeUTKskuS8o/SGeH1
         4TroOqFKMs6TZ2Q2AEcsg68Qa0CtabV4IUUEI2/pz+Noko7VnAB71bj1Q8SMwtob0jJW
         MXw0czk9MNn2iCWKDYYTJhRCSQlQsXCkcGUpF91fHEXu147VslEjbuI2wPmmPrX1LmfU
         CXLJu42xq33wo4TeCWCUgom6p+7AvbLLZwAkoJbgc0mFU5GjfXJfcbk657FMQijUKUKe
         fGYQ==
X-Gm-Message-State: APjAAAVW+iSbVhj+ooUKCG1kCIm/pmaXwPZB6bUITap5KmV3tIJmpdFI
        bsz+fcjbqNUKboKgf6qbLCu2vX8=
X-Google-Smtp-Source: APXvYqxVyk1pbofRFhvENaXUJqEwHRpF+qQIjgRG5uIp2ILgHRUTeT7k/T8NtpvpVOA/wJ4MAVr/2A==
X-Received: by 2002:a9d:6b82:: with SMTP id b2mr2740392otq.56.1571076911521;
        Mon, 14 Oct 2019 11:15:11 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o23sm5952876ote.67.2019.10.14.11.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 11:15:10 -0700 (PDT)
Date:   Mon, 14 Oct 2019 13:15:10 -0500
From:   Rob Herring <robh@kernel.org>
To:     Zhou Yanjie <zhouyanjie@zoho.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, paul.burton@mips.com, mark.rutland@arm.com,
        syq@debian.org, ulf.hansson@linaro.org, linus.walleij@linaro.org,
        armijn@tjaldur.nl, tglx@linutronix.de, yuehaibing@huawei.com,
        malat@debian.org, ezequiel@collabora.com, paul@crapouillou.net
Subject: Re: [PATCH 4/6 v2] dt-bindings: MMC: Add X1000 bindings.
Message-ID: <20191014181510.GA10839@bogus>
References: <1567669089-88693-1-git-send-email-zhouyanjie@zoho.com>
 <1570857203-49192-1-git-send-email-zhouyanjie@zoho.com>
 <1570857203-49192-5-git-send-email-zhouyanjie@zoho.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1570857203-49192-5-git-send-email-zhouyanjie@zoho.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On Sat, 12 Oct 2019 13:13:18 +0800, Zhou Yanjie wrote:
> Add the MMC bindings for the X1000 Soc from Ingenic.
> 
> Signed-off-by: Zhou Yanjie <zhouyanjie@zoho.com>
> ---
>  Documentation/devicetree/bindings/mmc/jz4740.txt | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
