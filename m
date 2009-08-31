Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 31 Aug 2009 15:43:15 +0200 (CEST)
Received: from mail-ew0-f225.google.com ([209.85.219.225]:40628 "EHLO
	mail-ew0-f225.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492988AbZHaNnJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 31 Aug 2009 15:43:09 +0200
Received: by ewy25 with SMTP id 25so3882985ewy.33
        for <multiple recipients>; Mon, 31 Aug 2009 06:43:04 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=E+j6hWZFobALOgswJJAoLWVqWyZfTa9MBGmmQ+8S+u0=;
        b=VF4/WLWymE5gttr6MN7CBoh/15f0TkVF0uy5Or3SPTj+CEnZO7T9+UeDxV5kbegKc1
         KAkhpVZus8/xJfpygFtXgbee7RtIDZiRAvSEb0IHUhDaE4Od7l8epb+SDfikjytf8X3f
         2ymdtQ1eln/sX1I4icbs2sCdlYfxEvcS644Qc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=EXeBCjvjfnDsLfljYIFR4V5JfBflEquvH6F0aNWYIPsoPuw8paDYZ57lkNuj5Xx9+R
         TcKvXS+uVsYCUePYy2GR+esQh5XxPvGjXMOwH4vpuilNsdyTRdhU6fn4JRkB1+pt7KwC
         TC48VEl5p7TWfuO7LBqCmr5I20fEr3ENxK4AQ=
Received: by 10.211.195.14 with SMTP id x14mr1891086ebp.46.1251726184371;
        Mon, 31 Aug 2009 06:43:04 -0700 (PDT)
Received: from lenovo.localnet (lab.openpattern.org [82.240.16.241])
        by mx.google.com with ESMTPS id 23sm308505eya.6.2009.08.31.06.43.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 31 Aug 2009 06:43:01 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
To:	Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCH 2/2] ar7_wdt: convert to become a platform driver
Date:	Mon, 31 Aug 2009 15:42:58 +0200
User-Agent: KMail/1.11.4 (Linux/2.6.29-2-686; KDE/4.2.4; i686; ; )
Cc:	ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
References: <200907151210.20294.florian@openwrt.org> <200908111517.09726.florian@openwrt.org> <20090827204719.GM29382@infomag.iguana.be>
In-Reply-To: <20090827204719.GM29382@infomag.iguana.be>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200908311542.59375.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23968
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Le jeudi 27 août 2009 22:47:19, Wim Van Sebroeck a écrit :
> Hi Florian,
>
> > > > > From: Florian Fainelli <florian@openwrt.org>
> > > > > Subject: [PATCH 2/2 v2] ar7_wdt: convert to become a platform
> > > > > driver
> > > > >
> > > > > This patch converts the ar7_wdt driver to become
> > > > > a platform driver. The AR7 SoC specific identification
> > > > > and base register calculation is performed by the board
> > > > > code, therefore we no longer need to have access to
> > > > > ar7_chip_id. We also remove the reboot notifier code to
> > > > > use the platform shutdown method as Wim suggested.
> > > > >
> > > > > Signed-off-by: Florian Fainelli <florian@openwrt.org>
> > > > > Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
> > > >
> > > > Any news on this patch ?
> > >
> > > This one was ok for me. I think we agreed that Ralf would take it up in
> > > his tree. I can also take it up in my next tree still.
> >
> > Oh, I did not understand that sorry, I thought Ralf would take the first
> > one which is MIPS-specific.
>
> I added the second patch to my tree, but saw that the error handling on
> probe could be improved. Can you test attached patch?

Works fine. Feel free to add my Tested-by: Florian Fainelli <florian@openwrt.org>. Thanks !
-- 
Best regards, Florian Fainelli
Email: florian@openwrt.org
Web: http://openwrt.org
IRC: [florian] on irc.freenode.net
-------------------------------
