Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Jan 2004 21:02:08 +0000 (GMT)
Received: from netlx014.civ.utwente.nl ([IPv6:::ffff:130.89.1.88]:48992 "EHLO
	netlx014.civ.utwente.nl") by linux-mips.org with ESMTP
	id <S8225370AbUA3VCH>; Fri, 30 Jan 2004 21:02:07 +0000
Received: from ringbreak.dnd.utwente.nl (ringbreak.dnd.utwente.nl [130.89.175.240])
          by netlx014.civ.utwente.nl (8.11.7/HKD) with ESMTP id i0UL1RL17856
          for <linux-mips@linux-mips.org>; Fri, 30 Jan 2004 22:01:27 +0100
Received: from jorik by ringbreak.dnd.utwente.nl with local (Exim 3.35 #1 (Debian))
	id 1AmflX-0006Xm-00
	for <linux-mips@linux-mips.org>; Fri, 30 Jan 2004 22:01:27 +0100
Date: Fri, 30 Jan 2004 22:01:27 +0100
From: Jorik Jonker <linux-mips@boeventronie.net>
To: linux-mips@linux-mips.org
Subject: Re: linux 2.4 and Indy
Message-ID: <20040130210127.GB19872@ballina>
Mail-Followup-To: linux-mips@linux-mips.org
References: <20040129102215.GC17760@ballina> <4018E322.9030801@gentoo.org> <20040130105903.GA12562@ballina> <20040130111255.GB7501@icm.edu.pl> <20040130204911.GA19872@ballina>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040130204911.GA19872@ballina>
User-Agent: Mutt/1.3.28i
X-UTwente-MailScanner-Information: Scanned by MailScanner. Contact helpdesk@ITBE.utwente.nl for more information.
X-UTwente-MailScanner: Found to be clean
Return-Path: <jorik@dnd.utwente.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4208
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux-mips@boeventronie.net
Precedence: bulk
X-list: linux-mips

On Fri, Jan 30, 2004 at 09:49:11PM +0100, Jorik Jonker wrote:
> # cvs -z3 -d :pserver:cvs@ftp.linux-mips.org:/home/cvs co \
> 	-D '5 Dec 2003' \
> 	-r linux_2_4 linux
> 
> I am not extremely confident about my CVS skills, but the fine manual tought
> me this. I even checked out kernels from June 4th 2003, without success. I am 
> now trying February 4th 2003.

Without success again.. I am beginning to suspect that I am doing something
completely wrong. I must say I am building using a crosscompiler:
mips-linux-gcc (GCC) 3.2.3 20030221 (Debian prerelease), but.. I successfully
produced a working 2.4.16 and 2.4.17. I am now going to do a native '5
december' build, hoping that will solve the problems.

-- 
Jorik Jonker
http://boeventronie.net/
