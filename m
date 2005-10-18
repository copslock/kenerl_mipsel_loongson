Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Oct 2005 19:01:51 +0100 (BST)
Received: from 209-232-97-206.ded.pacbell.net ([209.232.97.206]:65210 "EHLO
	dns0.mips.com") by ftp.linux-mips.org with ESMTP id S8133625AbVJRSBf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 18 Oct 2005 19:01:35 +0100
Received: from mercury.mips.com (sbcns-dmz [209.232.97.193])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id j9II1Ka7022727;
	Tue, 18 Oct 2005 11:01:20 -0700 (PDT)
Received: from exchange.MIPS.COM (exchange [192.168.20.29])
	by mercury.mips.com (8.12.9/8.12.11) with ESMTP id j9II1I17000733;
	Tue, 18 Oct 2005 11:01:18 -0700 (PDT)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: RE: power management on mips
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Date:	Tue, 18 Oct 2005 11:01:18 -0700
Message-ID: <3CB54817FDF733459B230DD27C690CEC01049437@Exchange.MIPS.COM>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: power management on mips
thread-index: AcXUDQcWjrlrWVtwQbyMeZv/U4DdxAAABCKQ
From:	"Mitchell, Earl" <earlm@mips.com>
To:	"Peter Popov" <ppopov@embeddedalley.com>,
	"Ivan Korzakow" <ivan.korzakow@gmail.com>,
	<linux-mips@linux-mips.org>
X-Scanned-By: MIMEDefang 2.39
Return-Path: <earlm@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9257
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: earlm@mips.com
Precedence: bulk
X-list: linux-mips


True. PDAs and mobile devices also use it. 
So it may be supported for platforms like
AMD's Alchemy (e.g. they have a PDA reference design).

-earlm

> -----Original Message-----
> From: linux-mips-bounce@linux-mips.org
> [mailto:linux-mips-bounce@linux-mips.org]On Behalf Of Peter Popov
> Sent: Tuesday, October 18, 2005 10:53 AM
> To: Mitchell, Earl; Ivan Korzakow; linux-mips@linux-mips.org
> Subject: RE: power management on mips
> 
> 
> 
> 
> 
> > I think. While back I read that MontaVista and IBM
> > were working on 
> > something called Dynamic Power Mgmt (DPM). Might
> > want to check that out? 
> > See links below. 
> 
> That's alive and well in shipping mobile phones and
> perhaps other devices. However, it requires quite a
> bit of work to port it to a new architecture/cpu and 
> as far as I know it never went mainstream. You'll end
> up with somewhat of a custom PM solution. Nothing
> wrong with that, as long as you're willing to maintain
> it internally as your kernel revs forward.
> 
> Pete
>  
> > -earlm
> >  
> > http://www.linuxdevices.com/news/NS4297534594.html
> >
> http://tree.celinuxforum.org/CelfPubWiki/PowerManagementDefini
tionOfTerms_5fR2
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
