Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Sep 2003 15:36:46 +0100 (BST)
Received: from mail.ocs.com.au ([IPv6:::ffff:203.34.97.2]:40202 "HELO
	mail.ocs.com.au") by linux-mips.org with SMTP id <S8225389AbTIKOgq>;
	Thu, 11 Sep 2003 15:36:46 +0100
Received: (qmail 29807 invoked from network); 11 Sep 2003 14:36:37 -0000
Received: from ocs3.intra.ocs.com.au (192.168.255.3)
  by mail.ocs.com.au with SMTP; 11 Sep 2003 14:36:36 -0000
Received: by ocs3.intra.ocs.com.au (Postfix, from userid 16331)
	id 354D7C00A9; Fri, 12 Sep 2003 00:36:36 +1000 (EST)
Received: from ocs3.intra.ocs.com.au (localhost [127.0.0.1])
	by ocs3.intra.ocs.com.au (Postfix) with ESMTP
	id 31D4C14010C; Fri, 12 Sep 2003 00:36:36 +1000 (EST)
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
From:	Keith Owens <kaos@ocs.com.au>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: Some Question about the kernel module on MIPS64 
In-reply-to: Your message of "Thu, 11 Sep 2003 16:26:11 +0200."
             <20030911142611.GC15365@linux-mips.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:	Fri, 12 Sep 2003 00:36:35 +1000
Message-ID: <6668.1063290995@ocs3.intra.ocs.com.au>
Return-Path: <kaos@ocs.com.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3167
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kaos@ocs.com.au
Precedence: bulk
X-list: linux-mips

On Thu, 11 Sep 2003 16:26:11 +0200, 
Ralf Baechle <ralf@linux-mips.org> wrote:
>On Thu, Sep 11, 2003 at 10:13:58AM +0800, ???? wrote:
>> try.o: init_module: Invalid argument
>> Hint: insmod errors can be caused by incorrect module parameters,
>> including invalid IO or IRQ parameters
>> Of course we do the above works in the same hardware platform .
>> Is there any thing I should pay attention to when I compile the Kernel
>> Module or the linux for mips64? Eagering your help!!
>
>The problem isn't the kernel but modutils which don't support kernel
>modules for 64-bit kernels.

Nobody has sent me patches for mips64 (hint, hint).
