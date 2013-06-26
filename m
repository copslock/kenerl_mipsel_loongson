Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Jun 2013 18:02:13 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:48706 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6819313Ab3FZQCDynUjy (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 26 Jun 2013 18:02:03 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r5QG1IBG012690;
        Wed, 26 Jun 2013 18:01:18 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r5QG1C4F012686;
        Wed, 26 Jun 2013 18:01:12 +0200
Date:   Wed, 26 Jun 2013 18:01:12 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        David Daney <ddaney@caviumnetworks.com>,
        David Daney <ddaney.cavm@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        David Daney <david.daney@cavium.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Dave Jones <davej@redhat.com>, linux-mips@linux-mips.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v3] kernel/signal.c: fix BUG_ON with SIG128 (MIPS)
Message-ID: <20130626160112.GD7171@linux-mips.org>
References: <1371821962-9151-1-git-send-email-james.hogan@imgtec.com>
 <51C47864.9030200@gmail.com>
 <20130621202244.GA16610@redhat.com>
 <51C4BB86.1020004@caviumnetworks.com>
 <20130622190940.GA14150@redhat.com>
 <51C80CF0.4070608@imgtec.com>
 <20130625144015.1e4e70a0ac888f4ccf5c6a8f@linux-foundation.org>
 <CAAG0J9-5J6=c=1VxEW6FevMHKsjShtbjM8G6Q1vu1P+LurQqoQ@mail.gmail.com>
 <51CACB80.5020706@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51CACB80.5020706@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37138
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

On Wed, Jun 26, 2013 at 12:07:44PM +0100, James Hogan wrote:

> > IMO changing the ABI by reducing _NSIG to 127 or 126 isn't appropriate
> > for stable.
> 
> How does this look for a nasty/stable fix?

> diff --git a/kernel/signal.c b/kernel/signal.c
> index 113411b..9ea8f4f 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -2366,8 +2366,14 @@ relock:
>  
>  		/*
>  		 * Death signals, no core dump.
> +		 *
> +		 * Some architectures (MIPS) have 128 signals which doesn't play
> +		 * nicely with the exit code since there are only 7 bits to
> +		 * store the terminating signal number. Mask out higher bits to
> +		 * avoid overflowing into the core dump bit and triggering
> +		 * BUG_ON in do_group_exit.
>  		 */
> -		do_group_exit(info->si_signo);
> +		do_group_exit(info->si_signo & 0x7f);
>  		/* NOTREACHED */
>  	}
>  	spin_unlock_irq(&sighand->siglock);

Looks like something which I think we could live with.

Clearly it also scores in the "nasty" category, so fits the bill ;)

  Ralf
