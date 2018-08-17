Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Aug 2018 17:10:12 +0200 (CEST)
Received: from mail-io0-f195.google.com ([209.85.223.195]:35634 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994665AbeHQPKBbA6OJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 17 Aug 2018 17:10:01 +0200
Received: by mail-io0-f195.google.com with SMTP id w11-v6so7180967iob.2
        for <linux-mips@linux-mips.org>; Fri, 17 Aug 2018 08:10:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xaDHgRbvMtur8Kb4ESNt8Heux765rSR2dKpxLzuA5oA=;
        b=Y3qyFn11mTY1qCPoaJTpA6QbZkw3OGW8oFT8FDlmGiYngUCVmj2fjkPn6ItyrzKAOq
         OCVFSoxldGspcuR0T9J2zuFl5A9GhxHjCkt2L5Kj+jqzYZVR0dRIa3kIL1dVt36eyZSh
         X4Nbc3V/ak88NjpxnOUq/61Hhj4ozJ8bhip6MuOxMMY3TObUnZZLis4gKCrK4/M7o8l6
         qOjPespversbjo9D9yGFHX8EWScR3tjkWOe+PSawHryvQBnlFgy3aokUPcaGCePUKnch
         ca9gzwJXOQk0MDUNEn7KznXUOkcvo9hyF/ONnouD3pyxzX9BLhlzv5Nl1x7B79xpnTH3
         Xo4Q==
X-Gm-Message-State: APzg51BbbEe48/8/bjTPX2up7vC8E+/ijp85q2V1gsIWku5UxtqMV143
        n1zJI75kTQqWUG+Hku/CUQ==
X-Google-Smtp-Source: ANB0VdaIR6KG3LjdO41e+Dyxl6bQaz74eYYp3csFrpsyWA/C6UzM9ykLMhv17Y39EG0PLuC8d3fTLw==
X-Received: by 2002:a6b:ce19:: with SMTP id p25-v6mr2184851iob.243.1534518595416;
        Fri, 17 Aug 2018 08:09:55 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id m1-v6sm931941ioq.2.2018.08.17.08.09.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 Aug 2018 08:09:55 -0700 (PDT)
Date:   Fri, 17 Aug 2018 09:09:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Wolfram Sang <wsa@the-dreams.de>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        James Hogan <jhogan@kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microsemi.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH v4 4/7] i2c: designware: document MSCC Ocelot bindings
Message-ID: <20180817150954.GB20845@rob-hp-laptop>
References: <20180816084521.16289-1-alexandre.belloni@bootlin.com>
 <20180816084521.16289-5-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180816084521.16289-5-alexandre.belloni@bootlin.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65607
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

Hi, this email is from Rob's (experimental) review bot. I found a couple
of common problems with your patch. Please see below.

On Thu, 16 Aug 2018 10:45:18 +0200, Alexandre Belloni wrote:
> Document bindings for the Microsemi Ocelot integration of the Designware
> I2C controller.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

The preferred subject prefix is "dt-bindings: <binding dir>: ...".

> ---
>  Documentation/devicetree/bindings/i2c/i2c-designware.txt | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
