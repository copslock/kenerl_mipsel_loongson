Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g56FVFnC025980
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 6 Jun 2002 08:31:15 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g56FVEUW025979
	for linux-mips-outgoing; Thu, 6 Jun 2002 08:31:14 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from cygnus.com (sunnyvale.sfbay.redhat.com [205.180.83.203])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g56FV7nC025975
	for <linux-mips@oss.sgi.com>; Thu, 6 Jun 2002 08:31:08 -0700
Received: from porcupine.cygnus.com (romulus.sfbay.redhat.com [172.16.27.251])
	by runyon.cygnus.com (8.8.7-cygnus/8.8.7) with ESMTP id IAA16352
	for <linux-mips@oss.sgi.com>; Thu, 6 Jun 2002 08:33:07 -0700 (PDT)
Received: from porcupine.cygnus.com (IDENT:VbnuvRnlaUY1LR9tOyR40Hp66/VNwhMw@localhost.localdomain [127.0.0.1])
	by porcupine.cygnus.com (8.12.2/8.12.2) with ESMTP id g56FaII7008964;
	Thu, 6 Jun 2002 09:36:18 -0600
Received: from porcupine.cygnus.com (law@localhost)
	by porcupine.cygnus.com (8.12.2/8.12.2/Submit) with ESMTP id g56FaHcs008961;
	Thu, 6 Jun 2002 09:36:17 -0600
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Phil Edwards <phil@jaj.com>
cc: Dominic Sweetman <dom@algor.co.uk>, Joe Buck <Joe.Buck@synopsys.com>,
   Eric Christopher <echristo@redhat.com>,
   Johannes Stezenbach <js@convergence.de>, gcc@gcc.gnu.org,
   linux-mips@oss.sgi.com, sde@algor.co.uk
Subject: Re: [Fwd: Current state of MIPS16 support?] 
Reply-To: law@redhat.com
From: law@redhat.com
In-reply-to: Your message of Thu, 06 Jun 2002 05:59:18 EDT.
             <20020606055918.A13788@disaster.basement.lan> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 06 Jun 2002 09:36:17 -0600
Message-ID: <8960.1023377777@porcupine.cygnus.com>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

In message <20020606055918.A13788@disaster.basement.lan>, Phil Edwards writes:
 > > >  > I signed the assignment/waiver.  The companies involved are
 > > >  > Algorithmics Ltd and DFS3 Ltd.  It was faxed to Jim Wilson (then at
 > > >  > Cygnus) in October 1993 in the form recommended at that time.  Here's
 > > >  > a PDF.  Note the 'company stationery' has changed since 1993...
 > > > 
 > > > What's important here is the assignment that is on file with the FSF.  T
 > hat's
 > > > what needs to be checked.  
 > > 
 > > Are you in a position to do that?  If not, who is?
 > > 
 > > -- 
 > > Dominic Sweetman, 
 > > Algorithmics Ltd
 > 
 > Here's what's on file:
 > 
 >     BINUTILS    Algorithmics Ltd.   1997-08-20
 >     Assigns changes.
 > 
 >     GCC Algorithmics Ltd.   1997-08-20
 >     Assigns changes.
 > 
 >     GDB Algorithmics Ltd.   1997-08-20
 >     Assigns changes.
 > 
 > There's also a disclaimer for changes to Emacs, if that matters here.  :-)
Thanks.  This likely means that we're better off getting a new assignment --
this kind of language "Assigns changes" typically means an assignment for a
specific set of changes.  If the scope of the changes increased over time,
then the new changes would not be covered by the old assignment.

I'd be much more comfortable if Algorithmics would sign a past & future 
assignment for binutils, gcc & gdb.

jeff
