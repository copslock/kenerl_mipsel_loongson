Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Oct 2009 22:52:28 +0200 (CEST)
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.125]:47922 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493818AbZJVUwV (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 22 Oct 2009 22:52:21 +0200
Received: from [192.168.23.10] (really [74.67.89.75])
          by hrndva-omta03.mail.rr.com with ESMTP
          id <20091022205208122.VGCG15360@hrndva-omta03.mail.rr.com>;
          Thu, 22 Oct 2009 20:52:11 +0000
Subject: Re: [PATCH -v4 4/9] tracing: add static function tracer support
 for MIPS
From:	Steven Rostedt <rostedt@goodmis.org>
Reply-To: rostedt@goodmis.org
To:	Adam Nemet <anemet@caviumnetworks.com>
Cc:	David Daney <ddaney@caviumnetworks.com>, wuzhangjin@gmail.com,
	Richard Sandiford <rdsandiford@googlemail.com>,
	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ralf Baechle <ralf@linux-mips.org>,
	Nicholas Mc Guire <der.herr@hofr.at>
In-Reply-To: <19168.49354.525249.654494@ropi.home>
References: <028867b99ec532b84963a35e7d552becc783cafc.1256135456.git.wuzhangjin@gmail.com>
	 <2f73eae542c47ac5bbb9f7280e6c0271d193e90d.1256135456.git.wuzhangjin@gmail.com>
	 <3f0d3515f74a58f4cfd11e61b62a129fdc21e3a7.1256135456.git.wuzhangjin@gmail.com>
	 <ea8aa927fbd184b54941e4c2ae0be8ea0b4f6b8a.1256135456.git.wuzhangjin@gmail.com>
	 <1256138686.18347.3039.camel@gandalf.stny.rr.com>
	 <1256233679.23653.7.camel@falcon> <4AE0A5BE.8000601@caviumnetworks.com>
	 <19168.49354.525249.654494@ropi.home>
Content-Type: text/plain
Organization: Kihon Technologies Inc.
Date:	Thu, 22 Oct 2009 16:52:06 -0400
Message-Id: <1256244726.20866.802.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.26.3 
Content-Transfer-Encoding: 7bit
Return-Path: <rostedt@goodmis.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24455
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rostedt@goodmis.org
Precedence: bulk
X-list: linux-mips

On Thu, 2009-10-22 at 13:30 -0700, Adam Nemet wrote:
> Maybe scanning the instructions should stop at the beginning of the function
> based on the kernel's symbol table.  I am not sure if we can establish any
> other stopping condition without affecting performance too much.

How would we check the kernel symbol table? Remember, this happens at
_every_ function call.

> 
> Speaking of performance, -pg also affects the instruction scheduling freedom
> of the compiler in the prologue.  With profiling, we limit optimizations not
> to move instructions in and out of the prologue.
> 
> Also note that for functions invoked via tail call you won't get an exit
> event.  E.g. if bar is tail-called from foo:
> 
>   foo entered
>   bar entered
>   foo/bar exited
> 
> However, this is not MIPS-specific and you can always disable tail calls
> with -fno-optimize-sibling-calls.

The question is, would bar have a _mcount call? So far, we have not had
any issues with this on either x86 nor PPC.

/me knocks on wood.

-- Steve
