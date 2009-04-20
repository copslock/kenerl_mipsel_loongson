Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Apr 2009 21:07:28 +0100 (BST)
Received: from rtp-iport-2.cisco.com ([64.102.122.149]:38420 "EHLO
	rtp-iport-2.cisco.com") by ftp.linux-mips.org with ESMTP
	id S20031223AbZDTUHV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 20 Apr 2009 21:07:21 +0100
X-IronPort-AV: E=Sophos;i="4.40,219,1238976000"; 
   d="scan'208";a="42275054"
Received: from rtp-dkim-1.cisco.com ([64.102.121.158])
  by rtp-iport-2.cisco.com with ESMTP; 20 Apr 2009 20:07:13 +0000
Received: from rtp-core-2.cisco.com (rtp-core-2.cisco.com [64.102.124.13])
	by rtp-dkim-1.cisco.com (8.12.11/8.12.11) with ESMTP id n3KK7D6c023102;
	Mon, 20 Apr 2009 16:07:13 -0400
Received: from xbh-rtp-201.amer.cisco.com (xbh-rtp-201.cisco.com [64.102.31.12])
	by rtp-core-2.cisco.com (8.13.8/8.13.8) with ESMTP id n3KK7Dwr006778;
	Mon, 20 Apr 2009 20:07:13 GMT
Received: from xmb-rtp-218.amer.cisco.com ([64.102.31.117]) by xbh-rtp-201.amer.cisco.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 20 Apr 2009 16:07:13 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: RE: Boot program interface
Date:	Mon, 20 Apr 2009 16:07:11 -0400
Message-ID: <FF038EB85946AA46B18DFEE6E6F8A2890105326D@xmb-rtp-218.amer.cisco.com>
In-Reply-To: <200904201057.04833.florian@openwrt.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Boot program interface
thread-index: AcnBn4K7oPsfm+voTbS53YE8jysyhwAU/XPA
References: <1240213045.49ec26350fa49@www.sysgo.com> <200904201057.04833.florian@openwrt.org>
From:	"David VomLehn (dvomlehn)" <dvomlehn@cisco.com>
To:	"Florian Fainelli" <florian@openwrt.org>,
	"Carlos Mitidieri" <cam@sysgo.com>
Cc:	<linux-mips@linux-mips.org>,
	"Dezhong Diao (dediao)" <dediao@cisco.com>,
	"Tony Colclough (colclot)" <colclot@cisco.com>
X-OriginalArrivalTime: 20 Apr 2009 20:07:13.0067 (UTC) FILETIME=[9826E7B0:01C9C1F3]
DKIM-Signature:	v=1; a=rsa-sha256; q=dns/txt; l=1429; t=1240258033; x=1241122033;
	c=relaxed/simple; s=rtpdkim1001;
	h=Content-Type:From:Subject:Content-Transfer-Encoding:MIME-Version;
	d=cisco.com; i=dvomlehn@cisco.com;
	z=From:=20=22David=20VomLehn=20(dvomlehn)=22=20<dvomlehn@cis
	co.com>
	|Subject:=20RE=3A=20Boot=20program=20interface
	|Sender:=20
	|To:=20=22Florian=20Fainelli=22=20<florian@openwrt.org>,=0A
	=20=20=20=20=20=20=20=20=22Carlos=20Mitidieri=22=20<cam@sysg
	o.com>;
	bh=BO9h8QJzZDvlp9yexDwmi5AuvSMIrf8QP0iT2dqd/rE=;
	b=qGM3AIESZoXFrO1YL6skVip+SSRr2YSJwJ2TND2+8U1nvDjPdq6PCFKOWU
	bTn4WVcXP6v3mXzddhXZOlzk4Kl3iKQvzc3ALYOCPM7LdujPC429sDludHif
	OWFqr17Ao3;
Authentication-Results:	rtp-dkim-1; header.From=dvomlehn@cisco.com; dkim=pass (
	sig from cisco.com/rtpdkim1001 verified; ); 
Return-Path: <dvomlehn@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22391
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dvomlehn@cisco.com
Precedence: bulk
X-list: linux-mips

We have a working version of the device tree for MIPS. I'll see if we can expedite a patch. 

> -----Original Message-----
> From: linux-mips-bounce@linux-mips.org 
> [mailto:linux-mips-bounce@linux-mips.org] On Behalf Of 
> Florian Fainelli
> Sent: Monday, April 20, 2009 1:57 AM
> To: Carlos Mitidieri
> Cc: linux-mips@linux-mips.org
> Subject: Re: Boot program interface
> 
> Hi Carlos,
> 
> Le Monday 20 April 2009 09:37:25 Carlos Mitidieri, vous avez écrit :
> > Hello,
> >
> > I am working on a project that requires an extensive boot program
> > interface.
> >
> > It turns out that the device tree used on PPC architecture meets the
> > requirements.
> >
> > I have been looking, and I could not find any similar 
> concept implemented
> > for MIPS.
> 
> I do not know any MIPS board using a device tree either.
> 
> >
> > So, I am now considering to port the OFDT library into the 
> MIPS arch.
> >
> > What do you think about this? Is there anyone working on a 
> similar project?
> 
> You should see how Sparc, PowerPC and Microblaze use it and 
> how they do share 
> code. Also condiser seeing how u-boot handles device trees, 
> specifically on 
> PowerPC and Microblaze.
> 
> Hope that helps.
> -- 
> Best regards, Florian Fainelli
> Email : florian@openwrt.org
> http://openwrt.org
> -------------------------------
> 
