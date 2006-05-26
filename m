Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 May 2006 14:37:29 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:32015 "HELO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with SMTP
	id S8133645AbWEZMhV (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 26 May 2006 14:37:21 +0200
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 60B9CF5E58;
	Fri, 26 May 2006 14:37:16 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 21838-10; Fri, 26 May 2006 14:37:16 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 14055F5C65;
	Fri, 26 May 2006 14:37:16 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.6/8.13.1) with ESMTP id k4QCbM7L026644;
	Fri, 26 May 2006 14:37:23 +0200
Date:	Fri, 26 May 2006 13:37:19 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	art <art@sigrand.ru>
cc:	linux-mips@linux-mips.org
Subject: Re: Fwd: Re[2]: Problem with TLB mcheck!
In-Reply-To: <13784.060526@sigrand.ru>
Message-ID: <Pine.LNX.4.64N.0605261329020.22687@blysk.ds.pg.gda.pl>
References: <13784.060526@sigrand.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.88.2/1485/Thu May 25 21:29:05 2006 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11565
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, 26 May 2006, art wrote:

> Hello Maciej, thanks for answer! when it is at first time it is wery
> important :)!

 No problem.

> Information about kernel sources (how can I forgot this!!):
>    Version: linux-2.6.12-rc1-mipscvs-20050403 (this is tar-s full
>    name). So I think this kernel is from linux-mips cvs repositary.
>    It was downloaded from http://www.student.tue.nl/Q/t.f.a.wilms/adm5120/

 Please retry with the head of the GIT tree at: "http://linux-mips.org/" 
-- it's more than a year worth of fixes!  The Ralf's patch has already 
been included there.

  Maciej
