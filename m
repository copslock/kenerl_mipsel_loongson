Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Oct 2004 18:35:02 +0100 (BST)
Received: from web.epost.de ([IPv6:::ffff:193.28.100.152]:14768 "EHLO
	mail.epost.de") by linux-mips.org with ESMTP id <S8225346AbUJHRe4>;
	Fri, 8 Oct 2004 18:34:56 +0100
Received: from hag03new.zedernweg.de (82.83.68.238) by mail.epost.de (7.2.033.1) (authenticated as Joerg.Hagedorn1@epost.de)
        id 4164A17D0003BD4A for linux-mips@linux-mips.org; Fri, 8 Oct 2004 19:34:54 +0200
From: =?iso-8859-1?q?J=F6rg=20Hagedorn?= <Joerg.Hagedorn1@epost.de>
To: linux-mips@linux-mips.org
Subject: vr4131 and time.c Kernel 2.4.27
Date: Fri, 8 Oct 2004 19:38:22 +0200
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410081938.22930.Joerg.Hagedorn1@epost.de>
Return-Path: <Joerg.Hagedorn1@epost.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5986
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Joerg.Hagedorn1@epost.de
Precedence: bulk
X-list: linux-mips

Dear all,
I try to port the mips kernel to a vr4131 based pda. I have started from the 
tanbac board 226 but now I got the following message

init/main.o: In function `start_kernel':
init/main.o(.text.init+0x50c): undefined reference to `time_init'
kernel/kernel.o: In function `sys_time':
kernel/kernel.o(.text+0x90c0): undefined reference to `do_gettimeofday'
kernel/kernel.o: In function `sys_gettimeofday':
....

Before I start with my modifications I did not get this message. What is the 
reason why the compiler did not find the complete time environment.

Many thanks
Joerg



__________________________________________
www.messezimmer-duesseldorf.de
www.messezimmer-essen.de
www.zedernweg.de
