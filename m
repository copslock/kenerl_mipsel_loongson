Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Jul 2005 17:00:36 +0100 (BST)
Received: from eth13.com-link.com ([IPv6:::ffff:208.242.241.164]:37344 "EHLO
	real.realitydiluted.com") by linux-mips.org with ESMTP
	id <S8226159AbVGAQAM>; Fri, 1 Jul 2005 17:00:12 +0100
Received: from sjhill by real.realitydiluted.com with local (Exim 4.50 #1 (Debian))
	id 1DoN00-0007Jb-Gs; Fri, 01 Jul 2005 10:00:12 -0500
Subject: Re: I built a mipsel-linux toolchain, but it doesn't work
In-Reply-To: <42C565AC.4060300@avtrex.com>
To:	David Daney <ddaney@avtrex.com>
Date:	Fri, 1 Jul 2005 10:00:12 -0500 (CDT)
CC:	moreau francis <francis_moreau2000@yahoo.fr>,
	zhan rongkai <zhanrk@gmail.com>, linux-mips@linux-mips.org
X-Mailer: ELM [version 2.4ME+ PL100 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <E1DoN00-0007Jb-Gs@real.realitydiluted.com>
From:	sjhill@realitydiluted.com
Return-Path: <sjhill@realitydiluted.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8312
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@realitydiluted.com
Precedence: bulk
X-list: linux-mips

> moreau francis wrote:
> > Could you develop please ? What kind of config/hack does Buildroot to be able
> > to use GCC with uClibc ?
> > 
> 
> It is quite complicated, but you can find a summary on this web page:
> 
> http://www.google.com/search?q=uclibc+buildroot
> 
Here is the page for it:

   http://buildroot.uclibc.org/

The mipsel target is supported and will build for your needs. Do not
use uClibc-0.9.27 when you configure your buildroot system. Use the
latest uClibc snapshot. There are issues with uClibc-0.9.27 with MIPS
targets.

-Steve
