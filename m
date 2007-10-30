Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Oct 2007 20:24:49 +0000 (GMT)
Received: from nf-out-0910.google.com ([64.233.182.191]:23338 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S28575274AbXJ3UYl (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 30 Oct 2007 20:24:41 +0000
Received: by nf-out-0910.google.com with SMTP id c10so1648651nfd
        for <linux-mips@linux-mips.org>; Tue, 30 Oct 2007 13:24:39 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-disposition:message-id:content-type:content-transfer-encoding;
        bh=fUZHEmFP0LbLg0T3VSy1MOY6j7+xPptKppR+ePecfoU=;
        b=nGjN8MqBrlMcpTqOAlAnOA2kz/oN7of9/cZZeuNnM2KPjPKoAR0JuhV4WYeWsM0GJT6crXbFPdqeeXMddtw4y/K50r1sH+ffQiaciHpq1BtbiBAlqVBvQ+P1X64DDAr1IfzIFy9h+HoH+JTFvZtL2mOFqqdMPgeocjz46rQ2E4o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-disposition:message-id:content-type:content-transfer-encoding;
        b=Tug9g7am+ZFgp5pEfoRHOqsvZfgJQ50CE4EiKHlNaPvxxv1DeVaVGLopsl/iaC9HIdjEeJ5tVTkCkgK249WupKZC6yo1ad8ddbHvVhr7kzgz7Sjnm7kV9MuIzMD+V6X2pW99Sv7yQYv54zCJa3WYErMX26tVXwEl/Vn5tPxtUSU=
Received: by 10.86.49.13 with SMTP id w13mr5978951fgw.1193775879557;
        Tue, 30 Oct 2007 13:24:39 -0700 (PDT)
Received: from ?192.168.123.7? ( [89.78.229.67])
        by mx.google.com with ESMTPS id p38sm15481169fke.2007.10.30.13.24.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 30 Oct 2007 13:24:39 -0700 (PDT)
From:	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [IDE] Fix build bug
Date:	Tue, 30 Oct 2007 21:30:55 +0100
User-Agent: KMail/1.9.6 (enterprise 0.20070907.709405)
Cc:	Denys Vlasenko <vda.linux@googlemail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
	linux-mips@linux-mips.org,
	Martijn Uffing <mp3project@sarijopen.student.utwente.nl>
References: <20071025135334.GA23272@linux-mips.org> <200710301134.30087.vda.linux@googlemail.com> <20071030124155.GA7582@linux-mips.org>
In-Reply-To: <20071030124155.GA7582@linux-mips.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200710302130.55225.bzolnier@gmail.com>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-Path: <bzolnier@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17322
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bzolnier@gmail.com
Precedence: bulk
X-list: linux-mips


On Tuesday 30 October 2007, Ralf Baechle wrote:
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

In this case (struct ide_port_info) and probably few others having const
is important (maybe even more important than having __{dev}initdata since
majority of people use CONFIG_HOTPLUG=y) because it allows developers to
catch subtle yet hard to find bugs very early in the development process.

We had a few such cases in IDE - struct ide_port_info _template_ was being
modified because some quirk was needed for one version of the hardware which
was of course incorrect if another version of the hardware was also present
in the system.

Some other potential gains of using const like the better optimized code
or the protection of read-only kernel data are only an extra bonuses. :)

I agree that we need __const{dev}initdata but until then the workaround
that all __{dev}initdata must be const is an acceptable temporary solution
for IDE host drivers.

Thanks,
Bart
