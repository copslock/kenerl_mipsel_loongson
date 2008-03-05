Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Mar 2008 12:35:31 +0000 (GMT)
Received: from mail.gmx.net ([213.165.64.20]:45187 "HELO mail.gmx.net")
	by ftp.linux-mips.org with SMTP id S20032430AbYCEMf2 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 5 Mar 2008 12:35:28 +0000
Received: (qmail invoked by alias); 05 Mar 2008 12:35:23 -0000
Received: from vpn27.rz.tu-ilmenau.de (EHLO [192.168.1.100]) [141.24.172.27]
  by mail.gmx.net (mp054) with SMTP; 05 Mar 2008 13:35:23 +0100
X-Authenticated: #44099387
X-Provags-ID: V01U2FsdGVkX19LO7FGJo1LqyDCRELHVaQ9xpYxfl0PvDlgFJmUo0
	5SArwd1lD7ZZun
Message-ID: <47CE9388.9050808@gmx.net>
Date:	Wed, 05 Mar 2008 13:35:20 +0100
From:	Andi <opencode@gmx.net>
User-Agent: Thunderbird 2.0.0.12 (X11/20080227)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Problems booting Linux kernel on Sigma SMP8634 #2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Return-Path: <opencode@gmx.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18335
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: opencode@gmx.net
Precedence: bulk
X-list: linux-mips

Hey folks,

first of all, sorry for _waisting_ the list with that topic again and again!

this question is related to that one here, posted sooner on this list:
http://www.linux-mips.org/archives/linux-mips/2008-02/msg00032.html

I spent a bit more time on this topic and found out that there is
seriously something going wrong with memory initialization and/or
handling during Linux startup.

I simply add "mem=32m" to the kernel command line, and the kernel runs
longer, at least a bit. However, it than stops with nearly the same
issue: Unable to handle kernel paging request at virtual address, but
different addresses. Tried "16m, 64m" and other values, all behave in
different way. Resulting to a crash at the position w/o any parameter or
 a bit later on.

Since I am not so familiar MIPS and especially the fact that our hard-
and software is more than closed, I am asking you guys to point me where
to spend more time on in order to get this issue fixed and fire up a
kernel on this box.

I am sure there some more guys around using the smp8634. Is it necessary
to load the microcode in order to get the kernel starting up?
Maybe we don't need the audio/video-ucode but irq-handler-ucode looks
very usefull ;-) Do we just have to copy this code at a certain memory
address?


Thank you in advance ...

Regards,
	Andi
