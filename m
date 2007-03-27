Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Mar 2007 16:43:16 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:23055 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20021889AbXC0PnM (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 27 Mar 2007 16:43:12 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 7B628E1E91;
	Tue, 27 Mar 2007 17:38:08 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ug7ZLzqatq5U; Tue, 27 Mar 2007 17:38:08 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 56F71E1E5D;
	Tue, 27 Mar 2007 17:38:07 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l2RFcI9B031103;
	Tue, 27 Mar 2007 17:38:18 +0200
Date:	Tue, 27 Mar 2007 16:38:13 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
cc:	Ralf Baechle <ralf@linux-mips.org>,
	Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: Early printk recent changes.
In-Reply-To: <cda58cb80703270803g7c1119e4w22272e9e18c0d251@mail.gmail.com>
Message-ID: <Pine.LNX.4.64N.0703271620080.5547@blysk.ds.pg.gda.pl>
References: <cda58cb80703270716s6c95c66cgd03482a4852a69eb@mail.gmail.com> 
 <Pine.LNX.4.64N.0703271526000.5547@blysk.ds.pg.gda.pl>
 <cda58cb80703270803g7c1119e4w22272e9e18c0d251@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.90.1/2939/Tue Mar 27 15:30:21 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14733
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, 27 Mar 2007, Franck Bui-Huu wrote:

> >  Don't fix what isn't broken...
> >
> 
> Well with such advice, Linux would have been stuck to version 0.4 ;)

 Fortunately, there is a feature called "common sense" and it has 
prevented a halt from happening.  Also I wouldn't be brave enough to claim 
any particular version of Linux, nor any other piece of software, is 
perfect, though, admittedly, the level of imperfection varies highly 
across different versions and pieces.

 In this case I gather this was a bulk change and some platforms have 
benefited and the DECstation has lost.  You seem to have problems as well.  
These issues can be dealt with somehow and they do not mean the change was 
bad as a whole.

  Maciej
