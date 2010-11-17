Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Nov 2010 07:24:25 +0100 (CET)
Received: from mail-yw0-f49.google.com ([209.85.213.49]:49150 "EHLO
        mail-yw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490991Ab0KQGYV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 17 Nov 2010 07:24:21 +0100
Received: by ywf7 with SMTP id 7so997062ywf.36
        for <multiple recipients>; Tue, 16 Nov 2010 22:24:15 -0800 (PST)
Received: by 10.100.119.13 with SMTP id r13mr5893615anc.153.1289975055523;
        Tue, 16 Nov 2010 22:24:15 -0800 (PST)
Received: from angua (S01060002b3d79728.cg.shawcable.net [70.72.87.49])
        by mx.google.com with ESMTPS id w15sm6006681anw.33.2010.11.16.22.24.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 16 Nov 2010 22:24:14 -0800 (PST)
Received: by angua (Postfix, from userid 1000)
        id 474AD3C00E5; Tue, 16 Nov 2010 23:24:12 -0700 (MST)
Date:   Tue, 16 Nov 2010 23:24:12 -0700
From:   Grant Likely <grant.likely@secretlab.ca>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] of: Request module by alias in of_i2c.c
Message-ID: <20101117062412.GK12813@angua.secretlab.ca>
References: <1289947334-14375-1-git-send-email-ddaney@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1289947334-14375-1-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Return-Path: <glikely@secretlab.ca>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28405
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: grant.likely@secretlab.ca
Precedence: bulk
X-list: linux-mips

On Tue, Nov 16, 2010 at 02:42:14PM -0800, David Daney wrote:
> If we are registering an i2c device that has a device tree node like
> this real-world example:
> 
>       rtc@68 {
>         compatible = "dallas,ds1337";
>         reg = <0x68>;
>       };
> 
> of_i2c_register_devices() will try to load a module called ds1337.ko.
> There is no such module, so it will fail.  If we look in modules.alias
> we will find entries like these:
> 
> .
> .
> .
> alias i2c:ds1339 rtc_ds1307
> alias i2c:ds1338 rtc_ds1307
> alias i2c:ds1337 rtc_ds1307
> alias i2c:ds1307 rtc_ds1307
> alias i2c:ds1374 rtc_ds1374
> .
> .
> .
> 
> The module we want is really called rtc_ds1307.ko.  If we request a
> module called "i2c:ds1337", the userspace module loader will do the
> right thing (unless it is busybox) and load rtc_ds1307.ko.  So we add
> the I2C_MODULE_PREFIX to the request_module() string.
> 
> Signed-off-by: David Daney <ddaney@caviumnetworks.com>

Applied, thanks.

g.

> ---
>  drivers/of/of_i2c.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/of/of_i2c.c b/drivers/of/of_i2c.c
> index c85d3c7..f37fbeb 100644
> --- a/drivers/of/of_i2c.c
> +++ b/drivers/of/of_i2c.c
> @@ -61,7 +61,7 @@ void of_i2c_register_devices(struct i2c_adapter *adap)
>  		info.of_node = of_node_get(node);
>  		info.archdata = &dev_ad;
>  
> -		request_module("%s", info.type);
> +		request_module("%s%s", I2C_MODULE_PREFIX, info.type);
>  
>  		result = i2c_new_device(adap, &info);
>  		if (result == NULL) {
> -- 
> 1.7.2.3
> 
