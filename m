Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Jun 2009 23:09:06 +0200 (CEST)
Received: from mail-fx0-f223.google.com ([209.85.220.223]:58459 "EHLO
	mail-fx0-f223.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493143AbZFVVI6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 22 Jun 2009 23:08:58 +0200
Received: by fxm23 with SMTP id 23so4060842fxm.0
        for <multiple recipients>; Mon, 22 Jun 2009 14:05:55 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=vy9GFS97rsSusFJhAKboI2pLmdkobp5vZVWn/SVUQwQ=;
        b=RJ2ScU6DHrWgx05Iwyxa7YeaR4QF7up0U1WnULSrtP+ZV1tc9Tbe6UIbsbpC8R4xiR
         sZPi7kMwLU6PxuQ6sO9E/5mf1LzzFAkLRB9lL/tUFlcJ0RBFca25W5Ybi83qn347vwmI
         wI2vDN+ANlQUaqx8g4K0HihJV1MR0PTCqKf30=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=MN9cilxSfy1kQaZAfzGDVpx0WYpn0t0dEb3tbwF+IdKp3IetWvV6Dcedu3LWKcgDff
         6CsEbY/nBepdDrEGH1obkklLLFESUUyaCj0SSDpp+8XxjIHo3sMZzLASJGUQgXdn/JHP
         bRbGUreQIvg/AbOaTF1yFetVm2gn3Uqc9UCDs=
Received: by 10.103.213.19 with SMTP id p19mr2510683muq.91.1245704755648;
        Mon, 22 Jun 2009 14:05:55 -0700 (PDT)
Received: from flowlan.maisel.int-evry.fr ([157.159.47.25])
        by mx.google.com with ESMTPS id e10sm12147170muf.14.2009.06.22.14.05.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 22 Jun 2009 14:05:52 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 2/2] octeon: only build flash_setup code when CONFIG_MTD is set
Date:	Mon, 22 Jun 2009 23:05:46 +0200
User-Agent: KMail/1.9.9
Cc:	linux-mips@linux-mips.org, David Daney <ddaney@caviumnetworks.com>
References: <200906221116.21621.florian@openwrt.org> <20090622144042.GC25289@linux-mips.org>
In-Reply-To: <20090622144042.GC25289@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200906222305.48346.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23470
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Le Monday 22 June 2009 16:40:42 Ralf Baechle, vous avez écrit :
> On Mon, Jun 22, 2009 at 11:16:21AM +0200, Florian Fainelli wrote:
> > This patch makes the flash_setup code be compiled only when
> > CONFIG_MTD is set, it does make sense to register a physmap
> > platform driver without the MTD subsystem being enabled.
>
> No.  A user might build the MTD subsystem as a module and then insert it
> into a running system so the idea is to always register the devices.  This
> also keeps the information in /proc/iomem rsp. /proc/iostat and sysfs
> more useful.

Right.
-- 
Best regards, Florian Fainelli
Email : florian@openwrt.org
http://openwrt.org
-------------------------------
