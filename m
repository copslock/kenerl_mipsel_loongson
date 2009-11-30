Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Nov 2009 06:18:56 +0100 (CET)
Received: from mail-pw0-f45.google.com ([209.85.160.45]:37728 "EHLO
        mail-pw0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491061AbZK3FSx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 30 Nov 2009 06:18:53 +0100
Received: by pwi15 with SMTP id 15so2038061pwi.24
        for <multiple recipients>; Sun, 29 Nov 2009 21:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=MxPtv0zZOnbIkmtXl+h8vFRxkgZssuc52Jr0DWR3avk=;
        b=S4n5t2+WOr7SzNXfFCRIwAK9sxocD5YZ5xM5LY9gnObvYyiD+m7gtCu/OImSxXXqIG
         Z1UttfjC8KjRmgZ3IWodZbucZvlm0KA7EDw1sCZ/RR3Lul//kDQLuOyNWKJqZzCSWeDi
         iPt9KcHg+XA9mSk6oLqyFNZZqhv+VwvhC0tJY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=ZO2QtsH2fw28m7uQxKhubABTzhwzcluI9kFIE/JyMg/3t2i8U27tNKyTCRkEL+8TZ4
         jTw+FfUUe9GtiGVB419lsIgAc7dtaxZOOgJ6NqugPRXuD3Dq5IppfnRYUxy3MdrrDyRJ
         dG3ytK5BuOW7DDo+1Ci3mydDa9Z+vsCm25kKE=
Received: by 10.114.83.17 with SMTP id g17mr6497111wab.38.1259558323474;
        Sun, 29 Nov 2009 21:18:43 -0800 (PST)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 22sm2739388pzk.10.2009.11.29.21.18.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 29 Nov 2009 21:18:42 -0800 (PST)
Subject: Re: [PATCH v5 8/8] Loongson: YeeLoong: add hotkey driver
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-mips@linux-mips.org, zhangfx@lemote.com, yanh@lemote.com,
        huhb@lemote.com, linux-input@vger.kernel.org
In-Reply-To: <739db9c7b5bab429d0df5a7c68f301aa12f1402d.1259414649.git.wuzhangjin@gmail.com>
References: <cover.1259414649.git.wuzhangjin@gmail.com>
         <739db9c7b5bab429d0df5a7c68f301aa12f1402d.1259414649.git.wuzhangjin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Mon, 30 Nov 2009 13:18:15 +0800
Message-ID: <1259558295.5516.5.camel@falcon.domain.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25201
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Sat, 2009-11-28 at 21:44 +0800, Wu Zhangjin wrote:
[...]
> +
> +static int camera_handler(int status)
> +{
> +	int value;
> +	static int camera_status;
> +
> +	status = !!status;
> +	camera_status = ec_read(REG_CAMERA_STATUS);
> +	if (status != camera_status) {
> +		value = ec_read(REG_CAMERA_CONTROL);
> +		ec_write(REG_CAMERA_CONTROL, value | (1 << 1));
> +	}
> +	return ec_read(REG_CAMERA_STATUS);
> +}

The above stuff is very awful, the camera event work as a switch, so
this is enough:

static int camera_handler(int status)
{
	int value;

	value = ec_read(REG_CAMERA_CONTROL);
	ec_write(REG_CAMERA_CONTROL, value | (1 << 1));

	return status;
}

[...]
> +/*
> + * SCI(system control interrupt) main interrupt routine
> + *
> + * We will do the query and get event number together so the interrupt routine
> + * should be longer than 120us now at least 3ms elpase for it.
> + */
> +static irqreturn_t sci_irq_handler(int irq, void *dev_id)
> +{
> +	int ret;
> +
> +	if (SCI_IRQ_NUM != irq)
> +		return IRQ_NONE;
> +
> +	/* Query the event number */
> +	ret = ec_query_event_num();
> +	if (ret < 0)
> +		return IRQ_NONE;
> +
> +	event = ec_get_event_num();
> +	if (event < 0)
> +		return IRQ_NONE;
> +
> +	if ((event != 0x00) && (event != 0xff)) {

It's better to use somethig else:

if (event >= EVENT_START && event <= EVENT_END) {
....

Best Regards,
	Wu Zhangjin
