Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Jun 2013 20:00:55 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:63094 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6816384Ab3F1SAxaeK7Y (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 28 Jun 2013 20:00:53 +0200
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r5SI0gUY026021
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Fri, 28 Jun 2013 14:00:42 -0400
Received: from tranklukator.brq.redhat.com (dhcp-1-192.brq.redhat.com [10.34.1.192])
        by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with SMTP id r5SI0NKO024029;
        Fri, 28 Jun 2013 14:00:23 -0400
Received: by tranklukator.brq.redhat.com (nbSMTP-1.00) for uid 500
        oleg@redhat.com; Fri, 28 Jun 2013 19:56:11 +0200 (CEST)
Date:   Fri, 28 Jun 2013 19:55:59 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Andrew Morton <akpm@linux-foundation.org>,
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
Message-ID: <20130628175559.GA30445@redhat.com>
References: <51C4BB86.1020004@caviumnetworks.com> <20130622190940.GA14150@redhat.com> <51C80CF0.4070608@imgtec.com> <20130625144015.1e4e70a0ac888f4ccf5c6a8f@linux-foundation.org> <CAAG0J9-5J6=c=1VxEW6FevMHKsjShtbjM8G6Q1vu1P+LurQqoQ@mail.gmail.com> <51CACB80.5020706@imgtec.com> <20130626161452.GA2888@redhat.com> <20130626165900.GF7171@linux-mips.org> <20130626171551.GA5830@redhat.com> <51CD7C8C.4050807@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51CD7C8C.4050807@imgtec.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.12
Return-Path: <oleg@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37208
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

On 06/28, James Hogan wrote:
>
> On 26/06/13 18:15, Oleg Nesterov wrote:
> >
> > I meant the minimal hack like
> >
> > 	--- x/arch/mips/include/uapi/asm/signal.h
> > 	+++ x/arch/mips/include/uapi/asm/signal.h
> > 	@@ -11,9 +11,9 @@
> >
> > 	 #include <linux/types.h>
> >
> > 	-#define _NSIG		128
> > 	+#define _NSIG		127
> > 	 #define _NSIG_BPW	(sizeof(unsigned long) * 8)
> > 	-#define _NSIG_WORDS	(_NSIG / _NSIG_BPW)
> > 	+#define _NSIG_WORDS	DIV_ROUND_UP(_NSIG / _NSIG_BPW)
> >
> > 	 typedef struct {
> > 		unsigned long sig[_NSIG_WORDS];
> >
> > just to avoid BUG_ON().
> >
> > I agree that _NSIG == 126 or 64 needs more discussion. Although personally
> > I think this is the only choice in the long term, or we should change ABI
> > and break user-space completely.
> >
> > And, just in case, the hack above doesn't kill SIG_128 completely.
> > Say, the task can block/unblock it.
>
> Well it prevents a handler being added or the signal being sent, so it
> pretty much does kill it (patch v2 did this).

Yes, iirc you already sent something like the hack above.

> but it looks like it may be safe to
> reduce _NSIG to 127 for a stable fix

This was my point.

Sure, this change can break something anyway, we can't know if nobody
ever uses 128 anyway. But this is better than the ability to crash the
kernel. No need to use strace, just block(128) + kill(128) + unblock().

So perhaps you can resend your patch? Just I think it makes sense to
update the changelog to explain that this is not the "final" solution
but the minimal fix.

Oleg.
