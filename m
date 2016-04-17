Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 17 Apr 2016 20:47:30 +0200 (CEST)
Received: from mail-pf0-f181.google.com ([209.85.192.181]:36712 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27026222AbcDQSr2rUXrs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 17 Apr 2016 20:47:28 +0200
Received: by mail-pf0-f181.google.com with SMTP id e128so72853509pfe.3
        for <linux-mips@linux-mips.org>; Sun, 17 Apr 2016 11:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=b+ZgNKMhWYioiSyA1+m5rPMAYRB9uYMyBUQczqsGFIw=;
        b=CCRyhjQeMaJdb7iRqi4deuz1VdBq+Rp7i3DrYN9lhiGCCwaCoOIbk2kEOBO8MO1VGB
         IbOkMGAgs7/5lMqdnlRz3d/eKiilBwCR3MAE/u2n9ak9TWsIw76jDxs9P6i634JL3zHV
         ySl6PuWr90PNr9j5Jh1hh4iW1yySF6XmqPl64=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=b+ZgNKMhWYioiSyA1+m5rPMAYRB9uYMyBUQczqsGFIw=;
        b=e6pNSEOx4J9n6IReHR0nNViLdNPO1OeUDfKQnrJIIMgFrJPpLqdGU89lZsS+khUAJA
         jZXHSg6W/znkfrtdLT0oM4Tyb4FOBpBFms6m28F8ijm6HF4Do+Pb6tBx6t5LjSjWh3qP
         o4jEDFnBXtaH6FjbH9Uq8QOuuu8j7G4Yz+4JHt7xoQi6vWOEIZUoXCFjr4LpEWaQvZRV
         95vdxreuJB1Gfnd7xwjiPD8VTpDR+zQpwoIPTEy1PnRgFJNgEMnDgyijaD2BSCsXDzNe
         Tb71j7dqeXyVKGC7PT1gQnXDcH0cTho6/7xRTPbgpYywXxNwipd4AYuUz8HyaQ3o/ZMP
         UqLQ==
X-Gm-Message-State: AOPr4FUfxRmV1873lraKU4VOYJJQ7JYcRY4sWKZB67SlbQWlz83EjCxzWXFXPBgBsqIqwnUQ
X-Received: by 10.98.14.2 with SMTP id w2mr44356679pfi.35.1460918843094;
        Sun, 17 Apr 2016 11:47:23 -0700 (PDT)
Received: from tuxbot (ip68-111-223-48.sd.sd.cox.net. [68.111.223.48])
        by smtp.gmail.com with ESMTPSA id w189sm27896910pfw.46.2016.04.17.11.47.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Apr 2016 11:47:22 -0700 (PDT)
Date:   Sun, 17 Apr 2016 11:47:19 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Keguang Zhang <keguang.zhang@gmail.com>
Cc:     linux-mips@linux-mips.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-mtd@lists.infradead.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vinod Koul <vinod.koul@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH V1 6/7] MIPS: Loongson1B: Some updates/fixes for LS1B
Message-ID: <20160417184719.GD391@tuxbot>
References: <1459946095-7637-1-git-send-email-keguang.zhang@gmail.com>
 <1459946095-7637-7-git-send-email-keguang.zhang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1459946095-7637-7-git-send-email-keguang.zhang@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <bjorn.andersson@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53032
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bjorn.andersson@linaro.org
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

On Wed 06 Apr 05:34 PDT 2016, Keguang Zhang wrote:

> From: Kelvin Cheung <keguang.zhang@gmail.com>
> 
> - Add DMA device
> - Add NAND device
> - Add GPIO device
> - Add LED device
> - Update the defconfig and rename it to loongson1b_defconfig
> - Fix ioremap size
> - Other minor fixes

You should split this into a series of patches, at least to get all the
non-functional (renames and BIT usage) into a separate patch. That
way it's much easier to review your functional changes and to later
debug any issues introduced.

Regards,
Bjorn
