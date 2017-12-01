Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Dec 2017 02:15:53 +0100 (CET)
Received: from mail-ot0-f194.google.com ([74.125.82.194]:44709 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991770AbdLABPqlSCGM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 1 Dec 2017 02:15:46 +0100
Received: by mail-ot0-f194.google.com with SMTP id d27so7807730ote.11;
        Thu, 30 Nov 2017 17:15:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HksLHBIUSeh6crz6HUgrpNv2IdFdSgPLVu93BQmyggs=;
        b=fIwoOWl2kQzT83dj0CPT2KGzO5SXvtuCZ2YMNpqfxWco/w/ZPWB9k5cgjAJJqttacN
         gBR8cpwRrY3nYQZtTH+peN29LNaUUC2Z9VkeyzLqYABmNurLAzK94bSyIU/Q0NAWF0UU
         hApu0EcjSrs1Pet05WUFWiE3tfFUqiV3nR7CRS6xe72+5+tdasUQJKBwanvD+2M+mx3/
         b03Sh6Rwy3bMOzXOqlkjmj3poiVijyftW3HfvczBJvUQyf6b2ZjKfRzOZ91Y8VA/caE4
         tfzbkQm/CD69sxooei5wHzfuceZY8qvMr70st3JORK0JMpAdlnKooqCJe6EMicm85Sg4
         9QLQ==
X-Gm-Message-State: AJaThX5Y5tj+aJ/BKGcynr8C8gTbmartDi66iEWVHMHqbfMD5NDLCk/A
        YFb43NM78GfOW3kBsLeeyReJJwc=
X-Google-Smtp-Source: AGs4zMbR7MLmPv+PMTZ3RRZDOluE/fVN5nr0jQ/+8rShQfxlzxT8LA4+RHvHOEVnX9NlC9keZMlCEA==
X-Received: by 10.157.29.151 with SMTP id y23mr6423107otd.61.1512090940885;
        Thu, 30 Nov 2017 17:15:40 -0800 (PST)
Received: from localhost (216-188-254-6.dyn.grandenetworks.net. [216.188.254.6])
        by smtp.gmail.com with ESMTPSA id x14sm2263709oia.58.2017.11.30.17.15.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Nov 2017 17:15:40 -0800 (PST)
Date:   Thu, 30 Nov 2017 19:15:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH 02/13] dt-bindings: interrupt-controller: Add binding for
 the Microsemi Ocelot interrupt controller
Message-ID: <20171201011539.amiqdbhdcjm5tdhe@rob-hp-laptop>
References: <20171128152643.20463-1-alexandre.belloni@free-electrons.com>
 <20171128152643.20463-3-alexandre.belloni@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171128152643.20463-3-alexandre.belloni@free-electrons.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61254
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

On Tue, Nov 28, 2017 at 04:26:32PM +0100, Alexandre Belloni wrote:
> Add the Device Tree binding documentation for the Microsemi Ocelot
> interrupt controller that is part of the ICPU. It is connected directly to
> the MIPS core interrupt controller.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> To: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jason Cooper <jason@lakedaemon.net>
> 
>  .../interrupt-controller/mscc,ocelot-icpu-intr.txt | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/mscc,ocelot-icpu-intr.txt

Acked-by: Rob Herring <robh@kernel.org>
