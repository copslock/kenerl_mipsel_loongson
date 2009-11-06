Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Nov 2009 18:09:47 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:58088 "EHLO
	localhost.localdomain" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1493040AbZKFRJo (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 6 Nov 2009 18:09:44 +0100
Date:	Fri, 6 Nov 2009 17:09:44 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	David Daney <ddaney@caviumnetworks.com>
cc:	Dmitri Vorobiev <dmitri.vorobiev@gmail.com>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org
Subject: Re: COMMAND_LINE_SIZE and CONFIG_FRAME_WARN
In-Reply-To: <4AF4526B.3020502@caviumnetworks.com>
Message-ID: <alpine.LFD.2.00.0911061659060.9725@eddie.linux-mips.org>
References: <20091107.010839.246840249.anemo@mba.ocn.ne.jp>  <90edad820911060822g40233a8ft28001d68186b989e@mail.gmail.com> <90edad820911060834t5c14aa30t847c3b75bf7e36e@mail.gmail.com> <4AF4526B.3020502@caviumnetworks.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24741
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, 6 Nov 2009, David Daney wrote:

> It depends on your concerns.  You are still using 4096 bytes of stack, 
> but you are trying to trick the compiler into not warning.
> 
> If you think the warning is bogus, you should remove it for all code, 
> not just this file.  If you think the warning is valid, then you should 
> fix the code so that it doesn't use as much stack space.

 My understanding is the option is for detecting unintended excessive use 
of stack space.  If a place is known to require more space, it is 
justified and harmless (such as in an early bootstrap call), then I see no 
reason to forbid it or to imply it should be allowed globally then.

 Note that stack space of 4096 bytes required by a single call is 
functionally equivalent to four nested calls requiring 1024 bytes each, so 
from the practical point of view they are equivalent and during kernel 
startup we may know that nesting is less extensive than, say, when a 
syscall or an interrupt handler is being executed, where such stack 
consumption would be of much more concern.

  Maciej
