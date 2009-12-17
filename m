Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Dec 2009 02:17:02 +0100 (CET)
Received: from mail-yx0-f204.google.com ([209.85.210.204]:40651 "EHLO
        mail-yx0-f204.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1495129AbZLQBQ6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Dec 2009 02:16:58 +0100
Received: by yxe42 with SMTP id 42so1757881yxe.22
        for <multiple recipients>; Wed, 16 Dec 2009 17:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=LZChG43e3BMGfGvsSrtOorcgZNTnwXYFRNSVAcPHeUc=;
        b=WnLWyCQtIKNlhcYmNFjFGi9q13xxVL/895beaNNDfsW4ethfTrUd+VBnNpfqgXi8Yg
         5ekdPXZVbTPL3H6EF5MzoxpR3eQeUaQ+H3gAR7VZlcKK+voxLGmsvGS3bI5PILAuScvs
         MYdNTtL1ckOjwb2lahS+pq3xBEVEoIl3BI99A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=edhgR2ERi9JUyIGxHYPqytMtfZOAc3QK967gVYf33h+6MoyQh6m7HVrt3UNJEKkPjx
         2tCRV5NoChTA1HQeuXv3vmLWwKmKjeebO7B/JumurAKXY8t3g67QcpQvGK4vZMD+lt9C
         0s2iGO5DAxPkRQ9HsOGEztH2tRUsTMWNXGWXc=
Received: by 10.150.102.5 with SMTP id z5mr2946046ybb.160.1261012608973;
        Wed, 16 Dec 2009 17:16:48 -0800 (PST)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 21sm558818ywh.31.2009.12.16.17.16.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 16 Dec 2009 17:16:46 -0800 (PST)
Subject: Re: [PATCH v10 5/8] Loongson: YeeLoong: add hardware monitoring
 driver
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     akpm@linux-foundation.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "Rafael J . Wysocki" <rjw@sisk.pl>, zhangfx@lemote.com,
        linux-laptop@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Pavel Machek <pavel@ucw.cz>
In-Reply-To: <d74dbb0ff251bc26556e27c21be3ce7c752776be.1260868626.git.wuzhangjin@gmail.com>
References: <d74dbb0ff251bc26556e27c21be3ce7c752776be.1260868626.git.wuzhangjin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Thu, 17 Dec 2009 09:16:10 +0800
Message-ID: <1261012570.7239.13.camel@falcon.domain.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25413
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

On Tue, 2009-12-15 at 17:24 +0800, Wu Zhangjin wrote:
> From: Wu Zhangjin <wuzhangjin@gmail.com>
> 
> This can be applied between v9 4/8 and v9 6/8.
> 
> Changes from v9 5/8:
> 
> 	o ensure the fan controlling interface is compatible with the
> 	one described in Documentation/hwmon/sysfs-interface
[...]
> +/* hwmon subdriver */
> +
> +#define MIN_FAN_SPEED 0
> +#define MAX_FAN_SPEED 3
> +
> +static int get_fan_pwm_enable(void)
> +{
> +	int level, mode;
> +
> +	level = ec_read(REG_FAN_SPEED_LEVEL);
> +	mode = ec_read(REG_FAN_AUTO_MAN_SWITCH);
> +
> +	if (level == MAX_FAN_SPEED && mode == BIT_FAN_MANUAL)
> +		mode = 0;
> +	else if (mode == BIT_FAN_MANUAL)
> +		mode = 1;
> +	else
> +		mode = 2;
> +
> +	return mode;
> +}
> +
> +static void set_fan_pwm_enable(int mode)
> +{
> +	switch (mode) {
> +	case 0:
> +		/* fullspeed */
> +		ec_write(REG_FAN_AUTO_MAN_SWITCH, BIT_FAN_MANUAL);
> +		ec_write(REG_FAN_SPEED_LEVEL, MAX_FAN_SPEED);
> +		break;
> +	case 1:
> +		ec_write(REG_FAN_AUTO_MAN_SWITCH, BIT_FAN_MANUAL);
> +		break;
> +	case 2:
> +		ec_write(REG_FAN_AUTO_MAN_SWITCH, BIT_FAN_AUTO);
> +		break;
> +	default:
> +		break;
> +	}
> +}
> +
[...]
> +
> +static int yeeloong_hwmon_init(void)
> +{
> +	int ret;
> +
> +	yeeloong_hwmon_dev = hwmon_device_register(NULL);
> +	if (IS_ERR(yeeloong_hwmon_dev)) {
> +		pr_err("Fail to register yeeloong hwmon device\n");
> +		yeeloong_hwmon_dev = NULL;
> +		return PTR_ERR(yeeloong_hwmon_dev);
> +	}
> +	ret = sysfs_create_group(&yeeloong_hwmon_dev->kobj,
> +				 &hwmon_attribute_group);
> +	if (ret) {
> +		hwmon_device_unregister(yeeloong_hwmon_dev);
> +		yeeloong_hwmon_dev = NULL;
> +		return ret;
> +	}
> +	/* ensure fan is set to auto mode */
> +	set_fan_pwm_enable(BIT_FAN_AUTO);
> +

We need to change the above line to:

set_fan_pwm_enable(2);

to ensure it is compatible to the hwmon interface too.

Best Regards,
	Wu Zhangjin
