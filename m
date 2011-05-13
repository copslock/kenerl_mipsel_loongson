Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 May 2011 17:18:55 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:53308 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491839Ab1EMPSt (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 13 May 2011 17:18:49 +0200
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p4DFI0eO030522
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Fri, 13 May 2011 11:18:00 -0400
Received: from [10.11.10.76] (vpn-10-76.rdu.redhat.com [10.11.10.76])
        by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id p4DFHqa7022558;
        Fri, 13 May 2011 11:17:53 -0400
Subject: Re: [PATCH 3/5] v2 seccomp_filters: Enable ftrace-based system call
 filtering
From:   Eric Paris <eparis@redhat.com>
To:     Ingo Molnar <mingo@elte.hu>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        James Morris <jmorris@namei.org>,
        Will Drewry <wad@chromium.org>, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        kees.cook@canonical.com, agl@chromium.org,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Michal Marek <mmarek@suse.cz>,
        Oleg Nesterov <oleg@redhat.com>, Jiri Slaby <jslaby@suse.cz>,
        David Howells <dhowells@redhat.com>,
        Russell King <linux@arm.linux.org.uk>,
        Michal Simek <monstr@monstr.eu>,
        Ralf Baechle <ralf@linux-mips.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux390@de.ibm.com, Paul Mundt <lethal@linux-sh.org>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 13 May 2011 11:17:52 -0400
In-Reply-To: <20110513131800.GA7883@elte.hu>
References: <alpine.LRH.2.00.1105122133500.31507@tundra.namei.org>
         <20110512130104.GA2912@elte.hu>
         <alpine.LRH.2.00.1105131018040.3047@tundra.namei.org>
         <20110513121034.GG21022@elte.hu> <1305289146.2466.8.camel@twins>
         <20110513122646.GA3924@elte.hu> <1305290370.2466.14.camel@twins>
         <1305290612.2466.17.camel@twins> <20110513125452.GD3924@elte.hu>
         <1305292132.2466.26.camel@twins> <20110513131800.GA7883@elte.hu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Message-ID: <1305299880.2076.31.camel@localhost.localdomain>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.12
Return-Path: <eparis@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29995
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: eparis@redhat.com
Precedence: bulk
X-list: linux-mips

[dropping microblaze and roland]

On Fri, 2011-05-13 at 15:18 +0200, Ingo Molnar wrote:
> * Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Fri, 2011-05-13 at 14:54 +0200, Ingo Molnar wrote:
> > > I think the sanest semantics is to run all active callbacks as well.
> > > 
> > > For example if this is used for three stacked security policies - as if 3 LSM 
> > > modules were stacked at once. We'd call all three, and we'd determine that at 
> > > least one failed - and we'd return a failure. 
> > 
> > But that only works for boolean functions where you can return the
> > multi-bit-or of the result. What if you need to return the specific
> > error code.
> 
> Do you mean that one filter returns -EINVAL while the other -EACCES?
> 
> Seems like a non-problem to me, we'd return the first nonzero value.

Sounds so easy!  Why haven't LSMs stacked already?  Because what happens
if one of these hooks did something stateful?  Lets say on open, hook #1
returns EPERM.  hook #2 allocates memory.  The open is going to fail and
hooks #2 is never going to get the close() which should have freed the
allocation.  If you can be completely stateless its easier, but there's
a reason that stacking security modules is hard.  Serge has tried in the
past and both dhowells and casey schaufler are working on it right now.
Stacking is never as easy as it sounds   :)

-Eric
