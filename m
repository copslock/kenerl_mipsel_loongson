Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 May 2006 13:18:50 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:48906 "HELO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with SMTP
	id S8133506AbWEaLSn (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 31 May 2006 13:18:43 +0200
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 82C9FF63F3;
	Wed, 31 May 2006 13:18:37 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 16817-01; Wed, 31 May 2006 13:18:37 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 0B662F5C03;
	Wed, 31 May 2006 13:18:37 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.6/8.13.1) with ESMTP id k4VBIhkA029398;
	Wed, 31 May 2006 13:18:44 +0200
Date:	Wed, 31 May 2006 12:18:40 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	art <art@sigrand.ru>
cc:	"Zhan, Rongkai" <rongkai.zhan@windriver.com>,
	linux-mips@linux-mips.org
Subject: Re[2]: Problem with TLB mcheck!
In-Reply-To: <5488.060531@sigrand.ru>
Message-ID: <Pine.LNX.4.64N.0605311213480.29356@blysk.ds.pg.gda.pl>
References: <6A3254532ACD7A42805B4E1BFD18080EDC158B@ism-mail01.corp.ad.wrs.com>
 <5488.060531@sigrand.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.88.2/1500/Tue May 30 22:47:36 2006 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11617
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 31 May 2006, art wrote:

> ZR> Please see: http://www.linux-mips.org/archives/linux-mips/2005-04/msg00026.html
> 
>  
> 
> ZR> Best Regards,
> 
> ZR> Mark. Zhan
> 
> Thanks for advice! But problem steel present :(. BUT! there is
> progress! After pathing I execute cut /bin/busybox about 10-12 times
> before system crash, and before patching it occurs after 1-2 times!

 The patch is supposed to be irrelevant for the revision of the 4Kc you 
have.  Anyway, as I wrote, please retry with the head of the tree (which 
is 2.6.17-rc5) and then I can think about it.  Whether it's overall stable 
or not is irrelevant -- once the issue is resolved you can either wait for 
a release that is considered stable enough or retrofit the fix into a 
release of your choice.

  Maciej
