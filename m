Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Nov 2008 17:45:25 +0000 (GMT)
Received: from yx-out-1718.google.com ([74.125.44.156]:3880 "EHLO
	yx-out-1718.google.com") by ftp.linux-mips.org with ESMTP
	id S23910656AbYKYRpR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 25 Nov 2008 17:45:17 +0000
Received: by yx-out-1718.google.com with SMTP id 36so42099yxh.24
        for <linux-mips@linux-mips.org>; Tue, 25 Nov 2008 09:45:14 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id:sender;
        bh=Fdwj9ospdCgdwgogyBKIGOI/KjtEN135eKBff0ACJIc=;
        b=xR0570QPy7tMZXPr8DKTG7+GYnfV5Umxo7btI+hl0drRfGl/HdrpI7jqOw4huBsnJE
         8GnSxhIxgj8i2sSbE/Ue6qi01ifNuByylkFQpH48dcrepNUeEQJfnMlkBvMgeKU3JsTX
         t8tYUJ2LJ7Xc2Fr/OwzDm6aN+wLIjlgDM53SQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id:sender;
        b=xU3MlNdPHyuZkIAjidRIwoAi7TYLGStt/ggEmu3tJRz9ufnFgzbOTsPoPC6/RmS8z8
         M6HhzQtf6ptsfnB7HxiNH25FyXvlpFIGicFqyRO3gw3uLafyBRF0fvmVmYiiPyjsE1K9
         kQIKSjswGnNi2JTnd5WzUKS9hGLsBcsj8cIBU=
Received: by 10.103.171.6 with SMTP id y6mr1710648muo.31.1227635113263;
        Tue, 25 Nov 2008 09:45:13 -0800 (PST)
Received: from flowlan.maisel.int-evry.fr (flowlan.maisel.int-evry.fr [157.159.47.25])
        by mx.google.com with ESMTPS id s11sm8141234mue.12.2008.11.25.09.45.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 25 Nov 2008 09:45:12 -0800 (PST)
From:	Florian Fainelli <florian@openwrt.org>
To:	Maxime Bizon <mbizon@freebox.fr>
Subject: Re: [PATCH/RFC v1 00/12] Support for Broadcom 63xx SOCs
Date:	Tue, 25 Nov 2008 18:44:26 +0100
User-Agent: KMail/1.9.9
Cc:	ralf@linux-mips.org, netdev@vger.kernel.org,
	afleming@freescale.com, jgarzik@pobox.com,
	linux-usb@vger.kernel.org, dbrownell@users.sourceforge.net,
	linux-pcmcia@lists.infradead.org, linux-serial@vger.kernel.org,
	linux-mips@linux-mips.org
References: <1224382022-24173-1-git-send-email-mbizon@freebox.fr> <200810221558.27338.florian@openwrt.org>
In-Reply-To: <200810221558.27338.florian@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200811251844.27405.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21426
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Hi again,

Le Wednesday 22 October 2008 15:58:23 Florian Fainelli, vous avez écrit :
> I prefer you get some feedback on your patches first before submitting my
> changes.

So the OpenWrt community did the following succesful tests :

- Inventel Livebox Pro (Need the OpenWrt patches plus some glue code to 
retrieve the MAC address) (6348)
- Neufbox 4 (6358)
- Comtrend CT536+ (6348)
- A custom design based on a BCM6348

There might be other successful reports as well.
-- 
Best regards, Florian Fainelli
Email : florian@openwrt.org
http://openwrt.org
-------------------------------
