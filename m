Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Aug 2013 21:35:41 +0200 (CEST)
Received: from mail-pb0-f46.google.com ([209.85.160.46]:53113 "EHLO
        mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6865310Ab3HITfHYE0FO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 9 Aug 2013 21:35:07 +0200
Received: by mail-pb0-f46.google.com with SMTP id rq2so4880042pbb.19
        for <linux-mips@linux-mips.org>; Fri, 09 Aug 2013 12:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=k1f9ZMo2XTmS0QR776N4PQZB8zWekjaozi0608VAY/8=;
        b=lTL1XDZzVIZPm76QQ3CRN/RDIc/aJGX03SKGi7TSYTZaPJ6XAysm7DLros8lLywh6N
         YZgNqtku6C3PJbfSxZ4Yz/reKmy3IkwtH2LVRS8pRl3KZvC8qHzZYs1Ocz2BYrjz+rX3
         50FTDYA/Q4NYlalmZ/fSZJHIJRf8ooK/9lArAoc4x0qSbetCSZz+q5b5vQ2ynmsbVHJb
         Xht6LpB3cKRK8zZnmJZGfLYrJJDG0toRASeyjwKvPHn6bvDMeVjsdfLszalGU9KTJ0Yr
         zwt/tHE3dFZBOK3UE4ssM9nlMN8hQVFSADKWq9O1ZCssvX5+ttwnLDYFHm/Uhfu8bI2u
         Fijg==
X-Received: by 10.68.106.67 with SMTP id gs3mr13041692pbb.126.1376076901063;
        Fri, 09 Aug 2013 12:35:01 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by mx.google.com with ESMTPSA id kc8sm21664323pbc.18.2013.08.09.12.34.59
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 09 Aug 2013 12:35:00 -0700 (PDT)
Date:   Fri, 9 Aug 2013 12:34:59 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     John Crispin <blogic@openwrt.org>
Cc:     Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
        linux-mips@linux-mips.org, devicetree-discuss@lists.ozlabs.org
Subject: Re: [PATCH V3 1/2] DT: Add documentation for rt2880-wdt
Message-ID: <20130809193459.GE10417@roeck-us.net>
References: <1376074831-29561-1-git-send-email-blogic@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1376074831-29561-1-git-send-email-blogic@openwrt.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <groeck7@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37507
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
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

On Fri, Aug 09, 2013 at 09:00:31PM +0200, John Crispin wrote:
> This document describes the binding of the watchdog core found ralink wireless
> SoC.
> 
> Signed-off-by: John Crispin <blogic@openwrt.org>
> Cc: linux-watchdog@vger.kernel.org
> Cc: linux-mips@linux-mips.org
> Cc: devicetree-discuss@lists.ozlabs.org

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
> Changes in V3:
> * renamed file to rt2880-wdt.txt
> 
>  .../devicetree/bindings/watchdog/rt2880-wdt.txt     |   19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/rt2880-wdt.txt
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/rt2880-wdt.txt b/Documentation/devicetree/bindings/watchdog/rt2880-wdt.txt
> new file mode 100644
> index 0000000..a654dd1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/rt2880-wdt.txt
> @@ -0,0 +1,19 @@
> +Ralink Watchdog Timers
> +
> +Required properties :
> +- compatible: must be "ralink,rt2880-wdt"
> +- reg: physical base address of the controller and length of the register range
> +
> +Optional properties :
> +- interrupt-parent: phandle to the INTC device node
> +- interrupts: Specify the INTC interrupt number
> +
> +Example:
> +
> +	watchdog@120 {
> +		compatible = "ralink,rt2880-wdt";
> +		reg = <0x120 0x10>;
> +
> +		interrupt-parent = <&intc>;
> +		interrupts = <1>;
> +	};
> -- 
> 1.7.10.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
