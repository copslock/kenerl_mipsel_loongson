Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Jan 2004 10:59:38 +0000 (GMT)
Received: from netlx014.civ.utwente.nl ([IPv6:::ffff:130.89.1.88]:53646 "EHLO
	netlx014.civ.utwente.nl") by linux-mips.org with ESMTP
	id <S8225299AbUA3K7i>; Fri, 30 Jan 2004 10:59:38 +0000
Received: from ringbreak.dnd.utwente.nl (ringbreak.dnd.utwente.nl [130.89.175.240])
          by netlx014.civ.utwente.nl (8.11.7/HKD) with ESMTP id i0UAx3L30556
          for <linux-mips@linux-mips.org>; Fri, 30 Jan 2004 11:59:03 +0100
Received: from jorik by ringbreak.dnd.utwente.nl with local (Exim 3.35 #1 (Debian))
	id 1AmWMZ-0003Hj-00
	for <linux-mips@linux-mips.org>; Fri, 30 Jan 2004 11:59:03 +0100
Date: Fri, 30 Jan 2004 11:59:03 +0100
From: Jorik Jonker <linux-mips@boeventronie.net>
To: linux-mips@linux-mips.org
Subject: Re: linux 2.4 and Indy
Message-ID: <20040130105903.GA12562@ballina>
Mail-Followup-To: linux-mips@linux-mips.org
References: <20040129102215.GC17760@ballina> <4018E322.9030801@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4018E322.9030801@gentoo.org>
User-Agent: Mutt/1.3.28i
X-UTwente-MailScanner-Information: Scanned by MailScanner. Contact helpdesk@ITBE.utwente.nl for more information.
X-UTwente-MailScanner: Found to be clean
Return-Path: <jorik@dnd.utwente.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4200
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux-mips@boeventronie.net
Precedence: bulk
X-list: linux-mips

On Thu, Jan 29, 2004 at 05:40:34AM -0500, Kumba wrote:
> >The problem
> >is that all the kernels I built do boot, but freeze some moments after
> >starting the init process. The only kernels that do not have this problem 
> >are 2.4.16 and 2.4.17, but they do not have proper VINO support (they lack 
> >the i2c algo-sgi part).
> >Is there some patch flying around to fix this, or do I just have bad luck?
> 
> Check out a cvs tree no later than 12/11/2003, a change in CVS after 
> that date seems to have nuked r4k kernels.  It is believed the change in 
> question is:

Hmm, that's strange, I believe that should do the trick, but when I checkout
a tree (cvs -z3 -d:.. co -r linux_2_4 -D 'December 10 2003' linux), I still
get a 'half-booting' kernel. Shall I try to checkout an even older one, until
something is starting to work, or is something else going wrong?

cheers,
-- 
Jorik Jonker
http://boeventronie.net/
