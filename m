Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 22 May 2005 21:32:12 +0100 (BST)
Received: from web32515.mail.mud.yahoo.com ([IPv6:::ffff:68.142.207.225]:16766
	"HELO web32515.mail.mud.yahoo.com") by linux-mips.org with SMTP
	id <S8225002AbVEVUby>; Sun, 22 May 2005 21:31:54 +0100
Received: (qmail 24630 invoked by uid 60001); 22 May 2005 20:31:46 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=jtAqPDI3rbSfflz3tRYrCVGQCmm9WeG9x1GafKlKH/RXvFhYYIMRdshgGJkbb9Yy7puSb4JmxBYqostgXn2SUFdqfaxp+x2T5C72tcTOoUSWUZWGSvcE2zh3MPblZ1azMraeCcMN4AyaPikiVU0qpBkI0nt4MUzAZOy4GpLsoSU=  ;
Message-ID: <20050522203146.24628.qmail@web32515.mail.mud.yahoo.com>
Received: from [217.132.151.249] by web32515.mail.mud.yahoo.com via HTTP; Sun, 22 May 2005 13:31:46 PDT
Date:	Sun, 22 May 2005 13:31:46 -0700 (PDT)
From:	Michael Belamina <belamina1@yahoo.com>
Subject: Re: 64 bit kernel for BCM1250
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	David Daney <ddaney@avtrex.com>, linux-mips@linux-mips.org
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <belamina1@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7942
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: belamina1@yahoo.com
Precedence: bulk
X-list: linux-mips


  Thanks you all for your replies.
  I will check this out and post the outcome.

 Michael

  


--- "Maciej W. Rozycki" <macro@linux-mips.org> wrote:
> On Thu, 19 May 2005, Michael Belamina wrote:
> 
> >    I am still not sure about the following:
> > 
> >    1. Is this problem related only to kernels
> > downloaded from linux-mips.org or it is a more
> general
> > one?
> 
>  The problem is Linux 2.4 is generally in the
> maintenance mode, which 
> means no new development is done on it (although
> still an occasional 
> backport from 2.6 may happen).  As a result
> maintainers are rather 
> hesitant about applying changes unless they fix
> critical bugs.  Bugs 
> revealed by new versions of build tools are not
> usually considered as 
> critical, because you may work them around by using
> an old version of the 
> triggering tool.
> 
>  Still for the MIPS port what you can get from
> linux-mips.org is probably 
> less behind than what there is at kernel.org.
> 
> >    2. Can someone point to a known to work 64 bit
> > versions of gcc and binutil for BCM1250 (the
> problem
> > that started this thread was actually a problem of
> the
> > mip64-linux-ld I was using).
> 
>  For 64-bit builds you probably want to use fairly
> recent versions or you 
> risk hitting serious bugs that used to exist in
> older versions.  Using 
> David's patch (or preferably mine ;-) -- as
> available here: 
>
"http://www.linux-mips.org/cgi-bin/mesg.cgi?a=linux-mips&i=Pine.LNX.4.55.0406281509170.23162%40jurand.ds.pg.gda.pl";
> 
> which I keep using with GCC 4.0.0) is probably the
> lesser evil.
> 
>   Maciej
> 


		
Discover Yahoo! 
Find restaurants, movies, travel and more fun for the weekend. Check it out! 
http://discover.yahoo.com/weekend.html 
