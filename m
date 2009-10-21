Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Oct 2009 15:14:34 +0200 (CEST)
Received: from ru.mvista.com ([213.79.90.228]:4331 "EHLO
	buildserver.ru.mvista.com" rhost-flags-OK-FAIL-OK-FAIL)
	by ftp.linux-mips.org with ESMTP id S1493515AbZJUNO1 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 21 Oct 2009 15:14:27 +0200
Received: from [192.168.11.189] (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP
	id 3EC658817; Wed, 21 Oct 2009 18:14:19 +0500 (SAMST)
Message-ID: <4ADF093D.10403@ru.mvista.com>
Date:	Wed, 21 Oct 2009 17:14:37 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	rostedt@goodmis.org
Cc:	wuzhangjin@gmail.com, Thomas Gleixner <tglx@linutronix.de>,
	Nicholas Mc Guire <der.herr@hofr.at>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org
Subject: Re: ftrace for MIPS
References: <1255995599.17795.15.camel@falcon>	 <1255997319.18347.576.camel@gandalf.stny.rr.com>	 <1256052667.8149.56.camel@falcon> <1256055714.18347.1608.camel@gandalf.stny.rr.com>
In-Reply-To: <1256055714.18347.1608.camel@gandalf.stny.rr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24401
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Steven Rostedt wrote:

>>Need to check which registers is missing when saving/restoring for
>>_mcount:

>>NESTED(ftrace_graph_caller, PT_SIZE, ra) 
>>        MCOUNT_SAVE_REGS
>>        PTR_S   v0, PT_R2(sp)
>>
>>        MCOUNT_SET_ARGS
>>        jal     prepare_ftrace_return
>>        nop
>>
>>        /* overwrite the parent as &return_to_handler: v0 -> $1(at) */
>>        move    $1,     v0  

> I'm confused here? I'm not exactly sure what the above is doing. Is $1 a
> register (AT)?

    Yes.

> And how is this register used before calling mcount?

>>        PTR_L   v0, PT_R2(sp)
>>        MCOUNT_RESTORE_REGS
>>        RETURN_BACK
>>        END(ftrace_graph_caller)

>>        .align  2
>>        .globl  return_to_handler
>>return_to_handler:
>>        PTR_SUBU        sp, PT_SIZE
>>        PTR_S   v0, PT_R2(sp)

> BTW, is v0 the only return register? I know x86 can return two different
> registers depending on what it returns. What happens if a function
> returns a 64 bit value on a 32bit box? Does it use two registers for
> that?

    Yes, there's also v1 register.

WBR, Sergei
