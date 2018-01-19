Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Jan 2018 20:23:48 +0100 (CET)
Received: from mail-ot0-f196.google.com ([74.125.82.196]:41427 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990754AbeASTXkCpNep (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 19 Jan 2018 20:23:40 +0100
Received: by mail-ot0-f196.google.com with SMTP id 44so2308415otk.8;
        Fri, 19 Jan 2018 11:23:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1tyOQE48DoFIa5IZtzJ9MAWLeRphi3IPwiSV6Qps/4E=;
        b=QunpdMHPI1wWRlR4644pRC+vmkZvKxlqzjfoOCbxMsc3LRyFO/uRroZ6UNhL+jqo6Z
         A+Da3VETjsJCnnut4vKeyo7ISXc/rJ+hy5dBO7gfZAyP8SjYTGq50I0ZJjI6iBQKZsdt
         rd8HuBC8D6lvDJxqhmg9EhSLa82vehDAJ319cWmmHosKj9n7i9dMeUnYd8id7zWVC7Gj
         b65v4lhj8V74oHQZyx+uazelrKM8cuFWl7IP5qHa3vn9BTVpYaf3dSYirrlhuWtqP71b
         5LTjetAv5RW52v+cZ4CzLeC8REpCYZELUoYjnoPBgc6pNKNklr0pbkww5wxZ/7ZbCpZX
         iTog==
X-Gm-Message-State: AKwxytfP8egbwvfYkwGSVPcSqgFqlE+q/btNFEK4UVFdaFzXkFeq43WU
        vUzb++aIyWCdnlYziB7YpA==
X-Google-Smtp-Source: ACJfBotQN4hde2Kr9+Ma9h0fmbRZYYBO+SIPJRfKf2BvuRG+f/ZeqQhIJzBueqopPSaTyRl82LfhZg==
X-Received: by 10.157.63.2 with SMTP id m2mr6586762otc.176.1516389814212;
        Fri, 19 Jan 2018 11:23:34 -0800 (PST)
Received: from localhost (216-188-254-6.dyn.grandenetworks.net. [216.188.254.6])
        by smtp.gmail.com with ESMTPSA id i6sm4202671oiy.22.2018.01.19.11.23.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Jan 2018 11:23:33 -0800 (PST)
Date:   Fri, 19 Jan 2018 13:23:32 -0600
From:   Rob Herring <robh@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc:     James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/8] dt-bindings: mips: Add bindings for Microsemi SoCs
Message-ID: <20180119192332.iwm445tbb7ns42qy@rob-hp-laptop>
References: <20180116101240.5393-1-alexandre.belloni@free-electrons.com>
 <20180116101240.5393-2-alexandre.belloni@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180116101240.5393-2-alexandre.belloni@free-electrons.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62253
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

On Tue, Jan 16, 2018 at 11:12:33AM +0100, Alexandre Belloni wrote:
> Add bindings for Microsemi SoCs. Currently only Ocelot is supported.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  Documentation/devicetree/bindings/mips/mscc.txt | 44 +++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mips/mscc.txt

You missed my R-by on v2.

Rob
