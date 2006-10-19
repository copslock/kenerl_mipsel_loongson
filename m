Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Oct 2006 17:54:30 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:36879 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20037871AbWJSQy2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 19 Oct 2006 17:54:28 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 1D83EE1C69;
	Thu, 19 Oct 2006 18:54:10 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id o2dYhayJUMun; Thu, 19 Oct 2006 18:54:09 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id A43EEE1C65;
	Thu, 19 Oct 2006 18:54:09 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.1) with ESMTP id k9JGsMfZ013271;
	Thu, 19 Oct 2006 18:54:23 +0200
Date:	Thu, 19 Oct 2006 17:54:19 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
cc:	Ralf Baechle <ralf@linux-mips.org>, vagabon.xyz@gmail.com,
	linux-mips@linux-mips.org
Subject: Re: [PATCH][MIPS] merge a few printk in check_wait()
In-Reply-To: <20061019170709.54a8b9a6.yoichi_yuasa@tripeaks.co.jp>
Message-ID: <Pine.LNX.4.64N.0610191753180.5982@blysk.ds.pg.gda.pl>
References: <20061019002718.1ca0ec56.yoichi_yuasa@tripeaks.co.jp>
 <45364F82.8030308@innova-card.com> <20061018161551.GA15530@linux-mips.org>
 <20061019170709.54a8b9a6.yoichi_yuasa@tripeaks.co.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.88.5/2050/Thu Oct 19 09:58:33 2006 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13038
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 19 Oct 2006, Yoichi Yuasa wrote:

> > Or more radical, just getting rid of the printk entirely?  It doesn't
> > provide very useful information.
[...]
> I agree with you.
> I updated my patch.

 You might consider removing "Checking for..." in that case as well.

  Maciej
