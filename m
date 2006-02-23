Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Feb 2006 21:51:51 +0000 (GMT)
Received: from smtp105.biz.mail.mud.yahoo.com ([68.142.200.253]:38844 "HELO
	smtp105.biz.mail.mud.yahoo.com") by ftp.linux-mips.org with SMTP
	id S8133474AbWBWVvm (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 23 Feb 2006 21:51:42 +0000
Received: (qmail 37112 invoked from network); 23 Feb 2006 21:58:49 -0000
Received: from unknown (HELO ?192.168.1.100?) (ppopov@embeddedalley.com@71.128.175.242 with plain)
  by smtp105.biz.mail.mud.yahoo.com with SMTP; 23 Feb 2006 21:58:48 -0000
Subject: Re: gdb/kgdb register mismatch
From:	Pete Popov <ppopov@embeddedalley.com>
Reply-To: ppopov@embeddedalley.com
To:	Daniel Jacobowitz <dan@debian.org>
Cc:	"'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
In-Reply-To: <20060223213124.GA3638@nevyn.them.org>
References: <1140723606.11388.321.camel@localhost.localdomain>
	 <20060223213124.GA3638@nevyn.them.org>
Content-Type: text/plain
Organization: Embedded Alley Solutions, Inc
Date:	Thu, 23 Feb 2006 13:58:31 -0800
Message-Id: <1140731911.11388.352.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10628
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips

On Thu, 2006-02-23 at 16:31 -0500, Daniel Jacobowitz wrote:
> On Thu, Feb 23, 2006 at 11:40:06AM -0800, Pete Popov wrote:
> > 
> > I'm having the following problems with gdb/kgdb:
> > 
> > 64bit CPU, running a 32 bit kernel. When I break at a certain point, I
> > can see that the kernel kgdb stub appears to be sending the correct
> > register information, where each reg value written in the kgdb packet is
> > 32bit. However, the cross gdb client seems to be interpreting, or
> > expecting, 64bit register values so it 'skips' over every other value.
> > For example:
> > 
> > reg values sent by kgdb:      reg values shown by gdb client:
> > reg 0:  0x00000000            reg0:  0x00000001
> > reg 1:  0x00000001            reg1:  0x00000002
> > reg 2:  0x00000002            reg2:  0x00000004
> > reg 3:  0x00000003
> > reg 4:  0x00000004
> > 
> > Should the kgdb stub be sending 64bit values for the registers, even
> > though it's a 32bit kernel?  If the stub is supposed to be sending 32bit
> > register values, any suggestion why cross gdb is not interpreting them
> > correctly?
> 
> This is a FAQ; it's a bug in GDB that will be fixed someday, but for
> now use "set architecture mips:isa32".

It works, thanks! I'm not sure how well documented this is but perhaps
it's just because I don't use kgdb often.

Pete
