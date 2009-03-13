Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Mar 2009 17:35:31 +0000 (GMT)
Received: from sj-iport-1.cisco.com ([171.71.176.70]:2698 "EHLO
	sj-iport-1.cisco.com") by ftp.linux-mips.org with ESMTP
	id S21102772AbZCMRf0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 13 Mar 2009 17:35:26 +0000
X-IronPort-AV: E=Sophos;i="4.38,358,1233532800"; 
   d="scan'208";a="155500045"
Received: from sj-dkim-1.cisco.com ([171.71.179.21])
  by sj-iport-1.cisco.com with ESMTP; 13 Mar 2009 17:35:18 +0000
Received: from sj-core-2.cisco.com (sj-core-2.cisco.com [171.71.177.254])
	by sj-dkim-1.cisco.com (8.12.11/8.12.11) with ESMTP id n2DHZIf5027080;
	Fri, 13 Mar 2009 10:35:18 -0700
Received: from cliff.cisco.com (cliff.cisco.com [171.69.11.141])
	by sj-core-2.cisco.com (8.13.8/8.13.8) with ESMTP id n2DHZIrP007784;
	Fri, 13 Mar 2009 17:35:18 GMT
Received: from cuplxvomd02.corp.sa.net ([64.101.20.155]) by cliff.cisco.com (8.6.12/8.6.5) with ESMTP id RAA22951; Fri, 13 Mar 2009 17:35:17 GMT
Date:	Fri, 13 Mar 2009 10:35:17 -0700
From:	VomLehn <dvomlehn@cisco.com>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:	Linux MIPS Mailing List <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH][MIPS] Use CP0 Count register to implement more
	granular ndelay
Message-ID: <20090313173517.GA25355@cuplxvomd02.corp.sa.net>
References: <20090312032850.GA9379@cuplxvomd02.corp.sa.net> <20090313092906.GA6526@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090313092906.GA6526@alpha.franken.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
DKIM-Signature:	v=1; a=rsa-sha256; q=dns/txt; l=682; t=1236965718; x=1237829718;
	c=relaxed/simple; s=sjdkim1004;
	h=Content-Type:From:Subject:Content-Transfer-Encoding:MIME-Version;
	d=cisco.com; i=dvomlehn@cisco.com;
	z=From:=20VomLehn=20<dvomlehn@cisco.com>
	|Subject:=20Re=3A=20[PATCH][MIPS]=20Use=20CP0=20Count=20reg
	ister=20to=20implement=20more=0A=09granular=20ndelay
	|Sender:=20;
	bh=n3QdEWEVP7gSMvXs0S30038vmvSBRdo0R5umiJ5Twhg=;
	b=U+n2qriiY3NC1eol+pf1qejtYaQP0nXCy7uNaj7cp+9gH1dg5UhUJmgX4G
	54BClFsK5FClrB/SoyhfHHmwMZJwxVZoQrb5jBTu1pcg0Q8WAHSpHOq1s0oX
	Eq//kWi6RZUzIpq8lvBZ4/STMp1/0MdEcl7qu3U6Pus74w4Sd8/D8=;
Authentication-Results:	sj-dkim-1; header.From=dvomlehn@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim1004 verified; ); 
Return-Path: <dvomlehn@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22076
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dvomlehn@cisco.com
Precedence: bulk
X-list: linux-mips

On Fri, Mar 13, 2009 at 10:29:07AM +0100, Thomas Bogendoerfer wrote:
> On Wed, Mar 11, 2009 at 08:28:50PM -0700, VomLehn wrote:
> >  #
> > +# Collect various processors by instruction family
> > +#
> > +config MIPS1
> > +	bool
> > +	default y if CPU_R3000 || CPU_TX39XX
> > +
> > +config MIPS2
> > +	bool
> > +	default y if CPU_R6000
> > +
> > +config MIPS3
> > +	bool
> > +	default y if CPU_LOONGSON2 || CPU_R4300 || CPU_R4X00 || CPU_TX49XX || \
> > +		CPU_VR41XX
> > +
> > +config MIPS4
> > +	bool
> > +	default y if CPU_R8000 || CPU_R10000
> > +
> 
> what about all the R5k CPUs ?

Excellent question. What are their names and what is their ISA called?
