Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Feb 2003 22:07:00 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:54257 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8225202AbTBUWG7>;
	Fri, 21 Feb 2003 22:06:59 +0000
Received: from zeus.mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id OAA16594;
	Fri, 21 Feb 2003 14:06:40 -0800
Subject: Re: fixup_bigphys_addr and DBAu1500 dev board
From: Pete Popov <ppopov@mvista.com>
To: Dan Malek <dan@embeddededge.com>
Cc: baitisj@evolution.com, linux-mips@linux-mips.org
In-Reply-To: <3E568ECC.2090601@embeddededge.com>
References: <200302201135.09154.krishnakumar@naturesoft.net>
	 <20030221.112456.41627052.nemoto@toshiba-tops.co.jp>
	 <20030221122515.E20129@luca.pas.lab>  <3E568ECC.2090601@embeddededge.com>
Content-Type: text/plain
Organization: MontaVista Software
Message-Id: <1045865418.16540.474.camel@zeus.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 21 Feb 2003 14:10:18 -0800
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1521
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@mvista.com
Precedence: bulk
X-list: linux-mips

On Fri, 2003-02-21 at 12:40, Dan Malek wrote:
> Jeff Baitis wrote:
> 
> > I'd love to know where this mystery fixup_bigphys_addr comes from!?
> 
> You need the 36-bit patch from Pete that is not yet part of the
> linux-mips tree.
> 
> You can find it on linux-mips.org in /pub/linux/mips/people/ppopov.

Thanks Dan.

Jeff, the patch still applies almost 100% cleanly (just a couple of
"offsets" messages). Let me know if you have problems. There is a readme
in my directory that describes all the patches. 

Pete
