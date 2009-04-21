Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Apr 2009 07:33:39 +0100 (BST)
Received: from mail.sysgo.com ([195.145.229.155]:34954 "EHLO mail.sysgo.com")
	by ftp.linux-mips.org with ESMTP id S20022941AbZDUGdc (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 21 Apr 2009 07:33:32 +0100
Received: by mail.sysgo.com (Postfix, from userid 1001)
	id F230260015; Tue, 21 Apr 2009 08:32:34 +0200 (CEST)
Received: from mail.sysgo.com (localhost [127.0.0.1])
	by mail.sysgo.com (Postfix) with ESMTP id 83B1D60017;
	Tue, 21 Apr 2009 08:32:24 +0200 (CEST)
Received: from www.sysgo.com (www.sysgo.com [195.145.229.156])
	by mail.sysgo.com (Postfix) with ESMTP id 775B460015;
	Tue, 21 Apr 2009 08:32:24 +0200 (CEST)
Received: by www.sysgo.com (Postfix, from userid 33)
	id 6487A134316; Tue, 21 Apr 2009 08:32:23 +0200 (CEST)
Received: from 192.100.130.228 ([192.100.130.228]) 
	by www.sysgo.com (IMP) with HTTP 
	for <cam@172.20.1.30>; Tue, 21 Apr 2009 08:32:23 +0200
Message-ID: <1240295543.49ed68774daf3@www.sysgo.com>
Date:	Tue, 21 Apr 2009 08:32:23 +0200
From:	Carlos Mitidieri <cam@sysgo.com>
To:	"David VomLehn (dvomlehn)" <dvomlehn@cisco.com>
Cc:	Florian Fainelli <florian@openwrt.org>, linux-mips@linux-mips.org,
	"Dezhong Diao (dediao)" <dediao@cisco.com>,
	"Tony Colclough (colclot)" <colclot@cisco.com>
Subject: RE: Boot program interface
References: <1240213045.49ec26350fa49@www.sysgo.com> <200904201057.04833.florian@openwrt.org> <FF038EB85946AA46B18DFEE6E6F8A2890105326D@xmb-rtp-218.amer.cisco.com>
In-Reply-To: <FF038EB85946AA46B18DFEE6E6F8A2890105326D@xmb-rtp-218.amer.cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
User-Agent: Internet Messaging Program (IMP) 3.2.6
X-Originating-IP: 192.100.130.228
X-AV-Checked: ClamAV using ClamSMTP
Return-Path: <cam@sysgo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22394
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cam@sysgo.com
Precedence: bulk
X-list: linux-mips

Hello,

That would be nice. Would be that convenient, I am willing to help.

Best regards,


Quoting "David VomLehn (dvomlehn)" <dvomlehn@cisco.com>:

> We have a working version of the device tree for MIPS. I'll see if we can
> expedite a patch.
>
> > -----Original Message-----
> > From: linux-mips-bounce@linux-mips.org
> > [mailto:linux-mips-bounce@linux-mips.org] On Behalf Of
> > Florian Fainelli
> > Sent: Monday, April 20, 2009 1:57 AM
> > To: Carlos Mitidieri
> > Cc: linux-mips@linux-mips.org
> > Subject: Re: Boot program interface
> >
> > Hi Carlos,
> >
> > Le Monday 20 April 2009 09:37:25 Carlos Mitidieri, vous avez écrit :
> > > Hello,
> > >
> > > I am working on a project that requires an extensive boot program
> > > interface.
> > >
> > > It turns out that the device tree used on PPC architecture meets the
> > > requirements.
> > >
> > > I have been looking, and I could not find any similar
> > concept implemented
> > > for MIPS.
> >
> > I do not know any MIPS board using a device tree either.
> >
> > >
> > > So, I am now considering to port the OFDT library into the
> > MIPS arch.
> > >
> > > What do you think about this? Is there anyone working on a
> > similar project?
> >
> > You should see how Sparc, PowerPC and Microblaze use it and
> > how they do share
> > code. Also condiser seeing how u-boot handles device trees,
> > specifically on
> > PowerPC and Microblaze.
> >
> > Hope that helps.
> > --
> > Best regards, Florian Fainelli
> > Email : florian@openwrt.org
> > http://openwrt.org
> > -------------------------------
> >
>


-- 
Carlos Mitidieri
Project Engineer
