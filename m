Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Jan 2006 02:40:26 +0000 (GMT)
Received: from smtp101.biz.mail.mud.yahoo.com ([68.142.200.236]:35205 "HELO
	smtp101.biz.mail.mud.yahoo.com") by ftp.linux-mips.org with SMTP
	id S3465743AbWAECkF (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 5 Jan 2006 02:40:05 +0000
Received: (qmail 61472 invoked from network); 5 Jan 2006 02:42:29 -0000
Received: from unknown (HELO ?192.168.1.102?) (ppopov@embeddedalley.com@63.194.214.47 with plain)
  by smtp101.biz.mail.mud.yahoo.com with SMTP; 5 Jan 2006 02:42:29 -0000
Subject: Re: smc91x support
From:	Pete Popov <ppopov@embeddedalley.com>
Reply-To: ppopov@embeddedalley.com
To:	Matej Kupljen <matej.kupljen@ultra.si>
Cc:	"'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
In-Reply-To: <1136409832.11317.54.camel@orionlinux.starfleet.com>
References: <1131634331.18165.30.camel@localhost.localdomain>
	 <1131636585.4890.14.camel@localhost.localdomain>
	 <1136409832.11317.54.camel@orionlinux.starfleet.com>
Content-Type: text/plain
Organization: Embedded Alley Solutions, Inc
Date:	Wed, 04 Jan 2006 18:42:28 -0800
Message-Id: <1136428948.8379.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9777
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips

On Wed, 2006-01-04 at 22:23 +0100, Matej Kupljen wrote:
> Hi 
> 
> > > smc91x platform support; requires patch to smc91x.h which was sent
> > >         upstream.
> > > 
> > > Any news about this?
> > > What is the patch required for smc91x.h?
> > 
> > I have to check with Nicolas Pitre.
> 
> Pete, did you see this:
> http://lists.arm.linux.org.uk/pipermail/linux-arm-kernel/2006-January/033064.html
> 
> Will it work for MIPS and especially for DBAU12100?

Someone has to try it and send Nicolas an incremental patch if it
doesn't work for the dbau1200.  I have a dbau1200 so I'll try it at some
point but Jordan might beat me to it.

Pete
