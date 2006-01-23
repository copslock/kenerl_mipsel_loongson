Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Jan 2006 11:58:41 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:7684 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S3458578AbWAWL6X (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 23 Jan 2006 11:58:23 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 7BAF3F5A5B;
	Mon, 23 Jan 2006 13:02:28 +0100 (CET)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 03013-10; Mon, 23 Jan 2006 13:02:28 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 36E3AF5963;
	Mon, 23 Jan 2006 13:02:28 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id k0NC2KBg003281;
	Mon, 23 Jan 2006 13:02:22 +0100
Date:	Mon, 23 Jan 2006 12:02:28 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Martin Michlmayr <tbm@cyrius.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: DECstation compile fails: opcode not supported (eret)
In-Reply-To: <20060123111311.GA21394@deprecation.cyrius.com>
Message-ID: <Pine.LNX.4.64N.0601231159510.27141@blysk.ds.pg.gda.pl>
References: <20060121195956.GA15498@deprecation.cyrius.com> <43D2F4D9.6010406@gentoo.org>
 <20060122131153.GB5543@deprecation.cyrius.com>
 <Pine.LNX.4.64N.0601231035300.27141@blysk.ds.pg.gda.pl>
 <20060123111311.GA21394@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.87.1/1247/Sat Jan 21 11:24:51 2006 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10049
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, 23 Jan 2006, Martin Michlmayr wrote:

> >  This ".set mips3" should protect that "eret" alone then.
> 
> Can you please commit a fix to git.

 I have no way of doing this, but I may prepare a patch and try to push it 
through Ralf.

  Maciej
