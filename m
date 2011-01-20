Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Jan 2011 15:04:53 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:4055 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491203Ab1ATOEs (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 20 Jan 2011 15:04:48 +0100
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id p0KE4eAf003836
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Thu, 20 Jan 2011 09:04:40 -0500
Received: from [10.3.113.76] (ovpn-113-76.phx2.redhat.com [10.3.113.76])
        by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id p0KE4c8i012206;
        Thu, 20 Jan 2011 09:04:39 -0500
Subject: Re: [PATCH 5/5] tracing, MIPS: Fix set_graph_function of function
 graph tracer
From:   Steven Rostedt <srostedt@redhat.com>
To:     Sergei Shtylyov <sshtylyov@mvista.com>
Cc:     Wu Zhangjin <wuzhangjin@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
In-Reply-To: <4D381677.3000502@mvista.com>
References: <cover.1295464855.git.wuzhangjin@gmail.com>
         <9967898043e58db7b311d35695e9422e67cef5f6.1295464855.git.wuzhangjin@gmail.com>
         <4D381677.3000502@mvista.com>
Content-Type: text/plain; charset="UTF-8"
Organization: Red Hat
Date:   Thu, 20 Jan 2011 09:04:38 -0500
Message-ID: <1295532278.19789.12.camel@fedora>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.12
Return-Path: <srostedt@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28995
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: srostedt@redhat.com
Precedence: bulk
X-list: linux-mips

On Thu, 2011-01-20 at 14:03 +0300, Sergei Shtylyov wrote:

> > diff --git a/arch/mips/kernel/ftrace.c b/arch/mips/kernel/ftrace.c
> > index bc91e4a..62775d7 100644
> > --- a/arch/mips/kernel/ftrace.c
> > +++ b/arch/mips/kernel/ftrace.c
> [...]
> > @@ -304,7 +304,14 @@ void prepare_ftrace_return(unsigned long *parent_ra_addr, unsigned long self_ra,
> >   		return;
> >   	}
> >
> > -	trace.func = self_ra;
> > +	/*
> > +	 * Get the recorded ip of the current mcount calling site in the
> > +	 * __mcount_loc section, which will be used to filter the function
> > +	 * entries configured through the tracing/set_graph_function interface.
> > +	 */
> > +
> > +	insns = (in_kernel_space(self_ra)) ? 2 : (MCOUNT_OFFSET_INSNS + 1);
> 
>     Unneeded parens.

agreed

> 
> > +	trace.func = self_ra - (MCOUNT_INSN_SIZE * insns);
> 
>     Here too.

I like the parens here. Yes, it is basic math precedence, but it stands
out to a reviewer who has their brain more focused on correct code than
thinking about which op has precedence.

Reviewing code that has:

	trace.func = self_ra - MCOUNT_INSN_SIZE * insns;

And as I my mother language reads left to right, my thought process
goes: subtract MCOUNT_INSN_SIZE from self_ra and then times insns... oh
wait, times goes first; stop reset, restart... subtract MCOUNT_INSN_SIZE
times insns from self_ra.  That stop reset and restart of the thought
process breaks the train of thought and could waste a lot more time than
just the moment it happened. All this is avoided by the parenthesis that
automatically trigger the brain to think those go first.

I say, leave these in.

-- Steve
