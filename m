Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Jun 2013 19:20:33 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:57189 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6819313Ab3FZRUbxZvVL (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 26 Jun 2013 19:20:31 +0200
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r5QHKMJD026104
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Wed, 26 Jun 2013 13:20:22 -0400
Received: from tranklukator.brq.redhat.com (dhcp-1-192.brq.redhat.com [10.34.1.192])
        by int-mx12.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id r5QHKCNo010560;
        Wed, 26 Jun 2013 13:20:13 -0400
Received: by tranklukator.brq.redhat.com (nbSMTP-1.00) for uid 500
        oleg@redhat.com; Wed, 26 Jun 2013 19:16:02 +0200 (CEST)
Date:   Wed, 26 Jun 2013 19:15:51 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     James Hogan <james.hogan@imgtec.com>,
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
Message-ID: <20130626171551.GA5830@redhat.com>
References: <51C47864.9030200@gmail.com> <20130621202244.GA16610@redhat.com> <51C4BB86.1020004@caviumnetworks.com> <20130622190940.GA14150@redhat.com> <51C80CF0.4070608@imgtec.com> <20130625144015.1e4e70a0ac888f4ccf5c6a8f@linux-foundation.org> <CAAG0J9-5J6=c=1VxEW6FevMHKsjShtbjM8G6Q1vu1P+LurQqoQ@mail.gmail.com> <51CACB80.5020706@imgtec.com> <20130626161452.GA2888@redhat.com> <20130626165900.GF7171@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20130626165900.GF7171@linux-mips.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.25
Return-Path: <oleg@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37145
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

On 06/26, Ralf Baechle wrote:
>
> On Wed, Jun 26, 2013 at 06:14:52PM +0200, Oleg Nesterov wrote:
>
> > Or simply remove the BUG_ON(), this can equally confuse wait(status).
> > 128 & 0x7f == 0.
> >
> > Still I think it would be better to change _NSIG on mips.
>
> If it was that easy.  That's going to outright break binary compatibility,
> see kernel/signal.c:
>
> SYSCALL_DEFINE4(rt_sigprocmask, int, how, sigset_t __user *, nset,
>                 sigset_t __user *, oset, size_t, sigsetsize)
> {
>         sigset_t old_set, new_set;
>         int error;
>
>         /* XXX: Don't preclude handling different sized sigset_t's.  */
>         if (sigsetsize != sizeof(sigset_t))
>                 return -EINVAL;

I meant the minimal hack like

	--- x/arch/mips/include/uapi/asm/signal.h
	+++ x/arch/mips/include/uapi/asm/signal.h
	@@ -11,9 +11,9 @@
	 
	 #include <linux/types.h>
	 
	-#define _NSIG		128
	+#define _NSIG		127
	 #define _NSIG_BPW	(sizeof(unsigned long) * 8)
	-#define _NSIG_WORDS	(_NSIG / _NSIG_BPW)
	+#define _NSIG_WORDS	DIV_ROUND_UP(_NSIG / _NSIG_BPW)
	 
	 typedef struct {
		unsigned long sig[_NSIG_WORDS];

just to avoid BUG_ON().

I agree that _NSIG == 126 or 64 needs more discussion. Although personally
I think this is the only choice in the long term, or we should change ABI
and break user-space completely.

And, just in case, the hack above doesn't kill SIG_128 completely.
Say, the task can block/unblock it.

Oleg.
