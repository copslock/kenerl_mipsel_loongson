Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Nov 2007 19:54:04 +0000 (GMT)
Received: from fk-out-0910.google.com ([209.85.128.191]:47540 "EHLO
	fk-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20030837AbXKRTx4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 18 Nov 2007 19:53:56 +0000
Received: by fk-out-0910.google.com with SMTP id f40so1610986fka
        for <linux-mips@linux-mips.org>; Sun, 18 Nov 2007 11:53:45 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=4eqgswGYp8+TtFsfxDHJ6pLX9+0pdahjmenOToXJbMI=;
        b=SdAtqDyrty/MtSJtxe/YUFsnnpz0tMNUpX+XjcruGblizu9qx+bmDrhJ5AP710oshloK5w1msX3RPBkhcQNT+rdBj/VKFq+qATqjiSGcdBJJ0ACV3nGYuZ3NBnaicYYHspm4jYHPimMqQZwRV4/scB/Kd3bDCNoK1AivNQYt7ik=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=HBpJ+JlWJ0aFtkx7goRkqioikKss9SK5hAadk6+uBoJ1OR2M/gSno0dIoU0CXqjxXyeyG1G8IgjfHTwOl8vkR0vg2/gMg7NYuiFYZXucUfIutN7nv8Chih6cuPIpIw4DQw1eHeOxMVnCb1S8aNbRGj6C5eNTsy/LNYIgILUiVpk=
Received: by 10.82.134.12 with SMTP id h12mr11695991bud.1195415624868;
        Sun, 18 Nov 2007 11:53:44 -0800 (PST)
Received: from ?192.168.0.1? ( [82.235.205.153])
        by mx.google.com with ESMTPS id w7sm10309495mue.2007.11.18.11.53.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 18 Nov 2007 11:53:44 -0800 (PST)
Message-ID: <4740983D.6020408@gmail.com>
Date:	Sun, 18 Nov 2007 20:53:33 +0100
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
MIME-Version: 1.0
To:	Steve Brown <sbrown@cortland.com>
CC:	linux-mips@linux-mips.org
Subject: Re: ohci-ssb driver on a Broadcom BCM5354
References: <47408305.5090804@cortland.com>
In-Reply-To: <47408305.5090804@cortland.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17526
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Steve Brown wrote:
> The 5354 has a dual ohci/ehci usb core. It's in an ASUS WL520gu wifi
> router. The ohci hcd driver registers, but times out reading a
> descriptor from the device.
> 

You'd better post this to linux-usb-devel@lists.sourceforge.net

> Any suggestions on how to track down the problem?
> 

CONFIG_USB_DEBUG=y

and

usbmon perhaps.

		Franck
