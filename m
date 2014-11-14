Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Nov 2014 12:25:57 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:60177 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27013700AbaKNLZzWoYY0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 14 Nov 2014 12:25:55 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id sAEBPkub011730;
        Fri, 14 Nov 2014 12:25:46 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id sAEBPf5K011729;
        Fri, 14 Nov 2014 12:25:41 +0100
Date:   Fri, 14 Nov 2014 12:25:41 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Andrew Bresticker <abrestic@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        John Crispin <blogic@openwrt.org>,
        David Daney <ddaney.cavm@gmail.com>,
        Qais Yousef <qais.yousef@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V5 1/4] of: Add vendor prefix for MIPS Technologies, Inc.
Message-ID: <20141114112541.GA11666@linux-mips.org>
References: <1415821419-26974-1-git-send-email-abrestic@chromium.org>
 <1415821419-26974-2-git-send-email-abrestic@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1415821419-26974-2-git-send-email-abrestic@chromium.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44156
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Wed, Nov 12, 2014 at 11:43:36AM -0800, Andrew Bresticker wrote:

> Add the vendor prefix "mti" for MIPS Technologies, Inc.
> 
> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> ---
> I'll update the users of the "mips" prefix to use "mti" instead once
> this lands.
> 
> No changes from v2/v3/v4.
> New for v2.
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index 0979393..0221b49 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -98,6 +98,7 @@ mitsubishi	Mitsubishi Electric Corporation
>  mosaixtech	Mosaix Technologies, Inc.
>  moxa	Moxa
>  mpl	MPL AG
> +mti	MIPS Technologies, Inc.
>  mundoreader	Mundo Reader S.L.
>  murata	Murata Manufacturing Co., Ltd.
>  mxicy	Macronix International Co., Ltd.

Your patch does almost the same as

  https://patchwork.linux-mips.org/patch/8169/

which I already applied and which adds:

+mti    Imagination Technologies Ltd. (formerly MIPS Technologies Inc.)

  Ralf
