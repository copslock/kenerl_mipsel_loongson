Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Jan 2004 20:49:26 +0000 (GMT)
Received: from netlx050.vf.utwente.nl ([IPv6:::ffff:192.87.17.19]:38881 "EHLO
	netlx050.vf.utwente.nl") by linux-mips.org with ESMTP
	id <S8225370AbUA3Ut0>; Fri, 30 Jan 2004 20:49:26 +0000
Received: from ringbreak.dnd.utwente.nl (ringbreak.dnd.utwente.nl [130.89.175.240])
          by netlx050.vf.utwente.nl (8.11.7/HKD) with ESMTP id i0UKnB009028
          for <linux-mips@linux-mips.org>; Fri, 30 Jan 2004 21:49:11 +0100
Received: from jorik by ringbreak.dnd.utwente.nl with local (Exim 3.35 #1 (Debian))
	id 1AmfZf-0006To-00
	for <linux-mips@linux-mips.org>; Fri, 30 Jan 2004 21:49:11 +0100
Date: Fri, 30 Jan 2004 21:49:11 +0100
From: Jorik Jonker <linux-mips@boeventronie.net>
To: linux-mips@linux-mips.org
Subject: Re: linux 2.4 and Indy
Message-ID: <20040130204911.GA19872@ballina>
Mail-Followup-To: linux-mips@linux-mips.org
References: <20040129102215.GC17760@ballina> <4018E322.9030801@gentoo.org> <20040130105903.GA12562@ballina> <20040130111255.GB7501@icm.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040130111255.GB7501@icm.edu.pl>
User-Agent: Mutt/1.3.28i
X-UTwente-MailScanner-Information: Scanned by MailScanner. Contact helpdesk@ITBE.utwente.nl for more information.
X-UTwente-MailScanner: Found to be clean
Return-Path: <jorik@dnd.utwente.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4207
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux-mips@boeventronie.net
Precedence: bulk
X-list: linux-mips

On Fri, Jan 30, 2004 at 12:12:56PM +0100, Dominik 'Rathann' Mierzejewski wrote:
[...]
> > Hmm, that's strange, I believe that should do the trick, but when I checkout
> > a tree (cvs -z3 -d:.. co -r linux_2_4 -D 'December 10 2003' linux), I still
> > get a 'half-booting' kernel. Shall I try to checkout an even older one, until
> > something is starting to work, or is something else going wrong?
> 
> I have a working 5th December 2003 kernel running on R4600 V2.0, but since
> there were no changes between 5th and 11th December, I'd suspect that yours
> should boot fine, too. Did you check if the files you checked out are really
> not later than 11th December?

I am really sure. The exact command used to checkout my tree was:

# cvs -z3 -d :pserver:cvs@ftp.linux-mips.org:/home/cvs co \
	-D '5 Dec 2003' \
	-r linux_2_4 linux

I am not extremely confident about my CVS skills, but the fine manual tought
me this. I even checked out kernels from June 4th 2003, without success. I am 
now trying February 4th 2003.

cheers,
-- 
Jorik Jonker
http://boeventronie.net/
