Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Jun 2013 18:19:32 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:15386 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827823Ab3FZQT03stsC (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 26 Jun 2013 18:19:26 +0200
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r5QGJHmr029752
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Wed, 26 Jun 2013 12:19:17 -0400
Received: from tranklukator.brq.redhat.com (dhcp-1-192.brq.redhat.com [10.34.1.192])
        by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with SMTP id r5QGJDMW029746;
        Wed, 26 Jun 2013 12:19:14 -0400
Received: by tranklukator.brq.redhat.com (nbSMTP-1.00) for uid 500
        oleg@redhat.com; Wed, 26 Jun 2013 18:14:56 +0200 (CEST)
Date:   Wed, 26 Jun 2013 18:14:52 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Daney <ddaney@caviumnetworks.com>,
        David Daney <ddaney.cavm@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        David Daney <david.daney@cavium.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Dave Jones <davej@redhat.com>, linux-mips@linux-mips.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v3] kernel/signal.c: fix BUG_ON with SIG128 (MIPS)
Message-ID: <20130626161452.GA2888@redhat.com>
References: <1371821962-9151-1-git-send-email-james.hogan@imgtec.com> <51C47864.9030200@gmail.com> <20130621202244.GA16610@redhat.com> <51C4BB86.1020004@caviumnetworks.com> <20130622190940.GA14150@redhat.com> <51C80CF0.4070608@imgtec.com> <20130625144015.1e4e70a0ac888f4ccf5c6a8f@linux-foundation.org> <CAAG0J9-5J6=c=1VxEW6FevMHKsjShtbjM8G6Q1vu1P+LurQqoQ@mail.gmail.com> <51CACB80.5020706@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51CACB80.5020706@imgtec.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.11
Return-Path: <oleg@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37140
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: oleg@redhat.com
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

On 06/26, James Hogan wrote:
>
> On 25/06/13 23:13, James Hogan wrote:
>   BUG_ON(exit_code & 0x80); /* core dumps don't get here */
>
> As a quick fix, mask out higher bits in the signal number. This
> effectively matches the exit code from other code paths but avoids the
> BUG_ON.
> 
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: David Daney <david.daney@cavium.com>
> Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Dave Jones <davej@redhat.com>
> Cc: linux-mips@linux-mips.org
> Cc: stable@vger.kernel.org
> ---
>  kernel/signal.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
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

Or simply remove the BUG_ON(), this can equally confuse wait(status).
128 & 0x7f == 0.

Still I think it would be better to change _NSIG on mips.

Oleg.
