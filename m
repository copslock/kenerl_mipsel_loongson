Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Jan 2006 14:15:36 +0000 (GMT)
Received: from deliver-1.mx.triera.net ([213.161.0.31]:52954 "HELO
	deliver-1.mx.triera.net") by ftp.linux-mips.org with SMTP
	id S8133500AbWADOPS (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 4 Jan 2006 14:15:18 +0000
Received: from localhost (in-1.mx.triera.net [213.161.0.25])
	by deliver-1.mx.triera.net (Postfix) with ESMTP id E0F3BC090;
	Wed,  4 Jan 2006 15:17:41 +0100 (CET)
Received: from smtp.triera.net (smtp.triera.net [213.161.0.30])
	by in-1.mx.triera.net (Postfix) with SMTP id 82BC51BC07F;
	Wed,  4 Jan 2006 15:17:45 +0100 (CET)
Received: from [172.18.1.53] (unknown [213.161.20.162])
	by smtp.triera.net (Postfix) with ESMTP id 366331A18B1;
	Wed,  4 Jan 2006 15:17:45 +0100 (CET)
Subject: Re: ALCHEMY:  AU1200 USB Host Controller (OHCI/EHCI)
From:	Matej Kupljen <matej.kupljen@ultra.si>
To:	bora.sahin@ttnet.net.tr
Cc:	matthias.lenk@amd.com, Jordan Crouse <jordan.crouse@amd.com>,
	linux-mips@linux-mips.org, linux-usb-devel@lists.sourceforge.net
In-Reply-To: <200601041554.29497.bora.sahin@ttnet.net.tr>
References: <20051208210042.GB17458@cosmic.amd.com>
	 <200601041332.16043.matthias.lenk@amd.com>
	 <1136380071.27748.49.camel@localhost.localdomain>
	 <200601041554.29497.bora.sahin@ttnet.net.tr>
Content-Type: text/plain
Date:	Wed, 04 Jan 2006 15:17:42 +0100
Message-Id: <1136384262.27748.52.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Triera AV Service
Return-Path: <matej.kupljen@ultra.si>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9774
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matej.kupljen@ultra.si
Precedence: bulk
X-list: linux-mips

Hi

> > I think Bora Sahin said he used OHCI successfully on 2.5.15-rc4.
> > Bora, can you confirm this?
> 
> Yes, it works both in my version of patch and Jordan's...
> 
> But my kernel version is 
> 	#define UTS_RELEASE "2.6.15-rc4-g2b269cc6"
> not 2.5.15-rc4

Yes, I meant the right one: 2.6.15-rc4
(I don't know what is wrong with me and those kernel versions).

So, there was some change between rc4 and rc5, that 
broke USB on Alchemey?

BR,
Matej
