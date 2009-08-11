Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Aug 2009 15:22:42 +0200 (CEST)
Received: from ey-out-1920.google.com ([74.125.78.145]:50221 "EHLO
	ey-out-1920.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1492897AbZHKNWR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 11 Aug 2009 15:22:17 +0200
Received: by ey-out-1920.google.com with SMTP id 13so935057eye.54
        for <multiple recipients>; Tue, 11 Aug 2009 06:22:21 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=vgbuLOZEPruwhiNO7H0tyXmmhqQrSPZAxTbBuV9inRs=;
        b=J4fKh3pj7/4uUxqYo/birF3LNhsy7S8BrpmnWKmgjBS4L+T4v22yWLPtm0UbNugQmS
         PhmPvVIHAxm09hekteTvaaMh+ehEVj/NY2DeHNsNsIEcfcFCGGDibwNGyDJ292LRddcA
         6UEk1J4ZwcbxKBpqL9pUi9Ge8bGT2rCTVcw9I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=H8gl0szkKU9WpIjA/deNugXZ803r2gN0dRjchLFisTeURUK7+2i3pkAIwLAPCx4L+z
         DZi1YF7MqsyvPIopHwkmGOSvcDV/DRMtOYQ/4kuKIEMsx3kMMk+nUEpP6wMDI2k/DVaw
         p6cqbRIH8uSvYU0uxavOh3UBl+suwR+D6ncCo=
Received: by 10.211.194.4 with SMTP id w4mr920881ebp.41.1249996632732;
        Tue, 11 Aug 2009 06:17:12 -0700 (PDT)
Received: from florian.lab.openpattern.org (lab.openpattern.org [82.240.16.241])
        by mx.google.com with ESMTPS id 7sm14691997eyb.50.2009.08.11.06.17.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 11 Aug 2009 06:17:12 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
To:	Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCH 2/2] ar7_wdt: convert to become a platform driver
Date:	Tue, 11 Aug 2009 15:17:08 +0200
User-Agent: KMail/1.9.9
Cc:	ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
References: <200907151210.20294.florian@openwrt.org> <200908111452.28418.florian@openwrt.org> <20090811130133.GH4302@infomag.iguana.be>
In-Reply-To: <20090811130133.GH4302@infomag.iguana.be>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200908111517.09726.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23893
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Le Tuesday 11 August 2009 15:01:33 Wim Van Sebroeck, vous avez écrit :
> Hi Florian,
>
> > > From: Florian Fainelli <florian@openwrt.org>
> > > Subject: [PATCH 2/2 v2] ar7_wdt: convert to become a platform driver
> > >
> > > This patch converts the ar7_wdt driver to become
> > > a platform driver. The AR7 SoC specific identification
> > > and base register calculation is performed by the board
> > > code, therefore we no longer need to have access to
> > > ar7_chip_id. We also remove the reboot notifier code to
> > > use the platform shutdown method as Wim suggested.
> > >
> > > Signed-off-by: Florian Fainelli <florian@openwrt.org>
> > > Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
> >
> > Any news on this patch ?
>
> This one was ok for me. I think we agreed that Ralf would take it up in his
> tree. I can also take it up in my next tree still.

Oh, I did not understand that sorry, I thought Ralf would take the first one 
which is MIPS-specific.
-- 
Best regards, Florian Fainelli
Email: florian@openwrt.org
Web: http://openwrt.org
IRC: [florian] on irc.freenode.net
-------------------------------
