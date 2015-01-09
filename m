Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Jan 2015 20:35:41 +0100 (CET)
Received: from mail-lb0-f169.google.com ([209.85.217.169]:65022 "EHLO
        mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010654AbbAITfgpAtL0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 9 Jan 2015 20:35:36 +0100
Received: by mail-lb0-f169.google.com with SMTP id p9so9744187lbv.0
        for <linux-mips@linux-mips.org>; Fri, 09 Jan 2015 11:35:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:organization:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=VScY4SzxDZ43s6/vTU2r6TREDvcjfkUPpAUeb0LrE3s=;
        b=VmJQuHMViApQJz7YZyaZZ7jwlzlgWQiRcpNFMs54aaCmLvLW8caDdpJAcPD0U/1XvI
         2Zb4tsX9iwq0rE/npZcl6T9n/4BAEzRYqa+zrRkYBajXXHhYyCuLUs42dZD8SQ2H4plC
         bvTsoLFQfT9+P3izCaEj7lEnRXrXBqak2j5DGH3scK/IXt8dPN1DXY9k5KtIrTCyqFz5
         y9T3s29tlJbeJG/MBV+zxjvpVwmKxIDauliAs5V2cmsbfugPSwTIYoiGd7pv+JQfpmbC
         nT2H+k2igaF3Nc3Tim5yvTzUM31pT/i4IJSowxxPuIs8CvtsHNIMUs+LdBuwoQ8pPm5H
         Fd3w==
X-Gm-Message-State: ALoCoQloMyTxSNP2GbNPbHf9DXB7n7+oqfXen98N6R8fqDxHVF7HiJzggy4H/TgOhavDza1vp1Rd
X-Received: by 10.112.161.35 with SMTP id xp3mr23670439lbb.70.1420832131236;
        Fri, 09 Jan 2015 11:35:31 -0800 (PST)
Received: from wasted.cogentembedded.com (ppp20-191.pppoe.mtu-net.ru. [81.195.20.191])
        by mx.google.com with ESMTPSA id i5sm2055676lae.26.2015.01.09.11.35.29
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Jan 2015 11:35:30 -0800 (PST)
Message-ID: <54B02D7F.7040501@cogentembedded.com>
Date:   Fri, 09 Jan 2015 22:35:27 +0300
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
MIME-Version: 1.0
To:     Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
CC:     linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-mips@linux-mips.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ludovic Desroches <ludovic.desroches@atmel.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC 02/11] i2c: add quirk checks to core
References: <1420824103-24169-1-git-send-email-wsa@the-dreams.de> <1420824103-24169-3-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1420824103-24169-3-git-send-email-wsa@the-dreams.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45039
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sergei.shtylyov@cogentembedded.com
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

Hello.

On 01/09/2015 08:21 PM, Wolfram Sang wrote:

> Let the core do the checks if HW quirks prevent a transfer. Saves code
> from drivers and adds consistency.

> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> ---
>   drivers/i2c/i2c-core.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 53 insertions(+)
>
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index 39d25a8cb1ad..7b10a19abf5b 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -2063,6 +2063,56 @@ module_exit(i2c_exit);
>    * ----------------------------------------------------
>    */
>
> +/* Check if val is exceeding the quirk IFF quirk is non 0 */
> +#define i2c_quirk_exceeded(val, quirk) ((quirk) && ((val) > (quirk)))
> +
> +static int i2c_quirk_error(struct i2c_adapter *adap, struct i2c_msg *msg, char *err_msg)
> +{
> +	dev_err(&adap->dev, "quirk: %s (addr 0x%04x, size %u)\n", err_msg, msg->addr, msg->len);
> +	return -EOPNOTSUPP;
> +}

    Always returning the same value doesn't make much sense. Are you trying to 
save space on the call sites?

[...]
> @@ -2080,6 +2130,9 @@ int __i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
>   	unsigned long orig_jiffies;
>   	int ret, try;
>
> +	if (adap->quirks && i2c_check_for_quirks(adap, msgs, num))

    So, you only check for non-zero result of this function? Perhaps it makes 
sense to return true/false instead?

> +		return -EOPNOTSUPP;
> +

WBR, Sergei
