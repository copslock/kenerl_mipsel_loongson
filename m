Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Jun 2009 19:23:50 +0100 (WEST)
Received: from mail-ew0-f219.google.com ([209.85.219.219]:33395 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20023379AbZFASXo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 1 Jun 2009 19:23:44 +0100
Received: by ewy19 with SMTP id 19so8333057ewy.0
        for <multiple recipients>; Mon, 01 Jun 2009 11:23:38 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=SX0fM4FPl5tEMx6lKsOhOmzPDHAJ6r1ZnG7RExRA1QM=;
        b=XFmtLHCPRqUIQbe9+IwMZz5RwEJqOQHARZQJtoh1cbxxVJaYyTFUMq0hoh3n2Z48m2
         oFb1ug58Lt/WJ2HB8qPwdpy8+mWeITdK6yofwE0P0XfJd2b2SgIt9Pvpgmjp3e8VtvBJ
         EDeKLJUHBLdNfz9tHngcmsyZXO5r8xSuJqJIQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=VA4nnGxOl9Bnelh9KP89LGR3g9d9YMyuZ4uPnFrHmcndxaiSY0maQVX9LjBK88Pm1k
         8y4b/+DMIyrHlg21alpw0CU0YnmtSQexdxqMJVPlq78iaGw8RYp44ZtBc+XBx5nTkU5A
         CfRxHZ3rPbOmcbh+aMh/Tm9yTe7uKwCeLyKx0=
Received: by 10.210.91.17 with SMTP id o17mr6697619ebb.71.1243880618162;
        Mon, 01 Jun 2009 11:23:38 -0700 (PDT)
Received: from florian (207.130.195-77.rev.gaoland.net [77.195.130.207])
        by mx.google.com with ESMTPS id 23sm391782eya.29.2009.06.01.11.23.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 01 Jun 2009 11:23:37 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 2/3] bcm63xx: select SSB since we are using ssb_arch_set_fallback_sprom
Date:	Mon, 1 Jun 2009 20:23:35 +0200
User-Agent: KMail/1.9.9
Cc:	linux-mips@linux-mips.org, Maxime Bizon <mbizon@freebox.fr>
References: <200906012017.48965.florian@openwrt.org>
In-Reply-To: <200906012017.48965.florian@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200906012023.36068.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23156
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Le Monday 01 June 2009 20:17:48 Florian Fainelli, vous avez écrit :
> This patch makes BCM63XX select SSB since we unconditionnaly
> use ssb_arch_set_fallback_sprom. Without this linking would
> fail with an undefined reference.
>
> Signed-off-by: Florian Fainelli <florian@openwrt.org>
> ---
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 05ee268..e1f0917 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -72,6 +72,7 @@ config BCM63XX
>  	select SYS_HAS_EARLY_PRINTK
>  	select SWAP_IO_SPACE
>  	select ARCH_REQUIRE_GPIOLIB
> +	select SSB
>  	help
>  	 Support for BCM63XX based boards

Ralf,

Please find an updated version below. As Maxime pointed me out, this only 
applies to BCM963xx boards, not BCM63xx as a whole. Thanks !
-- 
Best regards, Florian Fainelli
Email : florian@openwrt.org
http://openwrt.org
-------------------------------
