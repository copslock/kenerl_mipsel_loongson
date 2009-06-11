Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Jun 2009 21:26:55 +0200 (CEST)
Received: from mail-ew0-f224.google.com ([209.85.219.224]:42625 "EHLO
	mail-ew0-f224.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1491765AbZFKT0t convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 11 Jun 2009 21:26:49 +0200
Received: by ewy24 with SMTP id 24so1907728ewy.0
        for <linux-mips@linux-mips.org>; Thu, 11 Jun 2009 12:27:01 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=9YUIt6ilo+aGU0tl2AmSLnHTwFRkYm+QqjHdGfo4IR0=;
        b=jc0C0qFQZK7ZTWh9QMP6kyrb5mDOh4bJvqTxyWgFRD//uDmD0f+rXPohfH9FCZW60E
         fG3vBjZoDwxw7z6uZCfGJg6f1thuZYECX52Osv/SDPjH06Tc38/mhEefn0yoeheXAa64
         UHuM4q+ZTcZpsf2qEmIVK+rLMkACeA0csePjw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=ov12jssi6d2pzeFune7coN7LaSod79I/xjlHQjdd6WfZRX31b23KPu5AE/6+kN6UqU
         Ti4zcKfgP0Y0zvRQ+fGdEOi+yxxOeps/NzBfUQyMDskP60epKe47wARUdr8VffK+ZAjs
         WavaiA/5DK3wyPrhWyzTHAych9+lgt44RC68s=
Received: by 10.210.42.20 with SMTP id p20mr2766708ebp.92.1244707181296;
        Thu, 11 Jun 2009 00:59:41 -0700 (PDT)
Received: from florian.lab.openpattern.org (lab.openpattern.org [82.240.16.241])
        by mx.google.com with ESMTPS id 10sm859537eyz.11.2009.06.11.00.59.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 11 Jun 2009 00:59:40 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
To:	matthieu castet <castet.matthieu@free.fr>, linville@tuxdriver.com
Subject: Re: [PATCH] bc47xx : fix ssb irq setup
Date:	Thu, 11 Jun 2009 09:59:36 +0200
User-Agent: KMail/1.9.9
Cc:	Michael Buesch <mb@bu3sch.de>, linux-mips@linux-mips.org,
	netdev@vger.kernel.org, Daniel Mueller <daniel@danm.de>
References: <4A11DBD4.7070706@free.fr> <200905191519.59193.mb@bu3sch.de> <4A1ADBAE.6070101@free.fr>
In-Reply-To: <4A1ADBAE.6070101@free.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200906110959.38132.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23379
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Hi Matthieu, Michael,

Le Monday 25 May 2009 19:55:58 matthieu castet, vous avez écrit :
> Michael Buesch wrote:
> > On Tuesday 19 May 2009 00:06:12 matthieu castet wrote:
> >> Hi,
> >>
> >>
> >> [1] http://www.danm.de/files/src/bcm5365p/REPORTED_DEVICES
> >>
> >> Signed-off-by: Matthieu CASTET <castet.matthieu@free.fr>
> >
> > If this works on all devices, I'm OK with this. Please submit to
> > linville@tuxdriver.com You can add my ack.
>
> Well I have only a wl500gd.
> I have submit it on openwrt project in order to test in more devices.

It makes the IPsec core work on my Netgear WGT634U and I did not see any 
regression on a Linksys WRT54GS.

Tested-by: Florian Fainelli <florian@openwrt.org>
-- 
