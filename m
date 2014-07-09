Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Jul 2014 18:03:19 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:9461 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6861448AbaGIPuWY0Ahq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 Jul 2014 17:50:22 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 0907C6A84B760;
        Wed,  9 Jul 2014 16:50:12 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 9 Jul 2014 16:50:15 +0100
Received: from [192.168.154.101] (192.168.154.101) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.195.1; Wed, 9 Jul
 2014 16:50:14 +0100
Message-ID: <53BD6450.50103@imgtec.com>
Date:   Wed, 9 Jul 2014 16:48:32 +0100
From:   James Hogan <james.hogan@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
MIME-Version: 1.0
To:     Steven Rostedt <rostedt@goodmis.org>, <linux-mips@linux-mips.org>
CC:     <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
        "H. Peter Anvin" <hpa@zytor.com>, <linux-arch@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Jiri Kosina <jkosina@suse.cz>,
        Josh Poimboeuf <notifications@github.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [RFA][PATCH 07/27] MIPS: ftrace: Add call to ftrace_graph_is_dead()
 in function graph code
References: <20140626165221.736847419@goodmis.org>      <20140626165849.321719498@goodmis.org> <20140702103138.01880b1d@gandalf.local.home>
In-Reply-To: <20140702103138.01880b1d@gandalf.local.home>
X-Enigmail-Version: 1.6
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.101]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41101
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

Hi Steven,

I've given this a quick test on a mips32 le target, on your
rfc/remove-function-trace-stop branch (4161daee7df8). Booted fine,
startup tests fine, function and function_graph trace appear to work
from a quick cat of the trace file. Feel free to add my Tested-by:

Tested-by: James Hogan <james.hogan@imgtec.com> [MIPS]

Cheers
James

On 02/07/14 15:31, Steven Rostedt wrote:
> 
> Adding linux-mips@linux-mips.org.
> 
> -- Steve
> 
> 
> On Thu, 26 Jun 2014 12:52:28 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
>> From: "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>
>>
>> ftrace_stop() is going away as it disables parts of function tracing
>> that affects users that should not be affected. But ftrace_graph_stop()
>> is built on ftrace_stop(). Here's another example of killing all of
>> function tracing because something went wrong with function graph
>> tracing.
>>
>> Instead of disabling all users of function tracing on function graph
>> error, disable only function graph tracing. To do this, the arch code
>> must call ftrace_graph_is_dead() before it implements function graph.
>>
>> Cc: Ralf Baechle <ralf@linux-mips.org>
>> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
>> ---
>>  arch/mips/kernel/ftrace.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/arch/mips/kernel/ftrace.c b/arch/mips/kernel/ftrace.c
>> index 60e7e5e45af1..8b6538750fe1 100644
>> --- a/arch/mips/kernel/ftrace.c
>> +++ b/arch/mips/kernel/ftrace.c
>> @@ -302,6 +302,9 @@ void prepare_ftrace_return(unsigned long *parent_ra_addr, unsigned long self_ra,
>>  	    &return_to_handler;
>>  	int faulted, insns;
>>  
>> +	if (unlikely(ftrace_graph_is_dead()))
>> +		return;
>> +
>>  	if (unlikely(atomic_read(&current->tracing_graph_pause)))
>>  		return;
>>  
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arch" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
