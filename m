Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 May 2006 14:42:38 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:1546 "HELO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with SMTP
	id S8133401AbWEKMm3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 11 May 2006 14:42:29 +0200
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 05AE0F5F00;
	Thu, 11 May 2006 14:42:25 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 27536-02; Thu, 11 May 2006 14:42:24 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 9A760F5EF0;
	Thu, 11 May 2006 14:42:24 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.6/8.13.1) with ESMTP id k4BCgV5L031413;
	Thu, 11 May 2006 14:42:31 +0200
Date:	Thu, 11 May 2006 13:42:28 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Martin Michlmayr <tbm@cyrius.com>
cc:	karsten@excalibur.cologne.de, linux-mips@linux-mips.org
Subject: Re: pmag* drivers don't build on 2.6
In-Reply-To: <20060511123016.GH7827@deprecation.cyrius.com>
Message-ID: <Pine.LNX.4.64N.0605111338290.20004@blysk.ds.pg.gda.pl>
References: <20060510204601.GA23786@deprecation.cyrius.com>
 <Pine.LNX.4.64N.0605111305490.20004@blysk.ds.pg.gda.pl>
 <20060511123016.GH7827@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.88.2/1456/Thu May 11 07:57:31 2006 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11398
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 11 May 2006, Martin Michlmayr wrote:

> Ah, yeah, sorry.  I saw a build failure in pmag-aa-fb and thought all
> pmag* drivers were out of date so I didn't try to compile the other
> drivers.  I'm glad to hear that you have ported the other two!

 Please note we are also more or less a weekend away only from pixel clock 
and resolution control in pmagb-b-fb.  Not that I can point at any 
particular weekend, though. ;-)

  Maciej
