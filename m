Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Dec 2017 02:16:42 +0100 (CET)
Received: from mail-ot0-f196.google.com ([74.125.82.196]:37461 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991770AbdLABQf306HM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 1 Dec 2017 02:16:35 +0100
Received: by mail-ot0-f196.google.com with SMTP id s4so7827236ote.4;
        Thu, 30 Nov 2017 17:16:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=N/2Mu+vWeXyj7YyFsdmMQiAuBxUTgNRf0edbzl7OOGw=;
        b=btNgnZWnc2plegkDiZcvM6B2oRoPVJJxR3vEPKDb01WAdmFwlwK6tRA80fXnK/mXgz
         /Jaqfq4TRsvdOQQl3fgdyXTRCZ2D3jdEVfswJqiGQkwv11RowHbi+vEY6tcD7ApZk3ku
         JqGJwwRx00GAOQ9xBkEE5irEdSUSpFq9MX93BK9Pg7SJX2o9PBt4IiYHeYe/N11Dphml
         mpvvzRIdovbOWy0VROO337ox3cDIFM7YplV4eoeJS2tCCp9sXEp/57jCnffLkmCIsEfX
         CoRke2y8VR9AgLsbrC8PTxQXLY4qydlyvI/JmlK43Em5WH3yXTeqkqhdvAqW9DIPOxo1
         IieQ==
X-Gm-Message-State: AJaThX6321VHiIctJ0y72x4eJZMjX3bFHSKm2CMKZeCkqQB2srnhoxQ+
        ifK1sgo5UQNq+b7J3YGe8b8kqNY=
X-Google-Smtp-Source: AGs4zMbzAsIbPq7dHB7SDhdn8JufjuBh7w+SwkzNvZWkpnH8JajNirdz8M+hI5psXXRzi3H8STq+AQ==
X-Received: by 10.157.53.93 with SMTP id l29mr6574455ote.69.1512090989714;
        Thu, 30 Nov 2017 17:16:29 -0800 (PST)
Received: from localhost (216-188-254-6.dyn.grandenetworks.net. [216.188.254.6])
        by smtp.gmail.com with ESMTPSA id 203sm2272436oie.27.2017.11.30.17.16.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Nov 2017 17:16:29 -0800 (PST)
Date:   Thu, 30 Nov 2017 19:16:28 -0600
From:   Rob Herring <robh@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH 04/13] dt-bindings: pinctrl: Add bindings for Microsemi
 Ocelot
Message-ID: <20171201011628.ou63drexppim2dmw@rob-hp-laptop>
References: <20171128152643.20463-1-alexandre.belloni@free-electrons.com>
 <20171128152643.20463-5-alexandre.belloni@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171128152643.20463-5-alexandre.belloni@free-electrons.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61255
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

On Tue, Nov 28, 2017 at 04:26:34PM +0100, Alexandre Belloni wrote:
> Add the documentation for the Microsemi Ocelot pinmuxing and gpio
> controller.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> To: Linus Walleij <linus.walleij@linaro.org>
> Cc: linux-gpio@vger.kernel.org
> 
>  .../bindings/pinctrl/mscc,ocelot-pinctrl.txt       | 39 ++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/mscc,ocelot-pinctrl.txt

Acked-by: Rob Herring <robh@kernel.org>
