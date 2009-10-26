Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Oct 2009 16:57:38 +0100 (CET)
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:61074 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493201AbZJZP5b (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 26 Oct 2009 16:57:31 +0100
Received: from [192.168.23.10] (really [74.67.89.75])
          by hrndva-omta01.mail.rr.com with ESMTP
          id <20091026155722318.WPZZ20264@hrndva-omta01.mail.rr.com>;
          Mon, 26 Oct 2009 15:57:22 +0000
Subject: Re: [PATCH -v6 05/13] tracing: enable
 HAVE_FUNCTION_TRACE_MCOUNT_TEST for MIPS
From:	Steven Rostedt <rostedt@goodmis.org>
Reply-To: rostedt@goodmis.org
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	Wu Zhangjin <wuzhangjin@gmail.com>, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ralf Baechle <ralf@linux-mips.org>,
	Richard Sandiford <rdsandiford@googlemail.com>,
	Nicholas Mc Guire <der.herr@hofr.at>,
	David Daney <ddaney@caviumnetworks.com>,
	Adam Nemet <anemet@caviumnetworks.com>,
	Patrik Kluba <kpajko79@gmail.com>
In-Reply-To: <4AE5C344.4020104@ru.mvista.com>
References: <cover.1256569489.git.wuzhangjin@gmail.com>
	 <747deea2f18d5ccffe842df95a9dd1c86251a958.1256569489.git.wuzhangjin@gmail.com>
	 <3f47087b70a965fd679b17a59521671296457df1.1256569489.git.wuzhangjin@gmail.com>
	 <f290e125634d164ec65b09b24b269815f78455ab.1256569489.git.wuzhangjin@gmail.com>
	 <07dc907ec62353b1aca99b2850d3b2e4b734189a.1256569489.git.wuzhangjin@gmail.com>
	 <374da7039d2e1b97083edd8bcd7811356884d427.1256569489.git.wuzhangjin@gmail.com>
	 <4AE5C344.4020104@ru.mvista.com>
Content-Type: text/plain
Organization: Kihon Technologies Inc.
Date:	Mon, 26 Oct 2009 11:57:20 -0400
Message-Id: <1256572640.26028.302.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.26.3 
Content-Transfer-Encoding: 7bit
Return-Path: <rostedt@goodmis.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24523
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rostedt@goodmis.org
Precedence: bulk
X-list: linux-mips

On Mon, 2009-10-26 at 18:41 +0300, Sergei Shtylyov wrote:
> Hello.
> 
> Wu Zhangjin wrote:
> 
> > There is an exisiting common ftrace_test_stop_func() in
> > kernel/trace/ftrace.c, which is used to check the global variable
> > ftrace_trace_stop to determine whether stop the function tracing.
> 
> > This patch implepment the MIPS specific one to speedup the procedure.
> 
> > Thanks goes to Zhang Le for Cleaning it up.
> 
> > Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
> 
> [...]
> 
> > diff --git a/arch/mips/kernel/mcount.S b/arch/mips/kernel/mcount.S
> > index 0c39bc8..5dfaca8 100644
> > --- a/arch/mips/kernel/mcount.S
> > +++ b/arch/mips/kernel/mcount.S
> > @@ -64,6 +64,10 @@
> >  	.endm
> >  
> >  NESTED(_mcount, PT_SIZE, ra)
> > +	lw	t0, function_trace_stop
> > +	bnez	t0, ftrace_stub
> > +	nop
> 
> 1) unless .set noreorder is specified in this file, explicit nop is not needed;

>From patch 4:

+++ b/arch/mips/kernel/mcount.S
@@ -0,0 +1,89 @@
+/*
+ * MIPS specific _mcount support
+ *
+ * This file is subject to the terms and conditions of the GNU General
Public
+ * License.  See the file "COPYING" in the main directory of this
archive for
+ * more details.
+ *
+ * Copyright (C) 2009 Lemote Inc. & DSLab, Lanzhou University, China
+ * Author: Wu Zhangjin <wuzj@lemote.com>
+ */
+
+#include <asm/regdef.h>
+#include <asm/stackframe.h>
+#include <asm/ftrace.h>
+
+       .text
+       .set noreorder
+       .set noat

-- Steve

> 
> 2) delay slot instruction is usually denoted by adding extra space on its 
> left, like this:
> 
> 	bnez	t0, ftrace_stub
> 	 nop
