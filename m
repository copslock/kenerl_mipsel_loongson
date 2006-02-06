Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Feb 2006 10:32:40 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:48645 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S3458326AbWBFKcc (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 6 Feb 2006 10:32:32 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 4FCBFF59E9;
	Mon,  6 Feb 2006 11:38:03 +0100 (CET)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 06087-04; Mon,  6 Feb 2006 11:38:03 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 043B5E1C7A;
	Mon,  6 Feb 2006 11:38:02 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id k16Abtl9012177;
	Mon, 6 Feb 2006 11:37:55 +0100
Date:	Mon, 6 Feb 2006 10:38:02 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Martin Michlmayr <tbm@cyrius.com>
Cc:	"Peter 'p2' De Schrijver" <p2@mind.be>, linux-mips@linux-mips.org
Subject: Re: DECstation R3000 boot error
In-Reply-To: <20060203150232.GA25701@deprecation.cyrius.com>
Message-ID: <Pine.LNX.4.64N.0602061021110.32080@blysk.ds.pg.gda.pl>
References: <20060123225040.GA23576@deprecation.cyrius.com>
 <Pine.LNX.4.64N.0601241059140.11021@blysk.ds.pg.gda.pl>
 <20060124122700.GA8527@deprecation.cyrius.com>
 <Pine.LNX.4.64N.0601241227290.11021@blysk.ds.pg.gda.pl> <20060124232117.GA4165@codecarver>
 <Pine.LNX.4.64N.0601251103020.7675@blysk.ds.pg.gda.pl>
 <20060203150232.GA25701@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.87.1/1277/Sun Feb  5 14:22:21 2006 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10342
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, 3 Feb 2006, Martin Michlmayr wrote:

> > and it obviously cannot work on a MIPS I processor.  That's probably from 
> > broken assembly code somewhere -- I should have my sources updated within 
> > a few days and I'll see if I can reproduce the problem.
> 
> Did you have a chance to look at this?

 Not yet, sorry.  I have updated my tree and most of my local patches, but 
I have a few to go yet.  My time is limited these days, but I'll try hard 
to get at the problems you reported by the coming weekend at the very 
latest.

  Maciej
