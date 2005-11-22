Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Nov 2005 11:37:08 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:5902 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S3466285AbVKVLgv (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 22 Nov 2005 11:36:51 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 44C65F5968;
	Tue, 22 Nov 2005 12:39:27 +0100 (CET)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 23744-06; Tue, 22 Nov 2005 12:39:27 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 04473E1C84;
	Tue, 22 Nov 2005 12:39:27 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id jAMBdKjL008145;
	Tue, 22 Nov 2005 12:39:20 +0100
Date:	Tue, 22 Nov 2005 11:39:28 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Nigel Stephens <nigel@mips.com>,
	"Kevin D. Kissell" <kevink@mips.com>,
	"Knittel, Brian" <Brian.Knittel@powertv.com>,
	linux-mips@linux-mips.org
Subject: Re: Saving arguments on the stack
In-Reply-To: <20051122112417.GB2706@linux-mips.org>
Message-ID: <Pine.LNX.4.64N.0511221128150.14593@blysk.ds.pg.gda.pl>
References: <762C0A863A7674478671627FEAF5848105AF92D2@hqmail01.powertv.com>
 <4382DC76.60506@mips.com> <4382FF29.2020605@mips.com> <20051122112417.GB2706@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.87.1/1183/Tue Nov 22 10:19:57 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9532
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, 22 Nov 2005, Ralf Baechle wrote:

> > 'Fraid not: the -g option only adds debug info to the object file, it 
> > shouldn't alter the generated code. Using -O0 will certainly store 
> > everything on the stack, but it also won't be "with otherwise optimized 
> > code".
> 
> And the kernel won't build without optimization - but that's FAQ since
> 10 years.

 Well, with "__attribute__((always_inline))" available and actually used 
already, perhaps this requirement could be relaxed nowadays...

  Maciej
