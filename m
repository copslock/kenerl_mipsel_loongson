Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Apr 2003 14:57:40 +0100 (BST)
Received: from [IPv6:::ffff:212.130.55.83] ([IPv6:::ffff:212.130.55.83]:32004
	"EHLO NTEX.tt.dk") by linux-mips.org with ESMTP id <S8225073AbTDAN5j>;
	Tue, 1 Apr 2003 14:57:39 +0100
Received: from lnsw.ttnet ([89.1.6.39]) by NTEX.tt.dk with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2653.13)
	id HS0GYRFK; Tue, 1 Apr 2003 15:57:20 +0200
Received: from brmlinux.ttnet ([89.1.5.102] helo=tt.dk)
	by lnsw.ttnet with esmtp (Exim 3.35 #1 (Debian))
	id 190MGO-00017B-00; Tue, 01 Apr 2003 15:57:20 +0200
Message-ID: <3E899ABF.3070704@tt.dk>
Date: Tue, 01 Apr 2003 15:57:19 +0200
From: Brian Murphy <brm@tt.dk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: en, en-ie
MIME-Version: 1.0
To: Ralf Baechle <ralf@linux-mips.org>
CC: "Neeraj Garg, Noida" <ngarg@noida.hcltech.com>,
	linux-mips@linux-mips.org
Subject: Re: Linux-MIPS compilation
References: <E04CF3F88ACBD5119EFE00508BBB2121086ED859@exch-01.noida.hcltech.com> <20030401134258.A7618@linux-mips.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <brm@tt.dk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1888
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: brm@tt.dk
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:

>The options -D__linux__ -D_MIPS_SZLONG=32 and the error messages make it
>look like you're forcing a non-Linux toolchain into building a kernel.
>
>  
>
What is the problem with this? At least a mips(el)-elf should have no 
problem compiling the kernel
(at least apart from the check you have somewhere which gives an error 
if you try).

/Brian
