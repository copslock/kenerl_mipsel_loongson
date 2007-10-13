Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 13 Oct 2007 11:53:46 +0100 (BST)
Received: from smtp.nildram.co.uk ([195.112.4.54]:37646 "EHLO
	smtp.nildram.co.uk") by ftp.linux-mips.org with ESMTP
	id S20026479AbXJMKxg (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 13 Oct 2007 11:53:36 +0100
Received: from firetop.home (85-211-25-104.dyn.gotadsl.co.uk [85.211.25.104])
	by smtp.nildram.co.uk (Postfix) with ESMTP
	id 77DBD2BD858; Sat, 13 Oct 2007 11:53:19 +0100 (BST)
Received: from richard by firetop.home with local (Exim 4.63)
	(envelope-from <rsandifo@nildram.co.uk>)
	id 1IgecT-000374-3r; Sat, 13 Oct 2007 11:53:21 +0100
From:	Richard Sandiford <rsandifo@nildram.co.uk>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Mail-Followup-To: "Maciej W. Rozycki" <macro@linux-mips.org>,
	Nigel Stephens <nigel@mips.com>,
	Franck Bui-Huu <vagabon.xyz@gmail.com>,
	Ralf Baechle <ralf@linux-mips.org>, Thiemo Seufer <ths@networkno.de>,
	linux-mips@linux-mips.org, rsandifo@nildram.co.uk
Cc:	Nigel Stephens <nigel@mips.com>,
	Franck Bui-Huu <vagabon.xyz@gmail.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	Thiemo Seufer <ths@networkno.de>, linux-mips@linux-mips.org
Subject: Re: [SPAM?]  Re: [PATCH] mm/pg-r4k.c: Dump the generated code
References: <Pine.LNX.4.64N.0710021447470.32726@blysk.ds.pg.gda.pl>
	<20071002141125.GC16772@networkno.de>
	<20071002154918.GA11312@linux-mips.org> <47038874.9050704@gmail.com>
	<20071003131158.GL16772@networkno.de> <4703F155.4000301@gmail.com>
	<20071003201800.GP16772@networkno.de> <47049734.6050802@gmail.com>
	<20071004121557.GA28928@linux-mips.org> <4705004C.5000705@gmail.com>
	<Pine.LNX.4.64N.0710041616570.10573@blysk.ds.pg.gda.pl>
	<4705EFE5.7090704@gmail.com>
	<Pine.LNX.4.64N.0710051312490.17849@blysk.ds.pg.gda.pl>
	<470A4349.9090301@gmail.com>
	<Pine.LNX.4.64N.0710081611460.8873@blysk.ds.pg.gda.pl>
	<470BE1F4.3070800@gmail.com>
	<Pine.LNX.4.64N.0710101231290.9821@blysk.ds.pg.gda.pl>
	<470CC0CE.9080303@mips.com>
	<Pine.LNX.4.64N.0710111242530.16370@blysk.ds.pg.gda.pl>
Date:	Sat, 13 Oct 2007 11:53:21 +0100
In-Reply-To: <Pine.LNX.4.64N.0710111242530.16370@blysk.ds.pg.gda.pl> (Maciej
	W. Rozycki's message of "Thu\, 11 Oct 2007 13\:01\:26 +0100 \(BST\)")
Message-ID: <878x679tge.fsf@firetop.home>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <rsandifo@nildram.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17011
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rsandifo@nildram.co.uk
Precedence: bulk
X-list: linux-mips

"Maciej W. Rozycki" <macro@linux-mips.org> writes:
> On Wed, 10 Oct 2007, Nigel Stephens wrote:
>> Actually the -march=4ksd option will allow gcc to use of the SmartMIPS lwxs
>> (indexed load) instruction, which could save a few instructions here and
>> there.
>
>  Good point, but if we decide the lone instruction is worth the hassle, 
> then we should use "-msmartmips" on top of the base ISA selection.  
> Likewise with "lwx" and "-mdsp".

For the record, although that's true of SDE, it isn't (yet) true of
FSF GCC; you need -msmartmips for that.

Richard
