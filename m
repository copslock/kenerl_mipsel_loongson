Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 May 2010 18:32:38 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:33434 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491204Ab0EZQcf (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 26 May 2010 18:32:35 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o4QGWTfK017144;
        Wed, 26 May 2010 17:32:31 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o4QGWSOc017142;
        Wed, 26 May 2010 17:32:28 +0100
Date:   Wed, 26 May 2010 17:32:27 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Julia Lawall <julia@diku.dk>,
        "Kevin D. Kissell" <kevink@paralogos.com>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 3/17] arch/mips/kernel: Add missing read_unlock
Message-ID: <20100526163227.GA17043@linux-mips.org>
References: <Pine.LNX.4.64.1005261754390.23743@ask.diku.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1005261754390.23743@ask.diku.dk>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26855
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, May 26, 2010 at 05:54:55PM +0200, Julia Lawall wrote:

> From: Julia Lawall <julia@diku.dk>
> 
> Add a read_unlock missing on the error path.  Other ways of reaching
> out_unlock have tasklist_lock unlocked.
> 
> The semantic match that finds this problem is as follows:
> (http://coccinelle.lip6.fr/)
> 
> // <smpl>
> @@
> expression E1;
> @@
> 
> * read_lock(E1,...);
>   <+... when != E1
>   if (...) {
>     ... when != E1
> *   return ...;
>   }
>   ...+>
> * read_unlock(E1,...);
> // </smpl>
> 
> Signed-off-by: Julia Lawall <julia@diku.dk>
> 
> ---
> I wasn't able to find what security_task_setscheduler actually does.  
> If it releases tasklist_lock in an error case, then ignire this patch.

Your patch appears correct - and mipsmt_sys_sched_setaffinity() even
more broken than you thought.  It duplicates some code from kernel/sched.c
and has gotten out of sync.

Fixing that up.

   Ralf
