Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Jul 2007 12:22:50 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:14864 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20022579AbXG3LWs (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 30 Jul 2007 12:22:48 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 7C4DEE1C71
	for <linux-mips@linux-mips.org>; Mon, 30 Jul 2007 13:22:14 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 09aK-lkV2HTm for <linux-mips@linux-mips.org>;
	Mon, 30 Jul 2007 13:22:14 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 35A28E1C63
	for <linux-mips@linux-mips.org>; Mon, 30 Jul 2007 13:22:14 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l6UBMLJP011895
	for <linux-mips@linux-mips.org>; Mon, 30 Jul 2007 13:22:21 +0200
Date:	Mon, 30 Jul 2007 12:22:17 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	linux-mips@linux-mips.org
Subject: Re: [MIPS] Cleanup default bootfile format rule mess.
In-Reply-To: <S20022592AbXG3KTH/20070730101907Z+2272@ftp.linux-mips.org>
Message-ID: <Pine.LNX.4.64N.0707301214280.12082@blysk.ds.pg.gda.pl>
References: <S20022592AbXG3KTH/20070730101907Z+2272@ftp.linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.1/3819/Mon Jul 30 07:36:40 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15938
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, 30 Jul 2007, linux-mips@linux-mips.org wrote:

> Author: Ralf Baechle <ralf@linux-mips.org> Sat Jul 28 13:27:21 2007 +0100
> Commit: abd626549a9413aea7fa0bc963dd1869a28ba2cf
> Gitweb: http://www.linux-mips.org/g/linux/abd62654
> Branch: master
> 
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> 
> ---
> 
>  arch/mips/Makefile |   35 ++++++++---------------------------
>  1 files changed, 8 insertions(+), 27 deletions(-)

 Hmm, shouldn't the .srec, .bin, etc. files be only built for the "boot" 
goal, like it is done for other platforms that have to use something other 
than "vmlinux" for bootstrap?  Otherwise the default goal produces 
possibly unnecessary clutter -- an .srec file is hardly ever less than 
10MB, so if you make a few of them, you end up consuming disk space rather 
quickly.

 Just a point -- I do not care personally as I have already been hit by 
problems like this in the past and to avoid surprises I now use specific 
goals, like `make vmlinux' or `make vmlinux.32'.

  Maciej
