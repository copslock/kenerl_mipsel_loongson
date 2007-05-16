Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 May 2007 14:38:38 +0100 (BST)
Received: from smtp-103-wednesday.nerim.net ([62.4.16.103]:7181 "EHLO
	kraid.nerim.net") by ftp.linux-mips.org with ESMTP
	id S20023279AbXEPNif (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 16 May 2007 14:38:35 +0100
Received: from hyperion.delvare (jdelvare.pck.nerim.net [62.212.121.182])
	by kraid.nerim.net (Postfix) with ESMTP id C1EC440FAD;
	Wed, 16 May 2007 15:38:16 +0200 (CEST)
Date:	Wed, 16 May 2007 15:38:22 +0200
From:	Jean Delvare <khali@linux-fr.org>
To:	Manuel Lauss <mano@roarinelk.homelinux.net>
Cc:	i2c@lm-sensors.org, linux-mips@linux-mips.org,
	Domen Puncer <domen.puncer@ultra.si>
Subject: Re: [PATCH 1/2] i2c-au1550: send i2c stop on error #2
Message-ID: <20070516153822.176cbd68@hyperion.delvare>
In-Reply-To: <20070516053113.GA12986@roarinelk.homelinux.net>
References: <20070516053113.GA12986@roarinelk.homelinux.net>
X-Mailer: Sylpheed-Claws 2.5.5 (GTK+ 2.10.6; x86_64-suse-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <khali@linux-fr.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15069
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: khali@linux-fr.org
Precedence: bulk
X-list: linux-mips

Hi Manuel,

On Wed, 16 May 2007 07:31:13 +0200, Manuel Lauss wrote:
> When the au1550 i2c driver encounteres an error while addressing a slave
> or has no data to send to a slave in the last i2c message, it returns to
> the upper layers without issuing a i2c stop condition.  This for example
> resulted in the minute register of the RTC on my board to be overwritten
> with a random value on a following transfer.
> 
> Fix the driver to send a stop over the i2c bus if one of the following
> 2 conditions are met:
> * error when addressing a slave
> * no data to send in the last i2c message
> 
> Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
> 
> --- a/drivers/i2c/busses/i2c-au1550.c	2007-04-26 05:08:32.000000000 +0200
> +++ b/drivers/i2c/busses/i2c-au1550.c	2007-05-15 20:19:56.000000000 +0200
> @@ -260,13 +260,20 @@ static int
>  au1550_xfer(struct i2c_adapter *i2c_adap, struct i2c_msg *msgs, int num)
>  {
>  	struct i2c_au1550_data *adap = i2c_adap->algo_data;
> +	volatile psc_smb_t *sp = (volatile psc_smb_t *)(adap->psc_base);
>  	struct i2c_msg *p;
>  	int i, err = 0;
>  
>  	for (i = 0; !err && i < num; i++) {
>  		p = &msgs[i];
>  		err = do_address(adap, p->addr, p->flags & I2C_M_RD);
> -		if (err || !p->len)
> +		if (err || ((!p->len) && (i == (num - 1)))) {
> +			sp->psc_smbtxrx = PSC_SMBTXRX_STP;
> +			au_sync();
> +			wait_master_done(adap);
> +			continue;
> +		}
> +		if (!p->len)
>  			continue;
>  		if (p->flags & I2C_M_RD)
>  			err = i2c_read(adap, p->buf, p->len);

Good catch. I'd have two comments though:

1* It looks to me like there are other error conditions which also
cause the driver to leave without issuing a stop condition on the bus:
if not all bytes of a write are acked by the target slave (in
i2c_write) or if the master receives less bytes than expected (in
i2c_read). I understand these are less likely to happen than the quick
write case which bit you, but shouldn't these bugs be fixed as well?

2* In i2c_write and i2c_read, the stop bit is always sent together with
the last byte, while your new code sends the stop bit on its own after
the address byte. Is it OK? I am wondering if your code isn't sending
an extra (0) byte after the address when asked to send a zero-byte
message. That would be bad. Do you have a bus analyzer or scope to
check what exactly is being sent on the bus in this case?

Domen, care to comment on this patch and/or my own comments?

Thanks,
-- 
Jean Delvare
