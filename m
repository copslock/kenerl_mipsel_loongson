Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 05 Mar 2011 23:04:53 +0100 (CET)
Received: from pfepa.post.tele.dk ([195.41.46.235]:39825 "EHLO
        pfepa.post.tele.dk" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491814Ab1CEWEu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 5 Mar 2011 23:04:50 +0100
Received: from merkur.ravnborg.org (x1-6-30-46-9a-75-8a-52.k1039.webspeed.dk [93.167.48.205])
        by pfepa.post.tele.dk (Postfix) with ESMTP id 8A398A5001B;
        Sat,  5 Mar 2011 23:04:46 +0100 (CET)
Date:   Sat, 5 Mar 2011 23:04:47 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Grant Likely <grant.likely@secretlab.ca>
Cc:     David Daney <ddaney@caviumnetworks.com>, linux-mips@linux-mips.org,
        ralf@linux-mips.org, devicetree-discuss@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 02/12] of: Allow scripts/dtc/libfdt to be used
        from kernel code
Message-ID: <20110305220447.GB21728@merkur.ravnborg.org>
References: <1299267744-17278-1-git-send-email-ddaney@caviumnetworks.com> <1299267744-17278-3-git-send-email-ddaney@caviumnetworks.com> <20110305005750.GC7579@angua.secretlab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110305005750.GC7579@angua.secretlab.ca>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <sam@ravnborg.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29370
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sam@ravnborg.org
Precedence: bulk
X-list: linux-mips

> 
> libfdt_env.h should be in include/linux
> 
> > +#include "../../scripts/dtc/libfdt/fdt.h"
> > +#include "../../scripts/dtc/libfdt/libfdt.h"
> 
> Hmmm... I wonder if there is a better way to do this.  I don't much
> care for the relative path references.

I assume:
#include "scripts/dtc/libfdt/fdt.h"
#include "scripts/dtc/libfdt/libfdt.h"

works. Because working direcotry is root of kernel tree.
But it is long time ago I played with this so my memory may foul me.

Just noticed this...
> > +
> > +EXTRA_CFLAGS += -include $(src)/libfdt_env.h -I$(src)/../../scripts/dtc/libfdt

"ccflags-y := ..." is recommended these days.

	Sam
