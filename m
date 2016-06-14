Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Jun 2016 00:32:34 +0200 (CEST)
Received: from mail-oi0-f48.google.com ([209.85.218.48]:35392 "EHLO
        mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27040891AbcFNWc3B5W39 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 15 Jun 2016 00:32:29 +0200
Received: by mail-oi0-f48.google.com with SMTP id w5so7134562oib.2;
        Tue, 14 Jun 2016 15:32:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=1lLR8CLl/bL5BuF1s6mY1IRbAPvsXtFORi/DN4tgx4A=;
        b=gZ6xWDYDxnQnQIBmM6zl3NmcixLroe/HY8OCs6ue8xoh7l1m7ZEeCfEpDLBS7+bvaa
         0gbi1J2pQLUZrCKUt0Rdta/egvEXBWHSCF0w1yaFqGXTxtK62Rc7Mszr3xzR/qhb4qxU
         yMZyPN0BnZL5492WYSujfLMujDI3l6aa8lsdCQtpjtU37XIklovqm5DkGkZUTyePiDsa
         rx8/CPE8+4HVOgnJ5Kjk2DUd5VoryOcJ95N+Ib69A7cVgjlI/6OWlQenTEOcpG2ruOkb
         1qjivd1qJ/xwTLH0WI3zHiMoCHcnuLKwQtrhR5Oys2QyJhKB8pGewtB92KeBwcj65Gv3
         iPSQ==
X-Gm-Message-State: ALyK8tIVpXk9Rqrc7rRrXHlKr2DsvD7HpPvIo2Wm43gES+m7NO0If5l5JilUJFLXT/fqtQ==
X-Received: by 10.202.224.85 with SMTP id x82mr11995310oig.176.1465943543237;
        Tue, 14 Jun 2016 15:32:23 -0700 (PDT)
Received: from localhost (72-48-98-129.dyn.grandenetworks.net. [72.48.98.129])
        by smtp.gmail.com with ESMTPSA id k79sm4916272oih.12.2016.06.14.15.32.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Jun 2016 15:32:22 -0700 (PDT)
Date:   Tue, 14 Jun 2016 17:32:22 -0500
From:   Rob Herring <robh@kernel.org>
To:     =?iso-8859-1?Q?=C1lvaro_Fern=E1ndez?= Rojas <noltari@gmail.com>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, ralf@linux-mips.org,
        f.fainelli@gmail.com, jogo@openwrt.org, cernekee@gmail.com,
        simon@fire.lp0.eu
Subject: Re: [PATCH 3/6] MIPS: BMIPS: Add BCM3368 support
Message-ID: <20160614223222.GA6983@rob-hp-laptop>
References: <1465803534-25840-1-git-send-email-noltari@gmail.com>
 <1465803534-25840-3-git-send-email-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1465803534-25840-3-git-send-email-noltari@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54049
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robh@kernel.org
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

On Mon, Jun 13, 2016 at 09:38:51AM +0200, Álvaro Fernández Rojas wrote:
> BCM3368 has a shared TLB which conflicts with current SMP support, so it must
> be disabled for now.
> 
> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
> ---
>  Documentation/devicetree/bindings/mips/brcm/soc.txt | 2 +-
>  arch/mips/bmips/setup.c                             | 3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
