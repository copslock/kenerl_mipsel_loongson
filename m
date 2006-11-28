Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Nov 2006 01:56:46 +0000 (GMT)
Received: from [69.90.147.196] ([69.90.147.196]:54958 "EHLO mail.kenati.com")
	by ftp.linux-mips.org with ESMTP id S20039273AbWK1B4l (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 28 Nov 2006 01:56:41 +0000
Received: from [192.168.1.169] (adsl-71-130-109-177.dsl.snfc21.pacbell.net [71.130.109.177])
	by mail.kenati.com (Postfix) with ESMTP id BDCE315D4003
	for <linux-mips@linux-mips.org>; Mon, 27 Nov 2006 19:25:35 -0800 (PST)
Subject: Big Endian Hello world instead of init?
From:	Ashlesha Shintre <ashlesha@kenati.com>
Reply-To: ashlesha@kenati.com
To:	linux-mips@linux-mips.org
Content-Type: text/plain
Date:	Mon, 27 Nov 2006 18:08:50 -0800
Message-Id: <1164679730.6538.14.camel@sandbar.kenati.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Return-Path: <ashlesha@kenati.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13262
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ashlesha@kenati.com
Precedence: bulk
X-list: linux-mips

Hi,

Process No. 1, the init process is not being spawned right by the
2.6.14.6 kernel for some reason on my board (Encore M3 with the AU1500
processor).  Hence in order to check whether the problem lies in user
space or kernel space, I compiled and linked the following hello world
program statically.  The board is Big Endian.  Thus, when I compile the
hello world program, I need to use a compiler option that will generate
Big Endian code -- is that correct?  The option being -EB.

Code:

#include<stdio.h>
int main()
{
	printf("Hello World\n");
	return 0;
}

I get the following message after the file system is mounted via NFS and
memory freed by the kernel:

> Failed to execute /bin/hello


Thanks,
Ashlesha.
