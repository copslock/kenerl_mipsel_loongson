Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Aug 2004 19:11:39 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:54776 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8224918AbUHESLf>;
	Thu, 5 Aug 2004 19:11:35 +0100
Received: from orion.mvista.com (localhost.localdomain [127.0.0.1])
	by orion.mvista.com (8.12.8/8.12.8) with ESMTP id i75IBXar028599;
	Thu, 5 Aug 2004 11:11:33 -0700
Received: (from jsun@localhost)
	by orion.mvista.com (8.12.8/8.12.8/Submit) id i75IBXDd028598;
	Thu, 5 Aug 2004 11:11:33 -0700
Date: Thu, 5 Aug 2004 11:11:33 -0700
From: Jun Sun <jsun@mvista.com>
To: G H <giles67@yahoo.com>
Cc: linux-mips@linux-mips.org, jsun@mvista.com
Subject: Re: do_ri failure in cache flushing routines
Message-ID: <20040805111133.B28337@mvista.com>
References: <20040805180427.59029.qmail@web50806.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040805180427.59029.qmail@web50806.mail.yahoo.com>; from giles67@yahoo.com on Thu, Aug 05, 2004 at 11:04:27AM -0700
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5604
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Thu, Aug 05, 2004 at 11:04:27AM -0700, G H wrote:
> I've not had much response to this question so I would like to rephrase it :
>  
> Can anyone think of any possible scenario where do_ri could occur in blast_icache32() ??
>  

One possibility _could_ be the "instruction flushing itself" problem on
MIPS32.  However, as far as I know au1x00 CPUs don't suffer from this problem.
Anybody knows for sure?

You could try to use the two phase cache flushing (such as the one used
by tx47xx and also see an earlier related discussion thread) and see if
the problem goes away.

Jun
