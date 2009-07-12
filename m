Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 12 Jul 2009 18:42:44 +0200 (CEST)
Received: from mail-ew0-f215.google.com ([209.85.219.215]:52071 "EHLO
	mail-ew0-f215.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492410AbZGLQmU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 12 Jul 2009 18:42:20 +0200
Received: by ewy11 with SMTP id 11so1913637ewy.0
        for <multiple recipients>; Sun, 12 Jul 2009 09:42:14 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=vpRAvszHVTc6YoJpnxLEXkAFsX7QxBXElebFzcFTBsU=;
        b=wcAwhBJb2XrTf5fGx+BbmKZBKZOlwbuoH5o4P3euGoTODXh4zvFGgD66qEBVGL6Jyd
         pcVjYPLt/h5RT5GAwVNwsqaHtzEbdUMy/xhLie4O1blidvJ3CvZxktU15IP5BkdXGnYI
         mQKvWUWN9emrftjOQ4sOiB9ZA88MfTg/T6p2Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=l/pxNJMux2tn0BYGkvJA9+lCszmngo49qmWUIXqxZHbc75IEVhfshhdmqUg2yNHAyl
         jUGy10QJKHVrDTpR3MbQHm5fklth1tcacgmK7ckjb+h9w/xdgUvVYVp+e+S0lneaNSet
         LWlvhIhral1sF/8Qfr/GtGDV60GJd/6ECFEQM=
Received: by 10.210.140.9 with SMTP id n9mr3924438ebd.26.1247416933485;
        Sun, 12 Jul 2009 09:42:13 -0700 (PDT)
Received: from lenovo.mimichou.home (home.mimichou.net [82.67.132.19])
        by mx.google.com with ESMTPS id 28sm7720440eyg.32.2009.07.12.09.42.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 12 Jul 2009 09:42:12 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
To:	Shane McDonald <mcdonald.shane@gmail.com>
Subject: Re: [PATCH] fix build failures on msp_irq_slp.c
Date:	Sun, 12 Jul 2009 18:42:07 +0200
User-Agent: KMail/1.9.9
Cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
References: <200904271659.48357.florian@openwrt.org> <b2b2f2320907110351o1473fc79xa3926b8af4ffc35@mail.gmail.com> <b2b2f2320907120934x6d6e4059ma318fe6236e45b19@mail.gmail.com>
In-Reply-To: <b2b2f2320907120934x6d6e4059ma318fe6236e45b19@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200907121842.08739.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23726
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Le Sunday 12 July 2009 18:34:45 Shane McDonald, vous avez écrit :
> On Sat, Jul 11, 2009 at 4:51 AM, Shane McDonald 
<mcdonald.shane@gmail.com>wrote:
> > Hi Florian:
> >
> >   My apologies for the delay in replying to your latest prompt -- I've
> > been on vacation with little internet access.
> >
> >   Your patch looks correct to me, but as Ralf says, the existing code is
> > a little suspect.  In my poking around, I've come across three different
> > versions of this file: the in-tree version, the latest out-of-tree patch
> > from PMC-Sierra, and an unreleased version from a colleague.  None appear
> > to be quite correct.  I think I've got enough info, though, to come up
> > with a good version.
> >
> >   I'll cook something up this weekend and get it posted.
>
> OK, I've done my cooking, and the cleanup patch will follow in a separate
> email.  It expects Florian's patch to have been applied.

Thank you very much !

>
> Florian's patch is correct, so I'll add my:
>
> Acked-by: Shane McDonald <mcdonald.shane@gmail.com>
>
> Shane



-- 
Best regards, Florian Fainelli
Email : florian@openwrt.org
http://openwrt.org
-------------------------------
