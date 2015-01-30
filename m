Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Jan 2015 13:47:42 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:51158 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011134AbbA3Mrjosjyd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 30 Jan 2015 13:47:39 +0100
Date:   Fri, 30 Jan 2015 12:47:39 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     James Hogan <james.hogan@imgtec.com>
cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Hemmo Nieminen <hemmo.nieminen@iki.fi>, stable@vger.kernel.org
Subject: Re: [PATCH v2 2/2] MIPS: fix kernel lockup or crash after CPU
 offline/online
In-Reply-To: <54CB5B59.5050203@imgtec.com>
Message-ID: <alpine.LFD.2.11.1501301242080.28301@eddie.linux-mips.org>
References: <1421355719-17576-1-git-send-email-aaro.koskinen@iki.fi> <1421355719-17576-2-git-send-email-aaro.koskinen@iki.fi> <alpine.LFD.2.11.1501300347170.28301@eddie.linux-mips.org> <54CB5B59.5050203@imgtec.com>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45573
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Fri, 30 Jan 2015, James Hogan wrote:

> >  Hmm, why can a call to `printk' cause a TLB miss, what's so special about 
> > this function?  Does it use kernel mapped addresses for any purpose such 
> > as `vmalloc'?
> 
> It would be the fact netconsole (or whatever other console is in use) is
> built as a kernel module, memory for which is allocated from the vmalloc
> area.

 Ah, I see, thanks for enlightening me.  But in that case wouldn't it be 
possible to postpone console output from `printk' until it is safe to 
access the device?  In a manner similar to how for example we handle calls 
to `printk' made from the hardirq context.  That would make things less 
fragile.

  Maciej
