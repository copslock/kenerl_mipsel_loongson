Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Aug 2009 13:07:27 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:41773 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1492241AbZH0LHU (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 27 Aug 2009 13:07:20 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n7RB8J9D030797;
	Thu, 27 Aug 2009 12:08:19 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n7RB8Jxw030795;
	Thu, 27 Aug 2009 12:08:19 +0100
Date:	Thu, 27 Aug 2009 12:08:19 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Manuel Lauss <manuel.lauss@googlemail.com>
Cc:	Linux-MIPS <linux-mips@linux-mips.org>,
	Manuel Lauss <manuel.lauss@gmail.com>
Subject: Re: [PATCH] Alchemy: get rid of allow_au1k_wait
Message-ID: <20090827110819.GA29984@linux-mips.org>
References: <1250957367-14389-1-git-send-email-manuel.lauss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1250957367-14389-1-git-send-email-manuel.lauss@gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23932
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Aug 22, 2009 at 06:09:27PM +0200, Manuel Lauss wrote:

> Eliminate the 'allow_au1k_wait' variable.  MIPS kernel installs the
> Alchemy-specific wait code before timer initialization;  if the C0
> timer must be used for timekeeping the wait function is set to NULL
> which means no wait implementation is available.
> 
> As a sideeffect, the 'wait instruction available' output in
> /proc/cpuinfo now correctly indicates whether 'wait' is usable.
> 
> Run-tested on DB1200.

Queued, thanks Manuel!

  Ralf
