Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 May 2008 03:46:11 +0100 (BST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:50100 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20030198AbYELCqJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 12 May 2008 03:46:09 +0100
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [213.58.128.207]) with ESMTP; Mon, 12 May 2008 11:46:06 +0900
Received: from localhost (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with SMTP id 7F6A91EF48;
	Mon, 12 May 2008 11:46:01 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 7FDC11EF48;
	Mon, 12 May 2008 11:45:53 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id m4C2jiAF099220;
	Mon, 12 May 2008 11:45:47 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Mon, 12 May 2008 11:45:44 +0900 (JST)
Message-Id: <20080512.114544.41629483.nemoto@toshiba-tops.co.jp>
To:	macro@linux-mips.org
Cc:	khali@linux-fr.org, david-b@pacbell.net, a.zummo@towertech.it,
	ab@mycable.de, anemo@mba.ocn.ne.jp, i2c@lm-sensors.org,
	rtc-linux@googlegroups.com, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 4/4] RTC: SMBus support for the M41T80
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <Pine.LNX.4.55.0805110045010.18978@cliff.in.clinika.pl>
References: <Pine.LNX.4.55.0805100116290.10552@cliff.in.clinika.pl>
	<20080510103544.701c7b3f@hyperion.delvare>
	<Pine.LNX.4.55.0805110045010.18978@cliff.in.clinika.pl>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19202
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Sun, 11 May 2008 02:59:34 +0100 (BST), "Maciej W. Rozycki" <macro@linux-mips.org> wrote:
>  If we agree on this one, I will retest and submit the whole batch again,
> updated as needed.

Works OK for me (m41t80 + i2c-gpio).

Tested-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

One minor style comment.

> +	if (i2c_check_functionality(client->adapter,
> +				    I2C_FUNC_SMBUS_WRITE_I2C_BLOCK)) {
> +		i = i2c_smbus_write_i2c_block_data(client, reg, num, buf);
> +	} else {
> +		for (i = 0; i < num; i++) {
> +			rc = i2c_smbus_write_byte_data(client, reg + i,
> +						       buf[i]);
> +			if (rc < 0) {
> +				i = rc;
> +				goto out;
> +			}
> +		}
>  	}
> +out:
> +	return i;

This part can be a bit shorter.

	if (i2c_check_functionality(client->adapter,
				    I2C_FUNC_SMBUS_WRITE_I2C_BLOCK))
		return i2c_smbus_write_i2c_block_data(client, reg, num, buf);
	for (i = 0; i < num; i++) {
		rc = i2c_smbus_write_byte_data(client, reg + i, buf[i]);
		if (rc < 0)
			return rc;
	}
	return i;

Saves 6 lines.  Not a big issue.

---
Atsushi Nemoto
