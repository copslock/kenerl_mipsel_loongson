Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Jun 2009 19:10:53 +0100 (WEST)
Received: from mail-ew0-f219.google.com ([209.85.219.219]:41286 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20024925AbZFASKZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 1 Jun 2009 19:10:25 +0100
Received: by mail-ew0-f219.google.com with SMTP id 19so8322936ewy.0
        for <multiple recipients>; Mon, 01 Jun 2009 11:10:25 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=AccaS+fTlj6++G5XmP1ONYqiJmjbGt6kDwo8vc9Dqmc=;
        b=K6XhOq0nSzPSlEnvntDnn6g5mOAKbDIJiNvQE326OdcphRC1hjKs5cqhXmwN7CwUzB
         H+IFRruGHzg48MBkfwM2ijkj7NpAAiOjqAChvfM8kaBRADiI3oot3WLinnaV+LK3AXSG
         97ISpYSMmlTKhRfDKaTLD2hJ93uw8bl5aZ+TE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=rPs3O6Q//js3re5mG6izmt9KogN2YxMHScDhRPb4dPnCyyz2GcWBl6lqQRXB6bRyV5
         dH9zxtVgO0Y6ApFLDlIxYqgiBAYVg0pDiAL9BGXQ/wqBhqrkqcPNZTWrH81JXTrpEL+X
         3ZV6NmLg6xm1DOTpRkGD/IkxzuZvxoiMo7ZSY=
Received: by 10.210.91.7 with SMTP id o7mr6709921ebb.76.1243879825010;
        Mon, 01 Jun 2009 11:10:25 -0700 (PDT)
Received: from florian (207.130.195-77.rev.gaoland.net [77.195.130.207])
        by mx.google.com with ESMTPS id 5sm15666eyh.10.2009.06.01.11.10.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 01 Jun 2009 11:10:23 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
To:	Maxime Bizon <mbizon@freebox.fr>
Subject: Re: [PATCH 04/10] bcm63xx: limit number of usb port to 1.
Date:	Mon, 1 Jun 2009 20:10:21 +0200
User-Agent: KMail/1.9.9
Cc:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
References: <1243876918-9905-1-git-send-email-mbizon@freebox.fr> <1243876918-9905-5-git-send-email-mbizon@freebox.fr>
In-Reply-To: <1243876918-9905-5-git-send-email-mbizon@freebox.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200906012010.21712.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23145
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Le Monday 01 June 2009 19:21:52 Maxime Bizon, vous avez écrit :
> This patch disables the use of more than one USB port. Hardware has
> two ports, but one may be shared with USB slave port.
>
> Until we have this information in the platform data, don't use the
> second port.
>
> Signed-off-by: Maxime Bizon <mbizon@freebox.fr>

Acked-by: Florian Fainelli <florian@openwrt.org>

> ---
>  drivers/usb/host/ohci-bcm63xx.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/usb/host/ohci-bcm63xx.c
> b/drivers/usb/host/ohci-bcm63xx.c index 08807d9..74f432f 100644
> --- a/drivers/usb/host/ohci-bcm63xx.c
> +++ b/drivers/usb/host/ohci-bcm63xx.c
> @@ -20,6 +20,8 @@ static int __devinit ohci_bcm63xx_start(struct usb_hcd
> *hcd) struct ohci_hcd *ohci = hcd_to_ohci(hcd);
>  	int ret;
>
> +	ohci->num_ports = 1;
> +
>  	ret = ohci_init(ohci);
>  	if (ret < 0)
>  		return ret;



-- 
Best regards, Florian Fainelli
Email : florian@openwrt.org
http://openwrt.org
-------------------------------
