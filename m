Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Nov 2009 00:09:38 +0100 (CET)
Received: from www.tglx.de ([62.245.132.106]:48594 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1493300AbZKQXJb (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 18 Nov 2009 00:09:31 +0100
Received: from localhost (www.tglx.de [127.0.0.1])
	by www.tglx.de (8.13.8/8.13.8/TGLX-2007100201) with ESMTP id nAHN9Jwa022886
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 18 Nov 2009 00:09:20 +0100
Date:	Wed, 18 Nov 2009 00:09:19 +0100 (CET)
From:	Thomas Gleixner <tglx@linutronix.de>
To:	Ralf Baechle <ralf@linux-mips.org>
cc:	LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
	linux-mips@linux-mips.org
Subject: Re: [patch 08/13] mips: Fixup last users of irq_chip->typename
In-Reply-To: <20091117230544.GA1866@linux-mips.org>
Message-ID: <alpine.LFD.2.00.0911180007340.24119@localhost.localdomain>
References: <20091117224852.846805939@linutronix.de> <20091117224916.642102675@linutronix.de> <20091117230544.GA1866@linux-mips.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: clamav-milter 0.95.1 at www.tglx.de
X-Virus-Status:	Clean
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24957
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
Precedence: bulk
X-list: linux-mips

On Wed, 18 Nov 2009, Ralf Baechle wrote:

> On Tue, Nov 17, 2009 at 10:51:03PM -0000, Thomas Gleixner wrote:
> 
> > The typename member of struct irq_chip was kept for migration purposes
> > and is obsolete since more than 2 years. Fix up the leftovers.
> > 
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ralf Baechle <ralf@linux-mips.org>
> > Cc: linux-mips@linux-mips.org
> 
> Looks good.  I assume you want to merge the whole series via tip, so
> 
> Acked-by: Ralf Baechle <ralf@linux-mips.org>

You can pick it up as well. The patches are independent, just the last
one which removes typename from irq_chip depends on the arch patches
being merged. Either way works fine.

Thanks,

	tglx
