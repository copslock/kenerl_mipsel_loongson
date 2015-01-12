Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Jan 2015 14:15:41 +0100 (CET)
Received: from mail-la0-f47.google.com ([209.85.215.47]:56265 "EHLO
        mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011228AbbALNPjKEtlV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 12 Jan 2015 14:15:39 +0100
Received: by mail-la0-f47.google.com with SMTP id hz20so23927310lab.6
        for <linux-mips@linux-mips.org>; Mon, 12 Jan 2015 05:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=CKBXNCZ9tg29w2cpC5hSkHqWyZyf5yIKFGPyv7d8umg=;
        b=bQGm4Ab/cM9d0PbuwYPKLoxM7IDJKZM7qIoo+xYLs6mwthKvb1v4czWYLxwZtpZ7r3
         diFIElx8qAUc2CUZDiLuR0M/410MlfKDKjo+SVYQWOFPRm5BoT8C4qA0yiZ9cxggQnoh
         JmailnXMz/AS8daGUO6Ux63MV0JFGQ9rwsFNsuaVLPRbstMjUb9BoKsJN4rhyMbRjx1z
         B+rDq/MrI9xHCfQx9UI1+a2pQWB1e9cO63tdCi6/K1c3kiGF5+k8qfRqL2saBV2Pluwr
         Ia2cS8qrLSPZrojbdJYUxs+t2zrqS4BcRZ2nLOPPWynhsDvti2FTRyXzhNjaGx9IpJIj
         bjCQ==
MIME-Version: 1.0
X-Received: by 10.112.61.231 with SMTP id t7mr36805573lbr.60.1421068532432;
 Mon, 12 Jan 2015 05:15:32 -0800 (PST)
Received: by 10.25.150.208 with HTTP; Mon, 12 Jan 2015 05:15:32 -0800 (PST)
In-Reply-To: <1420824103-24169-3-git-send-email-wsa@the-dreams.de>
References: <1420824103-24169-1-git-send-email-wsa@the-dreams.de>
        <1420824103-24169-3-git-send-email-wsa@the-dreams.de>
Date:   Mon, 12 Jan 2015 14:15:32 +0100
Message-ID: <CABuKBe++yut6ZfhPrsWXGA4fZRvum6WOuRxHucM0gBJCGuou5A@mail.gmail.com>
Subject: Re: [RFC 02/11] i2c: add quirk checks to core
From:   Matthias Brugger <matthias.bgg@gmail.com>
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     linux-i2c@vger.kernel.org, linux-mips@linux-mips.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ludovic Desroches <ludovic.desroches@atmel.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        linuxppc-dev@lists.ozlabs.org,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <matthias.bgg@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45087
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matthias.bgg@gmail.com
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

2015-01-09 18:21 GMT+01:00 Wolfram Sang <wsa@the-dreams.de>:
> Let the core do the checks if HW quirks prevent a transfer. Saves code
> from drivers and adds consistency.
>
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> ---
>  drivers/i2c/i2c-core.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
>
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index 39d25a8cb1ad..7b10a19abf5b 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -2063,6 +2063,56 @@ module_exit(i2c_exit);
>   * ----------------------------------------------------
>   */
>
> +/* Check if val is exceeding the quirk IFF quirk is non 0 */
> +#define i2c_quirk_exceeded(val, quirk) ((quirk) && ((val) > (quirk)))
> +
> +static int i2c_quirk_error(struct i2c_adapter *adap, struct i2c_msg *msg, char *err_msg)
> +{
> +       dev_err(&adap->dev, "quirk: %s (addr 0x%04x, size %u)\n", err_msg, msg->addr, msg->len);
> +       return -EOPNOTSUPP;
> +}
> +
> +static int i2c_check_for_quirks(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
> +{
> +       struct i2c_adapter_quirks *q = adap->quirks;
> +       u16 max_read = q->max_read_len, max_write = q->max_write_len;
> +       int max_num = q->max_num_msgs, i;
> +
> +       if (q->flags & I2C_ADAPTER_QUIRK_COMB_WRITE_THEN_READ)
> +               max_num = 2;
> +
> +       if (i2c_quirk_exceeded(num, max_num))
> +               return i2c_quirk_error(adap, &msgs[0], "too many messages");
> +
> +       if (num == 2 && q->flags & I2C_ADAPTER_QUIRK_COMB_WRITE_FIRST) {
> +               if (msgs[0].flags & I2C_M_RD)
> +                       return i2c_quirk_error(adap, &msgs[0], "invalid first write msg");
> +
> +               max_write = q->max_comb_write_len;
> +       }
> +
> +       if (num == 2 && q->flags & I2C_ADAPTER_QUIRK_COMB_READ_SECOND) {
> +               if (!(msgs[1].flags & I2C_M_RD) || msgs[0].addr != msgs[1].addr)
> +                       return i2c_quirk_error(adap, &msgs[1], "invalid second read msg");
> +
> +               max_read = q->max_comb_read_len;
> +       }
> +
> +       for (i = 0; i < num; i++) {
> +               u16 len = msgs[i].len;
> +
> +               if (msgs[i].flags & I2C_M_RD) {
> +                       if (i2c_quirk_exceeded(len, max_read))
> +                               return i2c_quirk_error(adap, &msgs[i], "msg too long");
> +               } else {
> +                       if (i2c_quirk_exceeded(len, max_write))
> +                               return i2c_quirk_error(adap, &msgs[i], "msg too long");
> +               }

What about being more verbose in the error message, specifying if it
was a read or a write message that failed?

> +       }
> +
> +       return 0;
> +}
> +
>  /**
>   * __i2c_transfer - unlocked flavor of i2c_transfer
>   * @adap: Handle to I2C bus
> @@ -2080,6 +2130,9 @@ int __i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
>         unsigned long orig_jiffies;
>         int ret, try;
>
> +       if (adap->quirks && i2c_check_for_quirks(adap, msgs, num))
> +               return -EOPNOTSUPP;
> +
>         /* i2c_trace_msg gets enabled when tracepoint i2c_transfer gets
>          * enabled.  This is an efficient way of keeping the for-loop from
>          * being executed when not needed.
> --
> 2.1.3
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel



-- 
motzblog.wordpress.com
