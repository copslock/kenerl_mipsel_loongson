Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f52LTJH30884
	for linux-mips-outgoing; Sat, 2 Jun 2001 14:29:19 -0700
Received: from algonet.se (delenn.tninet.se [195.100.94.104])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f52LTIh30880
	for <linux-mips@oss.sgi.com>; Sat, 2 Jun 2001 14:29:18 -0700
Received: from  aristotle.algonet.se (aristotle.algonet.se [194.213.74.200])
 by delenn.tninet.se (BLUETAIL Mail Robustifier 2.2.2) with ESMTP
 id 693603.517351.991delenn-s0 for <linux-mips@oss.sgi.com>
 ; Sat, 02 Jun 2001 23:29:11 +0200
Date: Sat, 2 Jun 2001 23:29:11 +0200 (MET DST)
From: Yann Vernier <yann@algonet.se>
To: linux-mips@oss.sgi.com
Subject: Re: Challenge S SCSI adapter - Ethernet?
In-Reply-To: <20010602153549.A8637@bacchus.dhis.org>
Message-ID: <Pine.SOL.4.10.10106022327220.3414-100000@aristotle.algonet.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sat, 2 Jun 2001, Ralf Baechle wrote:
> On Fri, Jun 01, 2001 at 03:15:44PM +0200, Kristoffer Gleditsch wrote:
> > We got our hands on a Challenge S the other day.  We're planning to
> > install Linux on it and let it do something useful, but we don't have
> > any use for the SCSI adapter.  If anyone out there are working on
> > Linux drivers for these cards, we'd be happy to let them have it.  If
> > anyone is interested, send me a mail.
> 
> Currently there is no ongoing driver work for the WD33C95 secondary SCSI
> hostadapter in Challenge S and other SGI systems.

I have a Challenge S machine, and I'm interested in support for the other
function of its GIO64 expansion card; the secondary Ethernet port, known
as ec3 under Irix. Has anyone looked at getting that to work under Linux?
I would like to use the machine as a router.
