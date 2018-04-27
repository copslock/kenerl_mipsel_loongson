Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Apr 2018 22:10:17 +0200 (CEST)
Received: from mail-ot0-f196.google.com ([74.125.82.196]:40129 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990401AbeD0UKKk4Gqc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 27 Apr 2018 22:10:10 +0200
Received: by mail-ot0-f196.google.com with SMTP id n1-v6so3370270otf.7
        for <linux-mips@linux-mips.org>; Fri, 27 Apr 2018 13:10:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Vc9lN2d2XlwozTi+RYBAonPmx6qiTrAZPsxu+MKTNiQ=;
        b=lFaJJME+qv4i2/otrgvy4Oi2Lt2OrW1VDH3OKsxfhybaIHqnRwjewe2gRMv7Lj32ue
         gsWju13IDenNnBtyoJJ3NqtM5UPFyKIeyDAAen6inPabN+7ZOrfWl0qhcfpNslr+GEMU
         6HUzCEPwNfGMRGVeqZrByHMtr7ECg3XmrI9eC3f+EMtkJ8jGh3B34urWEj0SdQ1Ov3Rg
         oE6vgec1cdyDEzUP8QzrdDYWNDf9EtTr5VFFxey1EK65OUWgzSvZl3580mGmMyp6Z7PC
         vVPSqpcINv30qpJMZfeZB4MHZAQtZhEZbiVZsl94CX0S7ShpGwDh+4SCc48pabXK+jH0
         EvTg==
X-Gm-Message-State: ALQs6tA2F1p18gH8DnKx4HbFw84QXmvK/pQGouFIQjEfIGKOfrkZg8LX
        YnKPT46Y/RsYOA0uKvFSEw==
X-Google-Smtp-Source: AB8JxZphK2KLum61Og3Y+vX+Cea0yI9uOjFmFAn1PlH9Vp3gDmZtMspI806KayT/FRHX+w3gHcXnxQ==
X-Received: by 2002:a9d:73c5:: with SMTP id m5-v6mr2513877otk.332.1524859804770;
        Fri, 27 Apr 2018 13:10:04 -0700 (PDT)
Received: from localhost (216-188-254-6.dyn.grandenetworks.net. [216.188.254.6])
        by smtp.gmail.com with ESMTPSA id j64-v6sm1149437otj.21.2018.04.27.13.10.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Apr 2018 13:10:04 -0700 (PDT)
Date:   Fri, 27 Apr 2018 15:10:03 -0500
From:   Rob Herring <robh@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Allan Nielsen <Allan.Nielsen@microsemi.com>,
        razvan.stefanescu@nxp.com, po.liu@nxp.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        James Hogan <jhogan@kernel.org>
Subject: Re: [PATCH net-next v2 3/7] dt-bindings: net: add DT bindings for
 Microsemi Ocelot Switch
Message-ID: <20180427201003.j6gn4ljse4mree36@rob-hp-laptop>
References: <20180426195931.5393-1-alexandre.belloni@bootlin.com>
 <20180426195931.5393-4-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180426195931.5393-4-alexandre.belloni@bootlin.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63817
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

On Thu, Apr 26, 2018 at 09:59:27PM +0200, Alexandre Belloni wrote:
> DT bindings for the Ethernet switch found on Microsemi Ocelot platforms.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: James Hogan <jhogan@kernel.org>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  .../devicetree/bindings/net/mscc-ocelot.txt   | 82 +++++++++++++++++++
>  1 file changed, 82 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/mscc-ocelot.txt

Reviewed-by: Rob Herring <robh@kernel.org>
