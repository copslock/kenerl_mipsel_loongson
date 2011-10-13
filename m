Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Oct 2011 20:07:30 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:52799 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491072Ab1JMSH0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 13 Oct 2011 20:07:26 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id p9DI7H39008742;
        Thu, 13 Oct 2011 19:07:17 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p9DI7EtP008733;
        Thu, 13 Oct 2011 19:07:14 +0100
Date:   Thu, 13 Oct 2011 19:07:14 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <david.daney@cavium.com>
Cc:     manesoni@cisco.com, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, ananth@in.ibm.com, kamensky@cisco.com
Subject: Re: [PATCH] MIPS Kprobes: Support branch instructions probing
Message-ID: <20111013180714.GA7422@linux-mips.org>
References: <20111013090749.GB16761@cisco.com>
 <4E971FD3.2020308@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4E971FD3.2020308@cavium.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 31234
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 9454

On Thu, Oct 13, 2011 at 10:28:51AM -0700, David Daney wrote:

> Where is the handling for:
> 
> 	case cop1_op:
> 
> #ifdef CONFIG_CPU_CAVIUM_OCTEON
> 	case lwc2_op: /* This is bbit0 on Octeon */
> 	case ldc2_op: /* This is bbit032 on Octeon */
> 	case swc2_op: /* This is bbit1 on Octeon */
> 	case sdc2_op: /* This is bbit132 on Octeon */
> #endif
> 
> These are all defined in insn_has_delayslot() but not here.

Which is a wonderful demonstration for why duplicating such a large
function from branch.c was a baaad thing to do.

Maneesh, can you refactor the code to share everything that was copied
from __compute_return_epc() can be shared with kprobes?  Idealy make
everything a two part series, first one patch to refactor branch.c and
the 2nd patch to deal with kprobes.

Thanks,

  Ralf
