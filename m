Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 07 Nov 2009 11:56:06 +0100 (CET)
Received: from mail-pw0-f45.google.com ([209.85.160.45]:47401 "EHLO
	mail-pw0-f45.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492260AbZKGK4A (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 7 Nov 2009 11:56:00 +0100
Received: by pwi15 with SMTP id 15so1137204pwi.24
        for <multiple recipients>; Sat, 07 Nov 2009 02:55:53 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=85nv026wuR6V8NQ8HmlCmt+nwmEFvmI5aQwZ6kofOkU=;
        b=NvcW+Wdt0yXeVT63cJxZpREmDhvTkszDumXDfPdZFwQ4Oz2CxJRj/gq/jD+gsro3jS
         nlVQYpRerYKlKflvN1HKhYvg+neiC1uFwpHNYw2cozOl0UA0HoqlJH2Qy5HILNXCfedA
         A9AqfKxJTPxjZfC2V0oUQJTVnInLflBsupFFc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=SQl0gT+M6PguYC5IXHW7O5bAJnUSJrBDI3UrYDUu2X7Uv8ZNsABiUUd0g+rGVQIre2
         o/XjowkUCqh4o9XleQInknZ/a1myDdWR4ZMrD2vy5F2QNb4vRs5xpzomsItE1AI0wgWb
         yeGGgyF17CftWSfOYahghnrpG704QCKhcTllI=
Received: by 10.115.100.22 with SMTP id c22mr1916651wam.58.1257591353473;
        Sat, 07 Nov 2009 02:55:53 -0800 (PST)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 23sm536082pzk.4.2009.11.07.02.55.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 07 Nov 2009 02:55:52 -0800 (PST)
Subject: Re: [PATCH -queue v1 4/7] [loongson] lemote-2f: add pci support
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Arnaud Patard <apatard@mandriva.com>, zhangfx@lemote.com,
	yanh@lemote.com, huhb@lemote.com,
	Nicholas Mc Guire <hofrat@hofr.at>, linux-mips@linux-mips.org
In-Reply-To: <84e7310659ae445b3b3dc68aadc8f27648c709f6.1257510612.git.wuzhangjin@gmail.com>
References: <cover.1257510612.git.wuzhangjin@gmail.com>
	 <17e5d58a0cd7273b81c7151b7f7f2096c9694b59.1257510612.git.wuzhangjin@gmail.com>
	 <588574ed5910292f2728072ca147add2ae342778.1257510612.git.wuzhangjin@gmail.com>
	 <7affa8fce1f55b817aff1c64f823824f6809dd85.1257510612.git.wuzhangjin@gmail.com>
	 <84e7310659ae445b3b3dc68aadc8f27648c709f6.1257510612.git.wuzhangjin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:	Sat, 07 Nov 2009 18:55:51 +0800
Message-ID: <1257591351.2251.12.camel@falcon.domain.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24748
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Fri, 2009-11-06 at 21:11 +0800, Wu Zhangjin wrote:
> From: Wu Zhangjin <wuzhangjin@gmail.com>
> 
> Most of the pci support between fuloong2e and lemote loongson2f family
> machines are the same, except the cs5536 support.
> 
> This patch renames ops-fuloong2e.c to ops-loongson2.c and then append
> the cs5536 support to share most of the source code among loongson
> machines.
[...]
> +
> +
> +static int loongson_pcibios_config_access(unsigned char access_type,
> +				      struct pci_bus *bus,
> +				      unsigned int devfn, int where,
> +				      u32 *data)
> +{
> +	u32 busnum = bus->number;
> +	u32 addr, type;
> +	u32 dummy;
> +	void *addrp;
> +	int device = PCI_SLOT(devfn);
> +	int function = PCI_FUNC(devfn);
> +	int reg = where & ~3;
> +
> +	if (busnum == 0) {
> +		/* board-specific part,currently,only fuloong2f,yeeloong2f
> +		 * use CS5536, fuloong2e use via686b, gdium has no
> +		 * south bridge
> +		 */
> +#ifdef CONFIG_CS5536
> +		/* cs5536_pci_conf_read4/write4() will call _rdmsr/_wrmsr() to
> +		 * access the regsters PCI_MSR_ADDR, PCI_MSR_DATA_LO,
> +		 * PCI_MSR_DATA_HI, which is bigger than 0xf0, so, it will not
> +		 * go this branch, but the others. so, no calling dead loop
> +		 * here.
> +		 */
> +		if ((PCI_IDSEL_CS5536 == device) && (reg < PCI_MSR_CTRL)) {

0xf0 is exactly PCI_MSR_CTRL, will replace it by PCI_MSR_CTRL later.

Regards,
	Wu Zhangjin
