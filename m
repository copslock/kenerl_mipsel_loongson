Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Nov 2005 14:00:55 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:6662 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S3466297AbVKVOAg (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 22 Nov 2005 14:00:36 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 70D06E1CB0;
	Tue, 22 Nov 2005 15:03:12 +0100 (CET)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 13067-03; Tue, 22 Nov 2005 15:03:12 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 2A9B8E1C61;
	Tue, 22 Nov 2005 15:03:12 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id jAME3AG6020761;
	Tue, 22 Nov 2005 15:03:12 +0100
Date:	Tue, 22 Nov 2005 14:03:12 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Nigel Stephens <nigel@mips.com>,
	"Kevin D. Kissell" <kevink@mips.com>,
	"Knittel, Brian" <Brian.Knittel@powertv.com>,
	linux-mips@linux-mips.org
Subject: Re: Saving arguments on the stack
In-Reply-To: <20051122122703.GD2706@linux-mips.org>
Message-ID: <Pine.LNX.4.55.0511221359070.4241@blysk.ds.pg.gda.pl>
References: <762C0A863A7674478671627FEAF5848105AF92D2@hqmail01.powertv.com>
 <4382DC76.60506@mips.com> <4382FF29.2020605@mips.com> <20051122112417.GB2706@linux-mips.org>
 <Pine.LNX.4.64N.0511221128150.14593@blysk.ds.pg.gda.pl>
 <20051122122703.GD2706@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.87.1/1183/Tue Nov 22 10:19:57 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9535
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, 22 Nov 2005, Ralf Baechle wrote:

> There were functions in the network stack that intensionally were
> declared extern inline to make sure the compiler won't be able to outline
> that function unnoticed.  I just grepped for it and can't find it
> anymore, must be a relativly recent improvment.
> 
> We also rely on the compiler eleminating calls to certain functions
> entirely, for example to __xchg_called_with_bad_pointer().

 Well, that's exactly what "__attribute__((always_inline))" does -- either
inline or fail; the latter AFAIK only happening if the function's body is
unavailable to the current compilation unit.  That happens regardless of 
any optimization settings.

  Maciej
