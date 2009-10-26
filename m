Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Oct 2009 17:45:14 +0100 (CET)
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.124]:50852 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1491973AbZJZQpI (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 26 Oct 2009 17:45:08 +0100
Received: from [192.168.23.10] (really [74.67.89.75])
          by hrndva-omta01.mail.rr.com with ESMTP
          id <20091026164501347.YXZY20264@hrndva-omta01.mail.rr.com>;
          Mon, 26 Oct 2009 16:45:01 +0000
Subject: Re: [PATCH -v6 07/13] tracing: add dynamic function tracer support
 for MIPS
From:	Steven Rostedt <rostedt@goodmis.org>
Reply-To: rostedt@goodmis.org
To:	wuzhangjin@gmail.com
Cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ralf Baechle <ralf@linux-mips.org>,
	Richard Sandiford <rdsandiford@googlemail.com>,
	Nicholas Mc Guire <der.herr@hofr.at>,
	David Daney <ddaney@caviumnetworks.com>,
	Adam Nemet <anemet@caviumnetworks.com>,
	Patrik Kluba <kpajko79@gmail.com>
In-Reply-To: <1256574910.5642.228.camel@falcon>
References: <cover.1256569489.git.wuzhangjin@gmail.com>
	 <747deea2f18d5ccffe842df95a9dd1c86251a958.1256569489.git.wuzhangjin@gmail.com>
	 <3f47087b70a965fd679b17a59521671296457df1.1256569489.git.wuzhangjin@gmail.com>
	 <f290e125634d164ec65b09b24b269815f78455ab.1256569489.git.wuzhangjin@gmail.com>
	 <07dc907ec62353b1aca99b2850d3b2e4b734189a.1256569489.git.wuzhangjin@gmail.com>
	 <374da7039d2e1b97083edd8bcd7811356884d427.1256569489.git.wuzhangjin@gmail.com>
	 <3c82af564d70be05b92687949ed134ce034bf8db.1256569489.git.wuzhangjin@gmail.com>
	 <a11775df0ec9665fab5861f4fa63a3e192b9ffec.1256569489.git.wuzhangjin@gmail.com>
	 <1256573175.26028.310.camel@gandalf.stny.rr.com>
	 <1256574910.5642.228.camel@falcon>
Content-Type: text/plain
Organization: Kihon Technologies Inc.
Date:	Mon, 26 Oct 2009 12:45:00 -0400
Message-Id: <1256575500.26028.323.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.26.3 
Content-Transfer-Encoding: 7bit
Return-Path: <rostedt@goodmis.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24529
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rostedt@goodmis.org
Precedence: bulk
X-list: linux-mips

On Tue, 2009-10-27 at 00:35 +0800, Wu Zhangjin wrote:

> If remove the long jump, we at least to change the $mcount_regex in
> scripts/recordmcount.pl, the addr + 12 in arch/mips/include/asm/ftrace.h
> and the _mcount & ftrace_caller in mcount.S and the ftrace_make_nop &
> ftrace_make_call in arch/mips/kernel/ftrace.c back to the -v4 version.
> 
> I think this method of supporting module is not that BAD, no obvious
> overhead added except the "lui...addiu..." and two more "nop"
> instructions. and it's very understandable, so, just use this version?

You don't nop the lui and addiu do you? If you do you will crash the
machine.

As for overhead, you might want to test that out.

-- Steve
