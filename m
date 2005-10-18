Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Oct 2005 18:53:44 +0100 (BST)
Received: from web207.biz.mail.re2.yahoo.com ([68.142.224.169]:37737 "HELO
	web207.biz.mail.re2.yahoo.com") by ftp.linux-mips.org with SMTP
	id S8133625AbVJRRx0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 18 Oct 2005 18:53:26 +0100
Received: (qmail 71934 invoked by uid 60001); 18 Oct 2005 17:53:15 -0000
Message-ID: <20051018175314.71928.qmail@web207.biz.mail.re2.yahoo.com>
Received: from [161.88.255.139] by web207.biz.mail.re2.yahoo.com via HTTP; Tue, 18 Oct 2005 10:53:14 PDT
Date:	Tue, 18 Oct 2005 10:53:14 -0700 (PDT)
From:	Peter Popov <ppopov@embeddedalley.com>
Subject: RE: power management on mips
To:	"Mitchell, Earl" <earlm@mips.com>,
	Ivan Korzakow <ivan.korzakow@gmail.com>,
	linux-mips@linux-mips.org
In-Reply-To: <3CB54817FDF733459B230DD27C690CEC01049435@Exchange.MIPS.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9256
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips




> I think. While back I read that MontaVista and IBM
> were working on 
> something called Dynamic Power Mgmt (DPM). Might
> want to check that out? 
> See links below. 

That's alive and well in shipping mobile phones and
perhaps other devices. However, it requires quite a
bit of work to port it to a new architecture/cpu and 
as far as I know it never went mainstream. You'll end
up with somewhat of a custom PM solution. Nothing
wrong with that, as long as you're willing to maintain
it internally as your kernel revs forward.

Pete
 
> -earlm
>  
> http://www.linuxdevices.com/news/NS4297534594.html
>
http://tree.celinuxforum.org/CelfPubWiki/PowerManagementDefinitionOfTerms_5fR2
>  
> 
> 
> > -----Original Message-----
> > From: linux-mips-bounce@linux-mips.org
> > [mailto:linux-mips-bounce@linux-mips.org]On Behalf
> Of Ivan Korzakow
> > Sent: Tuesday, October 18, 2005 9:01 AM
> > To: linux-mips@linux-mips.org
> > Subject: power management on mips
> > 
> > 
> > Hi list,
> > 
> > Does anyone knows what power management features
> are there for mips ?
> > I know for example that ACPI have been porting to
> arm. Anything
> > equivalent for mips ? Is it possible to do some
> power management under
> > Linux if ACPI or APM is not ported to mips ? And
> if yes, what would be
> > the work to do ?
> > 
> > Thanks in advance,
> > 
> > Ivan
> > 
> > 
> 
> 
