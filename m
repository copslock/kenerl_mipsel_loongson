Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Oct 2007 13:31:38 +0100 (BST)
Received: from relay01.mx.bawue.net ([193.7.176.67]:42396 "EHLO
	relay01.mx.bawue.net") by ftp.linux-mips.org with ESMTP
	id S20027432AbXJQMbZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 17 Oct 2007 13:31:25 +0100
Received: from lagash (intrt.mips-uk.com [194.74.144.130])
	by relay01.mx.bawue.net (Postfix) with ESMTP id BD7C048C0C;
	Wed, 17 Oct 2007 14:30:06 +0200 (CEST)
Received: from ths by lagash with local (Exim 4.67)
	(envelope-from <ths@networkno.de>)
	id 1Ii82w-0008SC-WD; Wed, 17 Oct 2007 13:30:47 +0100
Date:	Wed, 17 Oct 2007 13:30:46 +0100
From:	Thiemo Seufer <ths@networkno.de>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc:	Nigel Stephens <nigel@mips.com>,
	"Maciej W. Rozycki" <macro@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] mm/pg-r4k.c: Dump the generated code
Message-ID: <20071017123046.GY3379@networkno.de>
References: <Pine.LNX.4.64N.0710081611460.8873@blysk.ds.pg.gda.pl> <470BE1F4.3070800@gmail.com> <Pine.LNX.4.64N.0710101231290.9821@blysk.ds.pg.gda.pl> <47126EDC.1060305@gmail.com> <20071014195324.GT3379@networkno.de> <4713C11F.3010903@gmail.com> <4713C958.8080805@mips.com> <47147551.1010004@gmail.com> <4714B58E.8020005@mips.com> <4715C039.7090603@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4715C039.7090603@gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-11)
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17086
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Franck Bui-Huu wrote:
> Nigel Stephens wrote:
> > 
> > Could you run that gcc command manually, adding the options "-v
> > --save-temps", and post the resulting output messages, and the user.s file.
> > 
> 
> Ok, I did it except I used init/do_mounts.c file since it has at least
> one nop load delay slot (cf label $L50 in do_mount.s)

I only see a nop after the final LW, this is alignment for the next label.


Thiemo
