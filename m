Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 May 2003 14:37:28 +0100 (BST)
Received: from h0000c06cf87e.ne.client2.attbi.com ([IPv6:::ffff:24.147.212.21]:17157
	"EHLO compaq.parker.boston.ma.us") by linux-mips.org with ESMTP
	id <S8225265AbTEINhW>; Fri, 9 May 2003 14:37:22 +0100
Received: from p2.parker.boston.ma.us (p2 [192.245.5.16])
	by compaq.parker.boston.ma.us (8.11.6/8.11.6) with ESMTP id h49DbEH05340;
	Fri, 9 May 2003 09:37:15 -0400
Received: from p2 (brad@localhost)
	by p2.parker.boston.ma.us (8.11.6/8.11.6) with ESMTP id h49DbEL17415;
	Fri, 9 May 2003 09:37:14 -0400
Message-Id: <200305091337.h49DbEL17415@p2.parker.boston.ma.us>
From: Brad Parker <brad@heeltoe.com>
To: Linux MIPS mailing list <linux-mips@linux-mips.org>
cc: baitisj@evolution.com
Subject: Re: USB OHCI device port on Alchemy 
In-Reply-To: Message from Pete Popov <ppopov@mvista.com> 
   of "08 May 2003 10:40:29 PDT." <1052415629.558.91.camel@zeus.mvista.com> 
Organization: Heeltoe Consulting
X-Mailer: MH-E 7.2; nmh 1.0.4; GNU Emacs 20.7.1
Date: Fri, 09 May 2003 09:37:14 -0400
Return-Path: <brad@parker.boston.ma.us>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2322
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: brad@heeltoe.com
Precedence: bulk
X-list: linux-mips


>On Wed, 2003-05-07 at 20:31, Jeff Baitis wrote:
>> Out of curiousity:
>> 
>> Has anyone played with the AU1X00 USB device port yet? If not, what would yo
>u
>> guys suggest that the AU1X00 appear as? USB over Ethernet? Or maybe a simple
>> dummy device that will perform bulk transfers?

I'm surprised no one has mentioned all the bugs :-)

Just so you know, the function side controller (i.e. "device") on the
au1100 is/was seriously buggy.  The folks at AMD are (or were) working
on a fix.  It was possible to get it to work, but it was very painful.

I don't remember the details of the chip revs, but as I recall all of
the au1100 parts which had been released as of the end of last year had
these bugs.

[fyi: the folks at Belcarra have done a lot of work on this problem and
know it well]

The ohci controller (i.e. "host") works fine, as far as I know, for all
modes (interrupt, bulk, isochronous).

-brad
