Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Jun 2016 00:33:07 +0200 (CEST)
Received: from mail-oi0-f67.google.com ([209.85.218.67]:35103 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27041239AbcFNWdEsNXq9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 15 Jun 2016 00:33:04 +0200
Received: by mail-oi0-f67.google.com with SMTP id u201so815647oie.2;
        Tue, 14 Jun 2016 15:33:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=+8n7509slL4M4kYwmjbJ+Q9RlrD+EiHPsuYXVRU8vJU=;
        b=DNNqeMnVsaMRHnBkWBJrwQWun0rxhyt5qABykxOu3+wfxa12QYS8iHct4HGRIpFmOK
         fLAClaGBnTOW2390ONCjMQsOrVI2ML8NaSYP/hU9GuyAoQ0+TRe57tx32HNgmBZbBDGL
         cgiYJb+6pFDkxOGlugcolNxLdjTgUCO1SHpgg0cDDpWZuX9uNPxLySYg0hWOeNcU404z
         qmZxb4+RyOpcYPFmZcNPjL5phQoyOe8F5VziQqn6vgGAoxcU/LNJdASJk5oOE4VQHnA/
         vzleh9AbXCsNMY8ZXT8D8kzSjTxIzcugZ4hX4cmj2HyIkilmaqvAlbOl5yLuOJALdm8e
         N8og==
X-Gm-Message-State: ALyK8tJ5VrzgLJy1EKa4g0/SIkCMNOvvF3g1ex3wkRrJ36L58SjqQj2888V8R4PjzqF+rw==
X-Received: by 10.202.221.6 with SMTP id u6mr12094754oig.51.1465943579097;
        Tue, 14 Jun 2016 15:32:59 -0700 (PDT)
Received: from localhost (72-48-98-129.dyn.grandenetworks.net. [72.48.98.129])
        by smtp.gmail.com with ESMTPSA id u197sm15051506oia.28.2016.06.14.15.32.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Jun 2016 15:32:58 -0700 (PDT)
Date:   Tue, 14 Jun 2016 17:32:58 -0500
From:   Rob Herring <robh@kernel.org>
To:     =?iso-8859-1?Q?=C1lvaro_Fern=E1ndez?= Rojas <noltari@gmail.com>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, ralf@linux-mips.org,
        f.fainelli@gmail.com, jogo@openwrt.org, cernekee@gmail.com,
        simon@fire.lp0.eu
Subject: Re: [PATCH 5/6] MIPS: BMIPS: Add BCM6362 support
Message-ID: <20160614223258.GA7612@rob-hp-laptop>
References: <1465803534-25840-1-git-send-email-noltari@gmail.com>
 <1465803534-25840-5-git-send-email-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1465803534-25840-5-git-send-email-noltari@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54050
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

On Mon, Jun 13, 2016 at 09:38:53AM +0200, Álvaro Fernández Rojas wrote:
> BCM6362 is a BMIPS4350 SoC which needs the same fixup as BCM6368 in order to
> enable SMP support.
> 
> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
> ---
>  Documentation/devicetree/bindings/mips/brcm/soc.txt | 2 +-
>  arch/mips/bmips/setup.c                             | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>
