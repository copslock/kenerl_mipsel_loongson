Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Sep 2003 17:20:59 +0100 (BST)
Received: from mx2.redhat.com ([IPv6:::ffff:66.187.237.31]:40209 "EHLO
	mx2.redhat.com") by linux-mips.org with ESMTP id <S8225466AbTISQUx>;
	Fri, 19 Sep 2003 17:20:53 +0100
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.11.6/8.11.6) with ESMTP id h8JG3qO04466;
	Fri, 19 Sep 2003 12:03:52 -0400
Received: from potter.sfbay.redhat.com (potter.sfbay.redhat.com [172.16.27.15])
	by int-mx2.corp.redhat.com (8.11.6/8.11.6) with ESMTP id h8JGKTL20853;
	Fri, 19 Sep 2003 12:20:29 -0400
Received: from ghostwheel.sfbay.redhat.com (vpn26-2.sfbay.redhat.com [172.16.26.2])
	by potter.sfbay.redhat.com (8.11.6/8.11.6) with ESMTP id h8JGKMw20758;
	Fri, 19 Sep 2003 09:20:22 -0700
Subject: Re: recent binutils and mips64-linux
From: Eric Christopher <echristo@redhat.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>,
	Daniel Jacobowitz <dan@debian.org>, linux-mips@linux-mips.org,
	binutils@sources.redhat.com
In-Reply-To: <Pine.GSO.3.96.1030919144141.9134C-100000@delta.ds2.pg.gda.pl>
References: <Pine.GSO.3.96.1030919144141.9134C-100000@delta.ds2.pg.gda.pl>
Content-Type: text/plain
Message-Id: <1063988420.2537.5.camel@ghostwheel.sfbay.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Fri, 19 Sep 2003 09:20:20 -0700
Content-Transfer-Encoding: 7bit
Return-Path: <echristo@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3230
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: echristo@redhat.com
Precedence: bulk
X-list: linux-mips

On Fri, 2003-09-19 at 05:52, Maciej W. Rozycki wrote:
> On Thu, 18 Sep 2003, Eric Christopher wrote:
> 
> > > But mips64 kernel assumes that the kernel itself is compiled with
> > > "-mabi=64".  For example, some asm routines pass more than 4 arguments
> > > via aN registers.
> > 
> > Yes, but then you aren't abi compliant are you? If you want n64 then say
> > n64. If you want o32 extended to 64-bit registers then use o64.
> 
>  I think "-mabi=64" is OK (I use it for over a year now) and for those
> worried of every byte of precious memory, "-mabi=n32 -mlong64" might be
> the right long-term answer (although it might require verifying if tools
> handle it right).  Given the experimental state of the 64-bit kernel it
> should be OK to be less forgiving on a requirement for recent tools. 

OK as in "it works for me", and OK as in "this is the correct usage" are
two different things. I believe that for a 64-bit kernel either -mabi=64
or -mabi=n32 (-mlong64) are the right long term answer, part of Daniel's
problem was that his bootloader couldn't deal with ELF64.

-eric

-- 
Eric Christopher <echristo@redhat.com>
