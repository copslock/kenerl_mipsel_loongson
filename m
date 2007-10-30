Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Oct 2007 11:35:06 +0000 (GMT)
Received: from ug-out-1314.google.com ([66.249.92.170]:46516 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S20024000AbXJ3Le6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 30 Oct 2007 11:34:58 +0000
Received: by ug-out-1314.google.com with SMTP id u2so88350uge
        for <linux-mips@linux-mips.org>; Tue, 30 Oct 2007 04:34:41 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=UwOZDxLnm3czz5Rq/C3p23GQ/mGYn7AdmUkWc12Gr6Q=;
        b=cUFeqm5vYi2w/YasPIRN9M59LwOeyryHyDJW6wIRSxOqtWtEwS6ahBe3KTC4awtyCVQegGA7Itqu4iLzSu7e3OSQyMxSBS5dlNeoHWDeXyP6MOgGozMZ5yFjn7c0Y5fWBYYhxWie2nFkIjQBXoFS8DZ+Mz0TeVb6lDsylUIcbmk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=aMiRP1tzXYdwBbBgy3rX4NDArsMVTiJN0fFQNIV3gd79lDtjZ1eQi5UQ80lCbT+T+/+RHHMCqIb3oE3XguIcsMrh9vM6pnqpNkGG15N1NS56wqB1l9A1i7uMU83F6141csf6KuN5Gp5WxkeGcjLCHwdOp+r+kI3T2pNkObWg4l0=
Received: by 10.67.20.19 with SMTP id x19mr192830ugi.1193744081042;
        Tue, 30 Oct 2007 04:34:41 -0700 (PDT)
Received: from vda.dub.corp.google.com ( [172.28.3.151])
        by mx.google.com with ESMTPS id c22sm9680420ika.2007.10.30.04.34.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 30 Oct 2007 04:34:38 -0700 (PDT)
From:	Denys Vlasenko <vda.linux@googlemail.com>
To:	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [IDE] Fix build bug
Date:	Tue, 30 Oct 2007 11:34:29 +0000
User-Agent: KMail/1.9.1
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
	linux-mips@linux-mips.org,
	Martijn Uffing <mp3project@sarijopen.student.utwente.nl>
References: <20071025135334.GA23272@linux-mips.org> <200710252341.38902.bzolnier@gmail.com>
In-Reply-To: <200710252341.38902.bzolnier@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200710301134.30087.vda.linux@googlemail.com>
Return-Path: <vda.linux@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17311
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vda.linux@googlemail.com
Precedence: bulk
X-list: linux-mips

On Thursday 25 October 2007 22:41, Bartlomiej Zolnierkiewicz wrote:
> > -static const struct ide_port_info generic_chipsets[] __devinitdata = {
> > +static struct ide_port_info generic_chipsets[] __devinitdata = {
> >  	/*  0 */ DECLARE_GENERIC_PCI_DEV("Unknown",	0),
> >  
> >  	{	/* 1 */
> 
> I would prefer to not remove const from generic_chipsets[] so:
> 
> [PATCH] drivers/ide/pci/generic: fix build for CONFIG_HOTPLUG=n
> 
> It turns out that const and __{dev}initdata cannot be mixed currently
> and that generic IDE PCI host driver is also affected by the same issue:
> 
> On Thursday 25 October 2007, Ralf Baechle wrote:
> >   CC      drivers/ide/pci/generic.o
> > drivers/ide/pci/generic.c:52: error: __setup_str_ide_generic_all_on causes a
> > +section type conflict
> 
> [ Also reported by Martijn Uffing <mp3project@sarijopen.student.utwente.nl>. ]
> 
> This patch workarounds the problem in a bit hackish way but without
> removing const from generic_chipsets[] (it adds const to __setup() so
> __setup_str_ide_generic_all becomes const).

You wouldn't believe how much const data is not marked as const because
we don't have __constinitdata etc. Literally megabytes.
--
vda
