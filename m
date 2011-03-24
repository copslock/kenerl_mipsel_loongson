Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Mar 2011 16:12:40 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:52962 "EHLO
        duck.linux-mips.net" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491921Ab1CXPMh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 24 Mar 2011 16:12:37 +0100
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.3) with ESMTP id p2OFCIIl012108;
        Thu, 24 Mar 2011 16:12:18 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p2OFCIvF012107;
        Thu, 24 Mar 2011 16:12:18 +0100
Date:   Thu, 24 Mar 2011 16:12:18 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Sergei Shtylyov <sshtylyov@mvista.com>, linux-mips@linux-mips.org
Subject: Re: [patch 37/38] mips: vr41xx: Cleanup the direct access to
 irq_desc[]
Message-ID: <20110324151217.GL30990@linux-mips.org>
References: <20110323210437.398062704@linutronix.de>
 <20110323210538.070462971@linutronix.de>
 <4D8B3CBC.3080307@mvista.com>
 <alpine.LFD.2.00.1103241400250.31464@localhost6.localdomain6>
 <4D8B4D8E.1010000@mvista.com>
 <alpine.LFD.2.00.1103241520510.31464@localhost6.localdomain6>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1103241520510.31464@localhost6.localdomain6>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29525
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Mar 24, 2011 at 03:21:12PM +0100, Thomas Gleixner wrote:

> > > Not as long as the compat functions are active in the core.
> > 
> >    I've looked at compat_*() before replying: it seems that they work vice
> > versa, i.e. the new functions are emulated by calling the old, and you're
> > moving away from old to new in the previous patch. Maybe I miss something...
> 
> Oops. Yes. So the patches should be folded

Okay, folded this patch into 36/38 and queued the result for 3.6.39.

Thanks,

  Ralf
