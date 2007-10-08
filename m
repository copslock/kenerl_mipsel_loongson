Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Oct 2007 15:42:26 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:21666 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022194AbXJHOmY (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 8 Oct 2007 15:42:24 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l98EfmY5026824;
	Mon, 8 Oct 2007 15:41:48 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l98Ef6ro026805;
	Mon, 8 Oct 2007 15:41:06 +0100
Date:	Mon, 8 Oct 2007 15:41:06 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc:	Thiemo Seufer <ths@networkno.de>,
	"Maciej W. Rozycki" <macro@linux-mips.org>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] mm/pg-r4k.c: Dump the generated code
Message-ID: <20071008144106.GA11142@linux-mips.org>
References: <20071002154918.GA11312@linux-mips.org> <47038874.9050704@gmail.com> <20071003131158.GL16772@networkno.de> <4703F155.4000301@gmail.com> <20071003201800.GP16772@networkno.de> <47049734.6050802@gmail.com> <20071004121557.GA28928@linux-mips.org> <4705004C.5000705@gmail.com> <20071005115151.GA16145@linux-mips.org> <470A3AA7.7030700@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <470A3AA7.7030700@gmail.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16885
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Oct 08, 2007 at 04:11:51PM +0200, Franck Bui-Huu wrote:

> Ralf Baechle wrote:
> > 6828 bytes isn't totally amazing but since the optimization is reasonable
> > clean I'm going to queue this one also.
> > 
> 
> Yes and maybe it worths to queue this on top of your patch ?

Well, if they're lucky enough they make it to the BUG_ON().  But for many
of the missconfiguration scenarios the sympthoms would be more subtle.

Queued for 2.6.24.  Thanks,

  Ralf
