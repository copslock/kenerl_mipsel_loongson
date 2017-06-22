Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Jun 2017 22:57:09 +0200 (CEST)
Received: from mail-yb0-f195.google.com ([209.85.213.195]:33320 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991957AbdFVU5CgIqtg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 22 Jun 2017 22:57:02 +0200
Received: by mail-yb0-f195.google.com with SMTP id 84so1331150ybe.0;
        Thu, 22 Jun 2017 13:57:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z0SARoKHoMclC31zITIqtV+Bzvp8RLwz8TSW9EvIZ8w=;
        b=mPvXD+PaiaD5cKLO41Ljw3ULjN7QSSXKhUQ8AkxNsEj24ud4egLfAIwdZvwFLZ3gq4
         Eai9jpMy4aZfkRcUTvCGQTClAlkriXSrhbF+cZn3odbCVmcz980BcgCYUGN5Ob5G3KYi
         HzyhC+w0mGNZBa4ovU/aEl2NOAw8fX00KTRskRwssnoWPE/5ciMYtex29R6l6C7W7ucm
         JLpaEhtEBGU/swXD19Ej54zwM2T38sz4r1j8WmASlpx9VuE9cSN0aHRHZdsVOEtDbuFH
         qHqdmcF0sYXdUpMgUN3ZuCHtSqR8My11Xf6Vs2uxkZ7x3iLwewM6wN2wwyHnHfac7BKN
         Bfnw==
X-Gm-Message-State: AKS2vOyh+FqHYJgVkrnaeP3zAikMZg6NX2OKdJTb9Jv1v7+9/46DkPMq
        VQMTC+HyX1owXQ==
X-Received: by 10.37.175.75 with SMTP id c11mr3374698ybj.47.1498165016629;
        Thu, 22 Jun 2017 13:56:56 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id p68sm990256ywd.52.2017.06.22.13.56.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Jun 2017 13:56:56 -0700 (PDT)
Date:   Thu, 22 Jun 2017 15:56:55 -0500
From:   Rob Herring <robh@kernel.org>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v5 1/4] dt-bindings: Document img,boston-clock binding
Message-ID: <20170622205655.2sp2v3hva3jtsuay@rob-hp-laptop>
References: <20170617205249.1391-1-paul.burton@imgtec.com>
 <20170617205249.1391-2-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170617205249.1391-2-paul.burton@imgtec.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58756
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

On Sat, Jun 17, 2017 at 01:52:46PM -0700, Paul Burton wrote:
> Add device tree binding documentation for the clocks provided by the
> MIPS Boston development board from Imagination Technologies, and a
> header file describing the available clocks for use by device trees &
> driver.
> 
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> Cc: Frank Rowand <frowand.list@gmail.com>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Cc: devicetree@vger.kernel.org
> Cc: linux-clk@vger.kernel.org
> Cc: linux-mips@linux-mips.org
> 
> ---
> 
> Changes in v5: None

I reviewed v4. Please add acks/reviewed-by when posting new versions.

> 
> Changes in v4:
> - Move img,boston-clock node under platform register syscon node.
> - Add MAINTAINERS entry.
> 
> Changes in v3: None
> 
> Changes in v2:
> - Add BOSTON_CLK_INPUT to expose the input clock.
> 
>  .../devicetree/bindings/clock/img,boston-clock.txt | 31 ++++++++++++++++++++++
>  MAINTAINERS                                        |  7 +++++
>  include/dt-bindings/clock/boston-clock.h           | 14 ++++++++++
>  3 files changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/img,boston-clock.txt
>  create mode 100644 include/dt-bindings/clock/boston-clock.h
