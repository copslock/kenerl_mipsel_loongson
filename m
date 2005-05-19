Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 May 2005 14:52:36 +0100 (BST)
Received: from web32510.mail.mud.yahoo.com ([IPv6:::ffff:68.142.207.220]:12475
	"HELO web32510.mail.mud.yahoo.com") by linux-mips.org with SMTP
	id <S8225991AbVESNwP>; Thu, 19 May 2005 14:52:15 +0100
Received: (qmail 7763 invoked by uid 60001); 19 May 2005 13:52:07 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=lXetiXazeGIiuYQK8Elb0KEwflTD5c23jCuDBo9kFVAY7dMemAkPo0mmDZlQES8ed+jB+pEBE2QcbzFc6rXIdb4WUPuYA+mp2qW1J5jfXMOUboYBp25GtndLNO1xp84eIoU8BW8/mugBSBh7Qr9mIpC7Jv5i9QBldhnoyDKmVu4=  ;
Message-ID: <20050519135207.7760.qmail@web32510.mail.mud.yahoo.com>
Received: from [85.250.113.238] by web32510.mail.mud.yahoo.com via HTTP; Thu, 19 May 2005 06:52:07 PDT
Date:	Thu, 19 May 2005 06:52:07 -0700 (PDT)
From:	Michael Belamina <belamina1@yahoo.com>
Subject: Re: 64 bit kernel for BCM1250
To:	David Daney <ddaney@avtrex.com>,
	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Michael Belamina <belamina1@yahoo.com>, linux-mips@linux-mips.org
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <belamina1@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7932
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: belamina1@yahoo.com
Precedence: bulk
X-list: linux-mips

Hi,

   Thanks very much for your replies and the valuable
info. 
   I am still not sure about the following:

   1. Is this problem related only to kernels
downloaded from linux-mips.org or it is a more general
one?

   2. Can someone point to a known to work 64 bit
versions of gcc and binutil for BCM1250 (the problem
that started this thread was actually a problem of the
mip64-linux-ld I was using).
    
Thanks,
 Michael



--- David Daney <ddaney@avtrex.com> wrote:
> Maciej W. Rozycki wrote:
> > On Wed, 18 May 2005, David Daney wrote:
> > 
> > 
> >>I saw this with a 32 bit kernel (for a 32 bit
> target).  As far as I know, no
> >>2.4.x kernels from linux-mips.org will work with
> gcc 3.4.x.
> > 
> > 
> >  That could actually be true -- I've been using
> GCC 4.0.0 for quite some 
> > time now (that includes CVS snapshots from before
> the release), so I have 
> > no slightest idea whether it's OK to use older
> versions. ;-)
> > 
> > 
> >>I have previously posted patches to this list that
> fixed the problem for me.
> >>Specifically I think the messages in this thread
> are relevant:
> >>
>
>>http://www.linux-mips.org/cgi-bin/mesg.cgi?a=linux-mips&i=41AFDA18.2010906%40avtrex.com
> > 
> > 
> >  Hasn't one of the proposed fixes for the bug made
> its way to Linux in the 
> > end?  That would be regrettable...
> > 
> 
> WRT the 2.4 kernel the answer seems to be no.  And
> yes I think it is 
> regrettable.
> 
> If anybody thinks it would be useful, I could post
> my current patch again.
> 
> David Daney.
> 


		
__________________________________ 
Do you Yahoo!? 
Yahoo! Mail - Helps protect you from nasty viruses. 
http://promotions.yahoo.com/new_mail
