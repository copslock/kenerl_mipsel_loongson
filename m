Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Nov 2002 23:10:21 +0100 (CET)
Received: from crack.them.org ([65.125.64.184]:24584 "EHLO crack.them.org")
	by linux-mips.org with ESMTP id <S1121743AbSKGWKU>;
	Thu, 7 Nov 2002 23:10:20 +0100
Received: from nevyn.them.org ([66.93.61.169] ident=mail)
	by crack.them.org with asmtp (Exim 3.12 #1 (Debian))
	id 189wiZ-0001zF-00; Thu, 07 Nov 2002 18:09:47 -0600
Received: from drow by nevyn.them.org with local (Exim 3.36 #1 (Debian))
	id 189ur7-0007lS-00; Thu, 07 Nov 2002 17:10:29 -0500
Date: Thu, 7 Nov 2002 17:10:29 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Bradley Bozarth <bbozarth@cisco.com>
Cc: linux-mips@linux-mips.org, george@mvista.com
Subject: Re: SEGEV defines
Message-ID: <20021107221029.GA22385@nevyn.them.org>
References: <Pine.GSO.3.96.1021107201241.5894L-100000@delta.ds2.pg.gda.pl> <Pine.LNX.4.44.0211071229340.7794-100000@bbozarth-lnx.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211071229340.7794-100000@bbozarth-lnx.cisco.com>
User-Agent: Mutt/1.5.1i
Return-Path: <drow@false.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 602
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

Presumably they match IRIX... like the rest of MIPS's oddball
definitions.  A little hard to change them now.

On Thu, Nov 07, 2002 at 12:33:55PM -0800, Bradley Bozarth wrote:
> Can these be changed?
> 
> > Now a question, why does mips use these values:                               
> >  #define SIGEV_SIGNAL   129     /* notify via signal */                       
> >  #define SIGEV_CALLBACK 130     /* ??? */                                     
> >  #define SIGEV_THREAD   131     /* deliver via thread                         
> > creation */                                                                   
> >                                                                               
> > It is the only platform that adds anything to the simple                      
> > 1,2,3 values used on other platforms.  The reason I ask, is                   
> > that I would like to change them to conform to all the                        
> > others.
> 
> 
> 
> 
> 

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
