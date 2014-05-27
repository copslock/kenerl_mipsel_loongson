Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 May 2014 11:05:34 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:45463 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6818452AbaE0JFb1iQIY (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 27 May 2014 11:05:31 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id s4R95Ta6018198;
        Tue, 27 May 2014 11:05:29 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id s4R95Rpe018197;
        Tue, 27 May 2014 11:05:27 +0200
Date:   Tue, 27 May 2014 11:05:27 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Andreas Herrmann <herrmann.der.user@googlemail.com>
Cc:     Paul Bolle <pebolle@tiscali.nl>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: cavium-octeon: remove checks for CONFIG_CAVIUM_GDB
Message-ID: <20140527090527.GG20055@linux-mips.org>
References: <1400602574.4912.43.camel@x220>
 <20140522132645.GC10287@linux-mips.org>
 <20140523213701.GD23153@alberich>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140523213701.GD23153@alberich>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40279
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Fri, May 23, 2014 at 11:37:01PM +0200, Andreas Herrmann wrote:

> > void __init smp_cpus_done(unsigned int max_cpus)
> > {
> > - 	mp_ops->cpus_done();
> > + 	if (cpus_done)
> > + 		mp_ops->cpus_done();
> > }
> > 
> > which would make a NULL cpus_done function pointer safe and allow empty definitions
> > to be removed.
> 
> I'd prefer this solution over complete removal of the hook.

In the end that's what I just did.

Which leaves smp_cpus_done() empty.  I think I'm going to put in a
function to print a summary of CPUs booted but that's for another
patch.

  Ralf
