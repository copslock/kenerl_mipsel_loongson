Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 May 2006 17:35:35 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:39392 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133647AbWEJPf2 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 10 May 2006 17:35:28 +0200
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.6/8.13.4) with ESMTP id k4AFZRDv016266;
	Wed, 10 May 2006 16:35:27 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.6/8.13.6/Submit) id k4AFZQes016265;
	Wed, 10 May 2006 16:35:26 +0100
Date:	Wed, 10 May 2006 16:35:26 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Mark.Zhan" <rongkai.zhan@windriver.com>
Cc:	Alex Gonzalez <langabe@gmail.com>, linux-mips@linux-mips.org
Subject: Re: Boot time memory allocation
Message-ID: <20060510153526.GC11961@linux-mips.org>
References: <c58a7a270605090735t8e4f21ax6ca87f97b9143e3b@mail.gmail.com> <20060509163411.GA8528@linux-mips.org> <44614E0F.2000207@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44614E0F.2000207@windriver.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11392
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, May 10, 2006 at 10:21:03AM +0800, Mark.Zhan wrote:

> >At kernel initialization time just don't tell the kernel about the
> >existence of your memory region.  For many systems that just means you
> >shrink the memory region passed to the add_memory_region() call to
> >something that suits your platform.

> Maybe it is a more flexible way to specify the memory regions via 
> command line. You know, this will produce User-defined memory regions to 
> kernel.

Maybe for a specific application or platform.  For a sourcebase like
linux-mips.org's with a very large number of users on sometimes very
complex platforms I'd never ever think of exposing such details.

  Ralf
