Return-Path: <SRS0=RYQo=X3=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B69C6ECE58A
	for <linux-mips@archiver.kernel.org>; Wed,  2 Oct 2019 14:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E25A21D81
	for <linux-mips@archiver.kernel.org>; Wed,  2 Oct 2019 14:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570025976;
	bh=5jwa5QU4b2kuiK9FRfyDKeWSAKSHZMeR41cXrtbsnHQ=;
	h=Date:From:Subject:References:In-Reply-To:Cc:Cc:To:List-ID:From;
	b=U9Dtpzc2jz5F+W8QewXhqboUDV4ntOO27q99cq+qJR68HCztquRSDzUzotwaf8bii
	 wlHtrmy/UJttSfXkNc6fFIXjNrTV1CHUAsmLUGK8ouD76HaTobQ9+zDpK9kke0zt7g
	 oUhpcxQTW21LctHokOOdHl7mWdKnJaq8FhFR0Uhc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728313AbfJBOTf (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Wed, 2 Oct 2019 10:19:35 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45345 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728230AbfJBOTe (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Wed, 2 Oct 2019 10:19:34 -0400
Received: by mail-qt1-f196.google.com with SMTP id c21so26492019qtj.12;
        Wed, 02 Oct 2019 07:19:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:subject:references
         :in-reply-to:mime-version:content-transfer-encoding:cc:cc:to;
        bh=xEcXpQ/NEwyCKzNgI7asImKqcpzGOLlroU+HXRPzw4Y=;
        b=pbl8cfHVjygWxRJrxDOT49+2J+Ri/7m9++D1QRchMBW3FEQG7zQUcPOUe3cs5urfnb
         Q0gi2YkQr/rIhtBd4h2+T8G1NFLNChz2+zexhlEqwu4rmW2YMR9lB7T64NehQhKocP4q
         9Oof/LI67NNKSHmCrrDHJEOuPP6bBGCyBGC5smgkm7/bkFddY6Ro0A5olq3/DoKy8LPT
         VSz4k0vEnlmGSeeBekTIGef9GXNwC/JLQmW6DhDUdufbYzI+SLB5g9gL1v8HuBvHeHht
         7F7uup4R07DdNjMlFi/n+lQ8sl+Q5OYoOegcWTcoFqzJjEBOqGmw4nIkEZp46o3gLEfY
         HqUg==
X-Gm-Message-State: APjAAAUH2F5bdtEQ+UKEMKF0F+bvtIM7tC0pjFVK6R7af0s0XgIMZNEW
        OOmvhU5p749tQMYsynvR6f4F9yQQOA==
X-Google-Smtp-Source: APXvYqxaLnHeciWkdlweE2LBBH7eoNN5RyZrMPdqv69QmbChVl6tENsSTpMqu/HDsjtpBHL6zYeZPA==
X-Received: by 2002:a0c:a5a5:: with SMTP id z34mr3240240qvz.110.1570025972605;
        Wed, 02 Oct 2019 07:19:32 -0700 (PDT)
Received: from localhost ([132.205.230.8])
        by smtp.gmail.com with ESMTPSA id d45sm12737320qtc.70.2019.10.02.07.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 07:19:32 -0700 (PDT)
Message-ID: <5d94b1f4.1c69fb81.6f9ad.2586@mx.google.com>
Date:   Wed, 02 Oct 2019 09:19:29 -0500
From:   Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/3] docs: fix some broken references
References: <b87385b2ac6ce6c75df82062fce2976149bbaa6b.1569330078.git.mchehab+samsung@kernel.org>
In-Reply-To: <b87385b2ac6ce6c75df82062fce2976149bbaa6b.1569330078.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>, corbet@lwn.net
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Shannon Nelson <snelson@pensando.io>,
        Pensando Drivers <drivers@pensando.io>,
        Steve French <sfrench@samba.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-mips@vger.kernel.org, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-riscv@lists.infradead.org
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On Tue, 24 Sep 2019 10:01:28 -0300, Mauro Carvalho Chehab wrote:
> There are a number of documentation files that got moved or
> renamed. update their references.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> ---
>  Documentation/devicetree/bindings/cpu/cpu-topology.txt    | 2 +-
>  Documentation/devicetree/bindings/timer/ingenic,tcu.txt   | 2 +-
>  Documentation/driver-api/gpio/driver.rst                  | 2 +-
>  Documentation/hwmon/inspur-ipsps1.rst                     | 2 +-
>  Documentation/mips/ingenic-tcu.rst                        | 2 +-
>  Documentation/networking/device_drivers/mellanox/mlx5.rst | 2 +-
>  MAINTAINERS                                               | 2 +-
>  drivers/net/ethernet/faraday/ftgmac100.c                  | 2 +-
>  drivers/net/ethernet/pensando/ionic/ionic_if.h            | 4 ++--
>  fs/cifs/cifsfs.c                                          | 2 +-
>  10 files changed, 11 insertions(+), 11 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

