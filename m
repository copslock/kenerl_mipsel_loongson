Received:  by oss.sgi.com id <S305163AbQBQQlI>;
	Thu, 17 Feb 2000 08:41:08 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:2634 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305159AbQBQQlC>;
	Thu, 17 Feb 2000 08:41:02 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id IAA02967; Thu, 17 Feb 2000 08:36:31 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id IAA76557
	for linux-list;
	Thu, 17 Feb 2000 08:27:34 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id IAA55302;
	Thu, 17 Feb 2000 08:27:26 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id IAA06167; Thu, 17 Feb 2000 08:27:29 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from cacc-27.uni-koblenz.de (cacc-27.uni-koblenz.de [141.26.131.27])
	by mailhost.uni-koblenz.de (8.9.3/8.9.3) with ESMTP id RAA24597;
	Thu, 17 Feb 2000 17:27:20 +0100 (MET)
Received:  by lappi.waldorf-gmbh.de id <S407918AbQBQO1L>;
	Thu, 17 Feb 2000 15:27:11 +0100
Date:   Thu, 17 Feb 2000 15:27:11 +0100
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     "Kevin D. Kissell" <kevink@mips.com>
Cc:     "William J. Earl" <wje@cthulhu.engr.sgi.com>,
        linux-mips@vger.rutgers.edu, linux-mips@fnet.fr,
        linux@cthulhu.engr.sgi.com
Subject: Re: Indy crashes
Message-ID: <20000217152711.E5436@uni-koblenz.de>
References: <00bf01bf78ce$37cf6cc0$0ceca8c0@satanas.mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <00bf01bf78ce$37cf6cc0$0ceca8c0@satanas.mips.com>
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Wed, Feb 16, 2000 at 11:33:33PM +0100, Kevin D. Kissell wrote:

> > > Thirdly, this whole thread underscores why "clever" solutions that 
> > > depend on implementation features of particular CPUs should 
> > > be avoided whenever possible. If you want to be assured of
> > > getting a delay cycle in a MIPS instruction stream, you should
> > > use a "SSNOP", (sll r0,r0,1 as opposed to the "nop" sll r0,r0,0),
> > > which forces delays even in superscalar implementations.
> >
> >      This is not realistic, given the number of workarounds required
> >for various processors, unless you are willing to have most processors
> >run quite a bit slower.  (Extra cycles in utlbmiss are noticeable.)
> 
> I agree that it is not realistic to hav a single binary TLB miss handler
> for all possible MIPS CPUs, but that's not what I was getting at.
> I just consider it unwise to use the fact that one "knows" that branches 
> "always" delay three cycles to avoid hazards.  Such tricks are 
> obscurantist, and lead, in my experience, to errors.

Maybe but then again TLB exception handles aren't supposed to be hacked
by Joe Random Hacker.  There is more to know about the real silicon
beaviour than what the manuals say.  So for example some of the documentation
regarding c0 hazards on the R4000 is plain wrong for certain CPU revisions.

The TLB exception handlers really deserve a rewrite.  Somebody at QED
once called them the longest ones he has ever seen.

  Ralf
