Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Dec 2004 18:18:10 +0000 (GMT)
Received: from darwaza.gdatech.com ([IPv6:::ffff:66.237.41.98]:35398 "EHLO
	kings.gdatech.com") by linux-mips.org with ESMTP
	id <S8225262AbULISSG>; Thu, 9 Dec 2004 18:18:06 +0000
Received: from kings.gdatech.com (localhost.localdomain [127.0.0.1])
	by kings.gdatech.com (Postfix) with ESMTP id 6512161C0E3;
	Thu,  9 Dec 2004 10:13:03 -0800 (PST)
X-Propel-Return-Path: <gmuruga@gdatech.com>
Received: from kings.gdatech.com ([192.168.200.118])
	by localhost.localdomain ([127.0.0.1]) (port 7027) (Propel SE relay 0.1.0.1557 $Rev$)
	id r4cI101303-1083-1
	for linux-mips@linux-mips.org mlachwani@mvista.com; Thu, 09 Dec 2004 10:13:03 -0800
Received: from sierra.gdatech.com (asg_mda [192.168.200.112])
	by kings.gdatech.com (Postfix) with ESMTP id 3238B61C0D2;
	Thu,  9 Dec 2004 10:13:03 -0800 (PST)
Received: (from nobody@localhost)
	by gdatech.com (8.11.6/8.11.6) id iB9IE1U27643;
	Thu, 9 Dec 2004 10:14:01 -0800
X-RAV-AntiVirus: This e-mail has been scanned for viruses on host: gdatech.com
Date: Thu, 9 Dec 2004 10:14:01 -0800
Message-Id: <200412091814.iB9IE1U27643@gdatech.com>
X-Authentication-Warning: sierra.gdatech.com: nobody set sender to gmuruga@gdatech.com using -f
From: "Muruga Ganapathy" <gmuruga@gdatech.com>
To: Manish Lachwani <mlachwani@mvista.com>,
	Muruga Ganapathy <gmuruga@gdatech.com>,
	linux-mips@linux-mips.org
Subject: Re: Forcing IDE to work in PIO mode
X-Mailer: NeoMail 1.25
X-IPAddress: 63.111.213.196
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-Path: <gmuruga@gdatech.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6620
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gmuruga@gdatech.com
Precedence: bulk
X-list: linux-mips

Thanks Manish for the information.  
 
BTW, do you have patch to make the swarm IDE work in 2.6.6-rc3 
 
Regards 
G.Muruganandam 
 
 
> Muruga Ganapathy wrote: 
> > Hello,  
> >  
> > How do I force the IDE to work in the PIO mode by including the  
> > option like "hdb=noprobe" in the setup.c? 
> >  
> >  
> > My kernel version is 2.6.6 
> >  
> > Thanks 
> > G.Muruganandam 
> >  
>  
> Hello ! 
>  
> I would have thought "ide=nodma" at the command line would have 
worked 
>  
> Thanks 
> Manish Lachwani 
>  
>  
 
************************************************************* 
GDA Technologies, Inc.		 
1010 Rincon Circle  
San Jose CA, 95131 
Phone	(408) 432-3090 
Fax	(408) 432-3091 
 
Accelerate Your Innovation	 
************************************************************** 
