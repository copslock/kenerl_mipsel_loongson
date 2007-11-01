Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Nov 2007 18:43:44 +0000 (GMT)
Received: from fk-out-0910.google.com ([209.85.128.184]:271 "EHLO
	fk-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20027316AbXKASng (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 1 Nov 2007 18:43:36 +0000
Received: by fk-out-0910.google.com with SMTP id f40so564445fka
        for <linux-mips@linux-mips.org>; Thu, 01 Nov 2007 11:43:25 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=jShAyuEj7pJVqlUmO4sEnwGOTNkWLTUR5mI3f0k8+cM=;
        b=c5Ixo1UMunXh33i4OhQ3F3V5NTR3TBL/n5usF+t0/n7HbKZIyNLFIvW9/UuAPrF4fo4QWfDfBXPFvmcgn4CL8/2QnORBFj59/e6z7peo11GynKqMgTClN2TnvZM0nEQp68p4hYcK6Aje1TGIIxk8l2D9KHpKGe+k4PbDBnHF0zw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=rU/YZ5M2M3G906zkX8fSsXsVkLUNT8J25GUgkX8H2wYhU56mMK/gcA0X0roYne6XMKWHN0lISAK6eADlDqlQ8sOlNmke9YnO7WQhLPb08eDCECV8G4Yd7AT7x3UsSyHGzQ9f11lWcFrGvMxah5Jw6pJHSB0w1BR1+Y2QYVsfSRA=
Received: by 10.82.138.6 with SMTP id l6mr1894008bud.1193942605675;
        Thu, 01 Nov 2007 11:43:25 -0700 (PDT)
Received: from vda.dub.corp.google.com ( [172.28.3.151])
        by mx.google.com with ESMTPS id j5sm272935gve.2007.11.01.11.43.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 01 Nov 2007 11:43:23 -0700 (PDT)
From:	Denys Vlasenko <vda.linux@googlemail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [IDE] Fix build bug
Date:	Thu, 1 Nov 2007 18:43:16 +0000
User-Agent: KMail/1.9.1
Cc:	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
	linux-mips@linux-mips.org,
	Martijn Uffing <mp3project@sarijopen.student.utwente.nl>
References: <20071025135334.GA23272@linux-mips.org> <200710301134.30087.vda.linux@googlemail.com> <20071030124155.GA7582@linux-mips.org>
In-Reply-To: <20071030124155.GA7582@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200711011843.16894.vda.linux@googlemail.com>
Return-Path: <vda.linux@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17367
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vda.linux@googlemail.com
Precedence: bulk
X-list: linux-mips

On Tuesday 30 October 2007 12:41, Ralf Baechle wrote:
> On Tue, Oct 30, 2007 at 11:34:29AM +0000, Denys Vlasenko wrote:
> 
> > On Thursday 25 October 2007 22:41, Bartlomiej Zolnierkiewicz wrote:
> > > > -static const struct ide_port_info generic_chipsets[] __devinitdata = {
> > > > +static struct ide_port_info generic_chipsets[] __devinitdata = {
> > > >  	/*  0 */ DECLARE_GENERIC_PCI_DEV("Unknown",	0),
> > > >  
> > > >  	{	/* 1 */
> > > 
> > > I would prefer to not remove const from generic_chipsets[] so:
> > > 
> > > [PATCH] drivers/ide/pci/generic: fix build for CONFIG_HOTPLUG=n
> > > 
> > > It turns out that const and __{dev}initdata cannot be mixed currently
> > > and that generic IDE PCI host driver is also affected by the same issue:
> > > 
> > > On Thursday 25 October 2007, Ralf Baechle wrote:
> > > >   CC      drivers/ide/pci/generic.o
> > > > drivers/ide/pci/generic.c:52: error: __setup_str_ide_generic_all_on causes a
> > > > +section type conflict
> > > 
> > > [ Also reported by Martijn Uffing <mp3project@sarijopen.student.utwente.nl>. ]
> > > 
> > > This patch workarounds the problem in a bit hackish way but without
> > > removing const from generic_chipsets[] (it adds const to __setup() so
> > > __setup_str_ide_generic_all becomes const).
> > 
> > You wouldn't believe how much const data is not marked as const because
> > we don't have __constinitdata etc. Literally megabytes.
> 
> The gain from marking it const is very little and once any non-const
> __initdata object is added to a compilation unit all other const declarations
> will have to be removed.  Bad tradeoff.

We can intrduce new, ro sections or teach gcc that combining const objects into
non-ro sections is not a crime. I wonder why it currently disallows that.
(And it does it only _somethimes_, const pointers happily go into rw sections!)
--
vda
