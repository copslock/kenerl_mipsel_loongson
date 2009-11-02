Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Nov 2009 15:44:28 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:52739 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1493924AbZKBOoW (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 2 Nov 2009 15:44:22 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nA2EjgsF027830;
	Mon, 2 Nov 2009 15:45:43 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nA2Ejf9V027828;
	Mon, 2 Nov 2009 15:45:41 +0100
Date:	Mon, 2 Nov 2009 15:45:41 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Manuel Lauss <manuel.lauss@googlemail.com>
Cc:	Kevin Hickey <khickey@netlogicmicro.com>,
	Linux-MIPS <linux-mips@linux-mips.org>,
	Manuel Lauss <manuel.lauss@gmail.com>
Subject: Re: [PATCH] MIPS: Alchemy: physmap-flash for all devboards
Message-ID: <20091102144541.GA27698@linux-mips.org>
References: <1255949617-22943-1-git-send-email-manuel.lauss@gmail.com> <f861ec6f0910310913q4945d666tbdaafed3ce7b2125@mail.gmail.com> <1257167962.8374.0.camel@kh-d280-64> <f861ec6f0911020557v68eebeb8i1a527229922161fe@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f861ec6f0911020557v68eebeb8i1a527229922161fe@mail.gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24616
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Nov 02, 2009 at 02:57:06PM +0100, Manuel Lauss wrote:

> >>
> > I will look this over today or tomorrow.  I'm interested in this patch
> > but haven't had the time to review it.  Now I'll make the time :)
> 
> Please do.  To test swapboot, just dump yamon from the default partition,
> and inject it into the "User FS" partition at the appropriate offset, then boot
> from the swapped flash, erase the yamon partition and try to boot the
> normal nor layout.
> 
> If you deem it acceptable, I'll send the 2 db1200 patches (core+sound)
> to be applied on top of it.

The patch should also have been cc'ed to the linux-mtd list and maintainer.

  Ralf
