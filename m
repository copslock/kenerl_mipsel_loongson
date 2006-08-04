Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Aug 2006 09:27:54 +0100 (BST)
Received: from deliver-2.mx.triera.net ([213.161.0.32]:42199 "EHLO
	deliver-2.mx.triera.net") by ftp.linux-mips.org with ESMTP
	id S8133443AbWHDI1n (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 4 Aug 2006 09:27:43 +0100
Received: from localhost (in-1.mx.triera.net [213.161.0.25])
	by deliver-2.mx.triera.net (Postfix) with ESMTP id A8AE7102;
	Fri,  4 Aug 2006 10:27:32 +0200 (CEST)
Received: from smtp.triera.net (smtp.triera.net [213.161.0.30])
	by in-1.mx.triera.net (Postfix) with SMTP id 148EF1BC08D;
	Fri,  4 Aug 2006 10:27:35 +0200 (CEST)
Received: from localhost (unknown [213.161.20.162])
	by smtp.triera.net (Postfix) with ESMTP id C7AF81A18AE;
	Fri,  4 Aug 2006 10:27:35 +0200 (CEST)
Date:	Fri, 4 Aug 2006 10:27:36 +0200
From:	Domen Puncer <domen.puncer@ultra.si>
To:	Daniel Mack <daniel@caiaq.de>
Cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] fix irq_chip struct for Pb1200/Db1200 platform
Message-ID: <20060804082736.GX31105@domen.ultra.si>
References: <2F5D781B-2119-4942-82C1-70B5037F5622@caiaq.de> <20060714161128.GB15427@linux-mips.org> <20060715005747.GA21358@ipxXXXXX> <20060715043941.GA3587@linux-mips.org> <20060715091614.GB21737@ipxXXXXX> <20060727023204.GA28793@ipxXXXXX>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060727023204.GA28793@ipxXXXXX>
User-Agent: Mutt/1.5.11+cvs20060126
X-Virus-Scanned: Triera AV Service
Return-Path: <domen.puncer@ultra.si>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12180
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: domen.puncer@ultra.si
Precedence: bulk
X-list: linux-mips

On 27/07/06 04:32 +0200, Daniel Mack wrote:
> On Sat, Jul 15, 2006 at 11:16:14AM +0200, Daniel Mack wrote:
> > http://caiaq.org/linux-mips/patches/irq_chip_pb1200.patch

Ralf, can you please apply this.
We don't want 2.6.18 greeting pb1200/db1200 users with an oops, do we?

> 
> What about this one? Did it apply now?

It applies and works here. Thanks!


	Domen

> 
> Daniel
> 
