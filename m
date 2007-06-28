Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Jun 2007 22:42:10 +0100 (BST)
Received: from smtp1.dnsmadeeasy.com ([205.234.170.134]:11468 "EHLO
	smtp1.dnsmadeeasy.com") by ftp.linux-mips.org with ESMTP
	id S20022738AbXF1VmE (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 28 Jun 2007 22:42:04 +0100
Received: from smtp1.dnsmadeeasy.com (localhost [127.0.0.1])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP id A42012D68A7;
	Thu, 28 Jun 2007 21:41:26 +0000 (UTC)
X-Authenticated-Name: js.dnsmadeeasy
X-Transit-System: In case of SPAM please contact abuse@dnsmadeeasy.com
Received: from avtrex.com (unknown [67.116.42.147])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP;
	Thu, 28 Jun 2007 21:41:26 +0000 (UTC)
Received: from [192.168.7.26] ([192.168.7.26]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 28 Jun 2007 14:41:25 -0700
Message-ID: <46842B05.5050103@avtrex.com>
Date:	Thu, 28 Jun 2007 14:41:25 -0700
From:	David Daney <ddaney@avtrex.com>
User-Agent: Thunderbird 1.5.0.12 (X11/20070530)
MIME-Version: 1.0
To:	"Ratin Rahman (mratin)" <mratin@cisco.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: gdbserver
References: <cda58cb80706260820y4db3eacnae4dff0101852d52@mail.gmail.com> <20070627.013312.25479645.anemo@mba.ocn.ne.jp> <20070627153932.GA6016@lst.de> <20070628.112223.96686654.nemoto@toshiba-tops.co.jp> <20070628083725.GA23394@lst.de> <27801B4D04E7CA45825B0E0CE60FE10A0410F0D6@xmb-sjc-237.amer.cisco.com>
In-Reply-To: <27801B4D04E7CA45825B0E0CE60FE10A0410F0D6@xmb-sjc-237.amer.cisco.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Jun 2007 21:41:25.0887 (UTC) FILETIME=[140848F0:01C7B9CD]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15567
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

Ratin Rahman (mratin) wrote:
> Anybody had luck with compiling gdbserver for mipsel? I am using x86
> based machine running Fedora 2.6.11 kernel, the target device is IDT 434
> running Mipsel 2.6.10 kernel. The gcc crosscompiler is mipsel-linux-gcc
> and version 3.2.3.
> 
> I did a ./configure --host=mipsel-linux-gnu --target=mipsel-linux-gnu
> followed by a make. Make failed with the messages: 
> 
> /opt/mipseltools/mipsel-linux/sys-include/sys/ptrace.h:33: syntax error
> before numeric constant
> /opt/mipseltools/mipsel-linux/sys-include/sys/ptrace.h:49: syntax error
> before numeric constant
> /opt/mipseltools/mipsel-linux/sys-include/sys/ptrace.h:61: syntax error
> before numeric constant
> /opt/mipseltools/mipsel-linux/sys-include/sys/ptrace.h:94: syntax error
> before numeric constant
> /opt/mipseltools/mipsel-linux/sys-include/sys/ptrace.h:112: syntax error
> before numeric constant
> linux-low.c: In function `kill_lwp':
> linux-low.c:760: warning: unused variable `tkill_failed'
> make: *** [linux-low.o] Error 1
> [root@Clearnet gdbserver]# nano
> /opt/mipseltools/mipsel-linux/sys-include/sys/ptrace.h
> [root@Clearnet gdbserver]# nano
> /opt/mipseltools/mipsel-linux/sys-include/sys/ptrace.h
> 
> 
> The content of ptrace.h has the enums declared as 
> 
> /* Type of the REQUEST argument to `ptrace.'  */
> enum __ptrace_request
> {
>   /* Indicate that the process making this request should be traced.
>      All signals received by this process can be intercepted by its
>      parent, and its parent can use the other `ptrace' requests.  */
>   PTRACE_TRACEME = 0,
> <==================================line 33
> #define PT_TRACE_ME PTRACE_TRACEME
> 
>   /* Return the word in the process's text space at address ADDR.  */
>   PTRACE_PEEKTEXT = 1,
> #define PT_READ_I PTRACE_PEEKTEXT
> 
> 
> ..which looks pretty normal to me , anybod yhave any clue? 
> Thanks,
> 

Perhaps your toolchain is broken, or perhaps you need to configure 
differently.

With my glibc-2.3.3/gcc-3.4.3 toolchain I do:
../gdb-6.6/configure  --target=mipsel-linux --host=mipsel-linux 
--build=i686-pc-linux-gnu

Then make and voila! gdb, gdbserver et al. are built.

David Danay
