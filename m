Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Nov 2014 18:33:14 +0100 (CET)
Received: from mail-wi0-f176.google.com ([209.85.212.176]:56286 "EHLO
        mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013907AbaKRRdMVQizu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 18 Nov 2014 18:33:12 +0100
Received: by mail-wi0-f176.google.com with SMTP id ex7so2686729wid.9
        for <linux-mips@linux-mips.org>; Tue, 18 Nov 2014 09:33:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:from:subject:to:cc:in-reply-to:references
         :date:message-id;
        bh=DMZ6nWeDLGoRaF1+jvZd6d+roJjHfyUrMPBdRUa//lc=;
        b=XbWkeld1TLjepLGv8hXDken6TZ+03T/mlurp72g9rzd/2KsdskGfeWJMRSXtdqIkJw
         EXTCOcKZSOp3TVNyXtD6SzKpAPTFGiX8ZL6mjAF/g3U0UnY9KbGV00AmY/qXYYQRJc2t
         qdedGmtJWgp5EvpFrKrTnCR/yuQzFOkgDEcbbJ3Sqdu50eWsiPyzcKoPU4t3ovzp/iT5
         hwATSwGnpROq20aHZWiyq26ouvT1XDvHdFisYId6y/2VIe4Q4BetzGnaPmjEji4SWMjf
         CV4RIdcZCqguE3Yd1z1ng2is/tkC4LClci3Hltpo3ef5oEHvByKthThvscpO9u5nhyyM
         ha1g==
X-Gm-Message-State: ALoCoQl5s5EoPO7QDRg7/3xgPoXH8pBMvyAw0fm/in9a2lfjY5DMwyJH3+/ATP+akMBKE7w0Xv7a
X-Received: by 10.194.222.98 with SMTP id ql2mr50165726wjc.10.1416331986780;
        Tue, 18 Nov 2014 09:33:06 -0800 (PST)
Received: from trevor.secretlab.ca (host86-166-84-117.range86-166.btcentralplus.com. [86.166.84.117])
        by mx.google.com with ESMTPSA id f7sm20368171wiz.13.2014.11.18.09.33.05
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Nov 2014 09:33:05 -0800 (PST)
Received: by trevor.secretlab.ca (Postfix, from userid 1000)
        id A0490C40966; Tue, 18 Nov 2014 17:33:03 +0000 (GMT)
From:   Grant Likely <grant.likely@linaro.org>
Subject: Re: [PATCH V2 04/10] of: Change of_device_is_available() to return
 bool
To:     Kevin Cernekee <cernekee@gmail.com>, gregkh@linuxfoundation.org,
        jslaby@suse.cz, robh@kernel.org
Cc:     arnd@arndb.de, daniel@zonque.org, haojian.zhuang@gmail.com,
        robert.jarzmik@free.fr, f.fainelli@gmail.com, mbizon@freebox.fr,
        jogo@openwrt.org, linux-mips@linux-mips.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <1415825647-6024-5-git-send-email-cernekee@gmail.com>
References: <1415825647-6024-1-git-send-email-cernekee@gmail.com>
        <1415825647-6024-5-git-send-email-cernekee@gmail.com>
Date:   Tue, 18 Nov 2014 17:33:03 +0000
Message-Id: <20141118173303.A0490C40966@trevor.secretlab.ca>
Return-Path: <glikely@secretlab.ca>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44274
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

On Wed, 12 Nov 2014 12:54:01 -0800
, Kevin Cernekee <cernekee@gmail.com>
 wrote:
> This function can only return true or false; using a bool makes it more
> obvious to the reader.
> 
> Signed-off-by: Kevin Cernekee <cernekee@gmail.com>

Applied, thanks.

g.

> ---
>  drivers/of/base.c  | 22 +++++++++++-----------
>  include/linux/of.h |  6 +++---
>  2 files changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index 707395c..81c095f 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -507,27 +507,27 @@ EXPORT_SYMBOL(of_machine_is_compatible);
>   *
>   *  @device: Node to check for availability, with locks already held
>   *
> - *  Returns 1 if the status property is absent or set to "okay" or "ok",
> - *  0 otherwise
> + *  Returns true if the status property is absent or set to "okay" or "ok",
> + *  false otherwise
>   */
> -static int __of_device_is_available(const struct device_node *device)
> +static bool __of_device_is_available(const struct device_node *device)
>  {
>  	const char *status;
>  	int statlen;
>  
>  	if (!device)
> -		return 0;
> +		return false;
>  
>  	status = __of_get_property(device, "status", &statlen);
>  	if (status == NULL)
> -		return 1;
> +		return true;
>  
>  	if (statlen > 0) {
>  		if (!strcmp(status, "okay") || !strcmp(status, "ok"))
> -			return 1;
> +			return true;
>  	}
>  
> -	return 0;
> +	return false;
>  }
>  
>  /**
> @@ -535,13 +535,13 @@ static int __of_device_is_available(const struct device_node *device)
>   *
>   *  @device: Node to check for availability
>   *
> - *  Returns 1 if the status property is absent or set to "okay" or "ok",
> - *  0 otherwise
> + *  Returns true if the status property is absent or set to "okay" or "ok",
> + *  false otherwise
>   */
> -int of_device_is_available(const struct device_node *device)
> +bool of_device_is_available(const struct device_node *device)
>  {
>  	unsigned long flags;
> -	int res;
> +	bool res;
>  
>  	raw_spin_lock_irqsave(&devtree_lock, flags);
>  	res = __of_device_is_available(device);
> diff --git a/include/linux/of.h b/include/linux/of.h
> index 29f0adc..7aaaa59 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -275,7 +275,7 @@ extern int of_property_read_string_helper(struct device_node *np,
>  					      const char **out_strs, size_t sz, int index);
>  extern int of_device_is_compatible(const struct device_node *device,
>  				   const char *);
> -extern int of_device_is_available(const struct device_node *device);
> +extern bool of_device_is_available(const struct device_node *device);
>  extern const void *of_get_property(const struct device_node *node,
>  				const char *name,
>  				int *lenp);
> @@ -426,9 +426,9 @@ static inline int of_device_is_compatible(const struct device_node *device,
>  	return 0;
>  }
>  
> -static inline int of_device_is_available(const struct device_node *device)
> +static inline bool of_device_is_available(const struct device_node *device)
>  {
> -	return 0;
> +	return false;
>  }
>  
>  static inline struct property *of_find_property(const struct device_node *np,
> -- 
> 2.1.1
> 
