Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Aug 2010 06:43:59 +0200 (CEST)
Received: from e4.ny.us.ibm.com ([32.97.182.144]:59918 "EHLO e4.ny.us.ibm.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1493202Ab0HDEny (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 4 Aug 2010 06:43:54 +0200
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
        by e4.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o744TOhJ025492;
        Wed, 4 Aug 2010 00:29:24 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
        by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id o744hkNX2175110;
        Wed, 4 Aug 2010 00:43:46 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
        by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id o744hhXP027833;
        Wed, 4 Aug 2010 01:43:46 -0300
Received: from thinktux.in.ibm.com ([9.124.46.166])
        by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id o744hgNi027764;
        Wed, 4 Aug 2010 01:43:43 -0300
Received: by thinktux.in.ibm.com (Postfix, from userid 500)
        id F38C9C33AC; Wed,  4 Aug 2010 10:13:35 +0530 (IST)
Date:   Wed, 4 Aug 2010 10:13:35 +0530
From:   Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        anil.s.keshavamurthy@intel.com, davem@davemloft.net,
        masami.hiramatsu.pt@hitachi.com, linux-kernel@vger.kernel.org,
        hschauhan@nulltrace.org
Subject: Re: [PATCH 0/5] KProbes support for MIPS
Message-ID: <20100804044335.GA23536@in.ibm.com>
Reply-To: ananth@in.ibm.com
References: <1280859742-26364-1-git-send-email-ddaney@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1280859742-26364-1-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Return-Path: <ananth@in.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27561
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ananth@in.ibm.com
Precedence: bulk
X-list: linux-mips

On Tue, Aug 03, 2010 at 11:22:17AM -0700, David Daney wrote:
> This patch set adds KProbs, JProbs and KRetProbes support for the MIPS
> archetecture.
> 
> It was tested on a 64-bit big-endian kernel (Octeon), but should work
> equally well on 32-bit and little-endian as well.
> 
> As you can see from the patches it is partially based on previous work
> by Sony and Himanshu Chauhan.
> 
> David Daney (5):
>   MIPS: Define regs_return_value()
>   MIPS: Add instrunction format for BREAK and SYSCALL
>   MIPS: Add KProbe support.
>   samples: kprobe_example: Make it print something on MIPS.
>   documentation: Mention that KProbes is supported on MIPS

David,

Thanks for the port!

I do not know enough about MIPS internals to be able to review the
arcane architecture specific details in the implementation.

It would help if you add yourself to the MAINTAINERS list for the MIPS
port. If people hit an issue, they'll know to cc you.

Ananth
