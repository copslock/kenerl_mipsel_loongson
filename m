Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f36GndP00688
	for linux-mips-outgoing; Fri, 6 Apr 2001 09:49:39 -0700
Received: from stereotomy.lineo.com (stereotomy.lineo.com [64.50.107.151])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f36GncM00685
	for <linux-mips@oss.sgi.com>; Fri, 6 Apr 2001 09:49:38 -0700
Received: from Lineo.COM (localhost.localdomain [127.0.0.1])
	by stereotomy.lineo.com (Postfix) with ESMTP id 1205C4C92E
	for <linux-mips@oss.sgi.com>; Fri,  6 Apr 2001 10:49:38 -0600 (MDT)
Message-ID: <3ACDF3A1.4020109@Lineo.COM>
Date: Fri, 06 Apr 2001 10:49:37 -0600
From: Quinn Jensen <jensenq@Lineo.COM>
Organization: Lineo, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-9mdk i686; en-US; m18) Gecko/20010131 Netscape6/6.01
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
Subject: Re: Does Linux support RC32332 CPU now?
References: <007e01c0bd70$9052b4a0$8021690a@huawei.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

The IDT RC32332 is a subset of the RC32334, which
a working port exists for.  I have submitted a
patch to Ralf, but haven't seen it go into his tree
yet.  The patch is available at
http://www.zdomain.com/patch.sgi.idt

Quinn

owner-linux-mips@oss.sgi.com wrote:

 > Hi, folks:
 >
 >      I am a newbie in linux-mips. I have questions to ask:
 >
 >      1   Does Linux support RC32332 CPU now?
 >      2   I want to build my cross-compile environment  for MIPS target on my
 > X86 host. Are there any documents about how to implement it?
 >
 > Thank you very much.
