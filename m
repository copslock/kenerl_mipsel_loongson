Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Oct 2009 18:12:44 +0200 (CEST)
Received: from mail-ew0-f216.google.com ([209.85.219.216]:48723 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492947AbZJLQMh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 12 Oct 2009 18:12:37 +0200
Received: by ewy12 with SMTP id 12so1728373ewy.0
        for <multiple recipients>; Mon, 12 Oct 2009 09:12:31 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:organization:to
         :subject:date:user-agent:cc:references:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        bh=CiGdzmrowlOqAOJXHqb9p62GTACLX9qGmLlA1zDxclM=;
        b=uXH8u44dmCLU0DuCih07ABLiSkUsRRAIMGMJloH17pv777KOopyD2B35VCGxHkqFPz
         NyhiE99acSHfhMFIBjZWZp5DeyCvZlbZRZIvt3gvIcGiQ+U84G7j7+FteHuJMTgNnMDz
         34ZaWGJOP3VUEfcT11cCs+kWHe9HcLafOBDfc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=oZnXjZsC1J5nunU4jE+Gj10AyrKgEGMxfp3Z7Mum8c7fI41NaAYa7RxR/XbFCzrgmL
         8KNhvS6zaus99+7k4IOJhScTho+EbzWCy9I70gYW/wa1XzeJ6ZqxMXy7fZuvEwjyw6FJ
         mGdFBBR9U66n4ES9OL8B//Bd52kqN0MSE8WVM=
Received: by 10.211.155.20 with SMTP id h20mr7396065ebo.30.1255363951512;
        Mon, 12 Oct 2009 09:12:31 -0700 (PDT)
Received: from flexo.localnet (bobafett.staff.proxad.net [213.228.1.121])
        by mx.google.com with ESMTPS id 24sm690517eyx.1.2009.10.12.09.12.30
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 12 Oct 2009 09:12:30 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
Organization: OpenWrt
To:	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 2/2] bcm63xx: only set the proper GPIO overlay settings
Date:	Mon, 12 Oct 2009 18:12:23 +0200
User-Agent: KMail/1.11.2 (Linux/2.6.28-15-server; KDE/4.2.2; x86_64; ; )
Cc:	mbizon@freebox.fr, linux-mips@linux-mips.org
References: <200908312028.10931.florian@openwrt.org> <200908312337.36634.florian@openwrt.org> <20091011225320.GA10230@linux-mips.org>
In-Reply-To: <20091011225320.GA10230@linux-mips.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200910121812.23540.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24233
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

On Monday 12 October 2009 00:53:20 Ralf Baechle wrote:
> On Mon, Aug 31, 2009 at 11:37:31PM +0200, Florian Fainelli wrote:
> > Le lundi 31 août 2009 22:26:29, Maxime Bizon a écrit :
> > > On Mon, 2009-08-31 at 20:28 +0200, Florian Fainelli wrote:
> > > > This patch makes the GPIO pin multiplexing configuration
> > > > read the initial GPIO mode register value instead of
> > > > setting it initially to 0, then setting the correct
> > > > bits, this is safer.
> > >
> > > I disagree, now we get working or not working devices depending on the
> > > CFE version used, for which we don't have any public source code nor
> > > changelog.
> >
> > I did not think this could break other boards, it is required on BCM6345
> > though.
> >
> > > I cleared the register for that purpose.
> > >
> > > If a particular pin muxing config is needed for some board, we should
> > > add this to the board specific struct instead.
> >
> > Then I will make it BCM6345 specific.
>
> I thought you were going to send an update to this?

Not at the moment, the user who reported that issue though it was related to 
that and I also saw a potential for breaking BCM6345 GPIO config, but since 
that one has a totally different GPIO registers layout it needs a bigger fix 
which deals with different registers.
