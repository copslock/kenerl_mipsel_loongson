Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 May 2014 23:47:52 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:45405 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6855074AbaEWVruc2gYp (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 23 May 2014 23:47:50 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id s4NLlg02019687;
        Fri, 23 May 2014 23:47:42 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id s4NLlaPl019686;
        Fri, 23 May 2014 23:47:36 +0200
Date:   Fri, 23 May 2014 23:47:36 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
Cc:     James Hogan <james.hogan@imgtec.com>, linux-mips@linux-mips.org,
        David Daney <ddaney.cavm@gmail.com>, kvm@vger.kernel.org,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 10/15] MIPS: Add code for new system 'paravirt'.
Message-ID: <20140523214736.GI334@linux-mips.org>
References: <1400597236-11352-1-git-send-email-andreas.herrmann@caviumnetworks.com>
 <1400597236-11352-11-git-send-email-andreas.herrmann@caviumnetworks.com>
 <537CAC74.4030800@imgtec.com>
 <20140523202855.GL11800@alberich>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140523202855.GL11800@alberich>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40262
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

On Fri, May 23, 2014 at 10:28:55PM +0200, Andreas Herrmann wrote:

> > > +	wmb();
> > 
> > Wouldn't smp_wmb() be more accurate?
> 
> ... use smp_wmb there ...

A few years ago I reviewed the use of mb()/rmb()/wmb() as opposed to
smp_mb()/smp_rmb()/smp_wmb() throughout the kernel.  Every single use
was a bug should either have been replaced by the smp_* variant because
it was not necessary on uniprocessors, was pure cargocult programming
or was used for a purpose such I/O where other solutions were required.

  Ralf
