Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Nov 2014 22:21:11 +0100 (CET)
Received: from mail-wg0-f46.google.com ([74.125.82.46]:38871 "EHLO
        mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013420AbaKLVUv03Q0Y (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 Nov 2014 22:20:51 +0100
Received: by mail-wg0-f46.google.com with SMTP id x13so15384564wgg.33
        for <linux-mips@linux-mips.org>; Wed, 12 Nov 2014 13:20:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:from:subject:to:cc:in-reply-to:references
         :date:message-id;
        bh=CBOhiQqIOKw3hksM+MKa3tF8Qyn7QLMosP8FDszFMPY=;
        b=coLViYM+CR0C6rOKfEp7r+/1klcXTK49huzUbjF8IYGWh5Whi6AjEJ7bTtu+TBfKIx
         ZeFQYwrvkb+3Rx5HXGLVPBW7ZSVpyBYnS57b2N6AFZB+7tolgfAn3BvOB3i2zkvelWEI
         FN9Ana54XzGzezKmE0yc7rLID0IY0UhFZ8DjmdCeYq5wNIRRQja21jmoJgcoyHyt0Wwd
         Z3ukPJ6dIim+hTxcFL5aisBOD6SB3HJWScr1Qag7hn8tSoS5YxuJxhlPaEUAXL/bxKug
         UDWtF8N3M0NxcIwPFhw06FSYWWucggkXOz7cQtIw8QxTwbg6XcIIVANPoPcZ1yipVHWy
         g+lw==
X-Gm-Message-State: ALoCoQm1t+ivmddl6DGDPes2Myg/lTwVeMpMUoP7lkQ5dlA4jYGMZ6gfJWiHIRZub6RXPcymVjru
X-Received: by 10.194.60.45 with SMTP id e13mr68027282wjr.109.1415827246172;
        Wed, 12 Nov 2014 13:20:46 -0800 (PST)
Received: from trevor.secretlab.ca (host86-166-83-112.range86-166.btcentralplus.com. [86.166.83.112])
        by mx.google.com with ESMTPSA id bj7sm32916003wjc.33.2014.11.12.13.20.43
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Nov 2014 13:20:44 -0800 (PST)
Received: by trevor.secretlab.ca (Postfix, from userid 1000)
        id 49BE5C41C69; Wed, 12 Nov 2014 17:11:10 +0000 (GMT)
From:   Grant Likely <grant.likely@linaro.org>
Subject: Re: [PATCH 1/2] of: Fix crash if an earlycon driver is not found
To:     Kevin Cernekee <cernekee@gmail.com>, gregkh@linuxfoundation.org,
        jslaby@suse.cz, robh@kernel.org
Cc:     f.fainelli@gmail.com, mbizon@freebox.fr, jogo@openwrt.org,
        linux-mips@linux-mips.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <1415523348-4631-1-git-send-email-cernekee@gmail.com>
References: <1415523348-4631-1-git-send-email-cernekee@gmail.com>
Date:   Wed, 12 Nov 2014 17:11:10 +0000
Message-Id: <20141112171110.49BE5C41C69@trevor.secretlab.ca>
Return-Path: <glikely@secretlab.ca>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44089
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: grant.likely@linaro.org
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

On Sun,  9 Nov 2014 00:55:47 -0800
, Kevin Cernekee <cernekee@gmail.com>
 wrote:
> __earlycon_of_table_sentinel.compatible is a char[128], not a pointer, so
> it will never be NULL.  Checking it against NULL causes the match loop to
> run past the end of the array, and eventually match a bogus entry, under
> the following conditions:
> 
>  - Kernel command line specifies "earlycon" with no parameters
>  - DT has a stdout-path pointing to a UART node
>  - The UART driver doesn't use OF_EARLYCON_DECLARE (or maybe the console
>    driver is compiled out)
> 
> Fix this by checking to see if match->compatible is a non-empty string.
> 
> Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
> Cc: <stable@vger.kernel.org> # 3.16+

Applied, thanks. Although a more robust fix would probably to be
checking for the end address of the section. This is a safe fix though,
so I'm picking it up.

g.

> ---
>  drivers/of/fdt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index d1ffca8..30e97bc 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -773,7 +773,7 @@ int __init early_init_dt_scan_chosen_serial(void)
>  	if (offset < 0)
>  		return -ENODEV;
>  
> -	while (match->compatible) {
> +	while (match->compatible[0]) {
>  		unsigned long addr;
>  		if (fdt_node_check_compatible(fdt, offset, match->compatible)) {
>  			match++;
> -- 
> 2.1.1
> 
