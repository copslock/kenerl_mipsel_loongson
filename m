Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Jul 2014 16:31:51 +0200 (CEST)
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.226]:38190 "EHLO
        cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S6861101AbaGBObril84d (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 2 Jul 2014 16:31:47 +0200
Received: from [67.246.153.56] ([67.246.153.56:52606] helo=gandalf.local.home)
        by cdptpa-oedge03 (envelope-from <rostedt@goodmis.org>)
        (ecelerity 3.5.0.35861 r(Momo-dev:tip)) with ESMTP
        id EA/DF-02848-AC714B35; Wed, 02 Jul 2014 14:31:40 +0000
Date:   Wed, 2 Jul 2014 10:31:38 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-mips@linux-mips.org
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-arch@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Jiri Kosina <jkosina@suse.cz>,
        Josh Poimboeuf <notifications@github.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [RFA][PATCH 07/27] MIPS: ftrace: Add call to
 ftrace_graph_is_dead() in function graph code
Message-ID: <20140702103138.01880b1d@gandalf.local.home>
In-Reply-To: <20140626165849.321719498@goodmis.org>
References: <20140626165221.736847419@goodmis.org>
        <20140626165849.321719498@goodmis.org>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-RR-Connecting-IP: 107.14.168.142:25
X-Cloudmark-Score: 0
Return-Path: <rostedt@goodmis.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40986
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rostedt@goodmis.org
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


Adding linux-mips@linux-mips.org.

-- Steve


On Thu, 26 Jun 2014 12:52:28 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>
> 
> ftrace_stop() is going away as it disables parts of function tracing
> that affects users that should not be affected. But ftrace_graph_stop()
> is built on ftrace_stop(). Here's another example of killing all of
> function tracing because something went wrong with function graph
> tracing.
> 
> Instead of disabling all users of function tracing on function graph
> error, disable only function graph tracing. To do this, the arch code
> must call ftrace_graph_is_dead() before it implements function graph.
> 
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
> ---
>  arch/mips/kernel/ftrace.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/mips/kernel/ftrace.c b/arch/mips/kernel/ftrace.c
> index 60e7e5e45af1..8b6538750fe1 100644
> --- a/arch/mips/kernel/ftrace.c
> +++ b/arch/mips/kernel/ftrace.c
> @@ -302,6 +302,9 @@ void prepare_ftrace_return(unsigned long *parent_ra_addr, unsigned long self_ra,
>  	    &return_to_handler;
>  	int faulted, insns;
>  
> +	if (unlikely(ftrace_graph_is_dead()))
> +		return;
> +
>  	if (unlikely(atomic_read(&current->tracing_graph_pause)))
>  		return;
>  
