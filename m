Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Oct 2009 16:42:30 +0100 (CET)
Received: from gateway-1237.mvista.com ([206.112.117.35]:15597 "HELO
	imap.sh.mvista.com" rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org
	with SMTP id S1493174AbZJZPmV (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 26 Oct 2009 16:42:21 +0100
Received: from [192.168.11.189] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with SMTP
	id BB4BD3EEC; Mon, 26 Oct 2009 08:42:07 -0700 (PDT)
Message-ID: <4AE5C344.4020104@ru.mvista.com>
Date:	Mon, 26 Oct 2009 18:41:56 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Wu Zhangjin <wuzhangjin@gmail.com>
Cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
	Frederic Weisbecker <fweisbec@gmail.com>, rostedt@goodmis.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ralf Baechle <ralf@linux-mips.org>,
	Richard Sandiford <rdsandiford@googlemail.com>,
	Nicholas Mc Guire <der.herr@hofr.at>,
	David Daney <ddaney@caviumnetworks.com>,
	Adam Nemet <anemet@caviumnetworks.com>,
	Patrik Kluba <kpajko79@gmail.com>
Subject: Re: [PATCH -v6 05/13] tracing: enable HAVE_FUNCTION_TRACE_MCOUNT_TEST
 for MIPS
References: <cover.1256569489.git.wuzhangjin@gmail.com> <747deea2f18d5ccffe842df95a9dd1c86251a958.1256569489.git.wuzhangjin@gmail.com> <3f47087b70a965fd679b17a59521671296457df1.1256569489.git.wuzhangjin@gmail.com> <f290e125634d164ec65b09b24b269815f78455ab.1256569489.git.wuzhangjin@gmail.com> <07dc907ec62353b1aca99b2850d3b2e4b734189a.1256569489.git.wuzhangjin@gmail.com> <374da7039d2e1b97083edd8bcd7811356884d427.1256569489.git.wuzhangjin@gmail.com>
In-Reply-To: <374da7039d2e1b97083edd8bcd7811356884d427.1256569489.git.wuzhangjin@gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24522
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Wu Zhangjin wrote:

> There is an exisiting common ftrace_test_stop_func() in
> kernel/trace/ftrace.c, which is used to check the global variable
> ftrace_trace_stop to determine whether stop the function tracing.

> This patch implepment the MIPS specific one to speedup the procedure.

> Thanks goes to Zhang Le for Cleaning it up.

> Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>

[...]

> diff --git a/arch/mips/kernel/mcount.S b/arch/mips/kernel/mcount.S
> index 0c39bc8..5dfaca8 100644
> --- a/arch/mips/kernel/mcount.S
> +++ b/arch/mips/kernel/mcount.S
> @@ -64,6 +64,10 @@
>  	.endm
>  
>  NESTED(_mcount, PT_SIZE, ra)
> +	lw	t0, function_trace_stop
> +	bnez	t0, ftrace_stub
> +	nop

1) unless .set noreorder is specified in this file, explicit nop is not needed;

2) delay slot instruction is usually denoted by adding extra space on its 
left, like this:

	bnez	t0, ftrace_stub
	 nop

WBR, Sergei
