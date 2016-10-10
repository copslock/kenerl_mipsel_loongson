Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Oct 2016 15:01:36 +0200 (CEST)
Received: from mail-oi0-f67.google.com ([209.85.218.67]:35057 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991978AbcJJNB2mCnvk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 10 Oct 2016 15:01:28 +0200
Received: by mail-oi0-f67.google.com with SMTP id d132so8239622oib.2;
        Mon, 10 Oct 2016 06:01:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=S45nx8mZSgfGLwvjE1LOHUYuT7jWvneIRYl7DuUAHF4=;
        b=fKKjJdcAYu2U2a+QnpBSrTW6nW2XPpVl0GeVISKCVUZ0Mg4tFrMe7ACyCH2rag00Ss
         238kbBhfwWFtjTO/NcKTOW1hnRY8osyZoW1bVm6FnuyMMaGGjpfFedQRIjjR9MidVhZa
         /N0u+i7Q0tDb3U+Ow5fC9hRip7kwxkvDleMrCQ7MvHmKdLKOWfIOY1F3J+vimEXywJIE
         FJKXzu04vna3w1UuSvgYxIaFJXnWRpoOapq/LOQxIUery42UvlrleHfTIyGOrzWqcbNE
         AAx4JO61jssdGaFNM08VLlp5NsbvxMV6S7msXYPMLGL2AF6sdPXsy92G/G9IxeEI58iX
         bAbw==
X-Gm-Message-State: AA6/9RmIWHe4Xo1nAxP3zk938POqD5mjov0trWe72aijHhXtZibRambyAlF7I8slILlvAA==
X-Received: by 10.157.17.230 with SMTP id y35mr17801127oty.188.1476104482683;
        Mon, 10 Oct 2016 06:01:22 -0700 (PDT)
Received: from localhost (72-48-98-129.dyn.grandenetworks.net. [72.48.98.129])
        by smtp.gmail.com with ESMTPSA id r194sm10549889oie.13.2016.10.10.06.01.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Oct 2016 06:01:22 -0700 (PDT)
Date:   Mon, 10 Oct 2016 08:01:21 -0500
From:   Rob Herring <robh@kernel.org>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, linux-clk@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 16/18] dt-bindings: Document img,boston-clock binding
Message-ID: <20161010130121.GA31827@rob-hp-laptop>
References: <20161005171824.18014-1-paul.burton@imgtec.com>
 <20161005171824.18014-17-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161005171824.18014-17-paul.burton@imgtec.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55376
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

On Wed, Oct 05, 2016 at 06:18:22PM +0100, Paul Burton wrote:
> Add device tree binding documentation for the clocks provided by the
> MIPS Boston development board from Imagination Technologies, and a
> header file describing the available clocks for use by device trees &
> driver.
> 
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Cc: linux-clk@vger.kernel.org
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: devicetree@vger.kernel.org
> 
> ---
> 
> Changes in v3: None
> Changes in v2:
> - Add BOSTON_CLK_INPUT to expose the input clock.
> 
>  .../devicetree/bindings/clock/img,boston-clock.txt | 27 ++++++++++++++++++++++
>  include/dt-bindings/clock/boston-clock.h           | 14 +++++++++++
>  2 files changed, 41 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/img,boston-clock.txt
>  create mode 100644 include/dt-bindings/clock/boston-clock.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/img,boston-clock.txt b/Documentation/devicetree/bindings/clock/img,boston-clock.txt
> new file mode 100644
> index 0000000..c01ea60
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/img,boston-clock.txt
> @@ -0,0 +1,27 @@
> +Binding for Imagination Technologies MIPS Boston clock sources.
> +
> +This binding uses the common clock binding[1].
> +
> +[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
> +
> +Required properties:
> +- compatible : Should be "img,boston-clock".
> +- #clock-cells : Should be set to 1.
> +  Values available for clock consumers can be found in the header file:
> +    <dt-bindings/clock/boston-clock.h>
> +- regmap : Phandle to the Boston platform register system controller.
> +  This should contain a phandle to the system controller node covering the
> +  platform registers provided by the Boston board.

Can you just make the clock node a child of the system controller and 
drop this?

Rob
