Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 15 Jan 2006 18:48:47 +0000 (GMT)
Received: from [62.38.115.213] ([62.38.115.213]:12165 "EHLO pfn3.pefnos")
	by ftp.linux-mips.org with ESMTP id S8126537AbWAOSsB (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 15 Jan 2006 18:48:01 +0000
Received: from xorhgos2.pefnos (xorhgos2.pefnos [192.168.0.3])
	by pfn3.pefnos (Postfix) with ESMTP id 643501F31B;
	Sun, 15 Jan 2006 20:51:15 +0200 (EET)
From:	"P. Christeas" <p_christ@hol.gr>
To:	Ivan Korzakow <ivan.korzakow@gmail.com>
Subject: Re: How to apply 2.6.15-git7 patchset ?
Date:	Sun, 15 Jan 2006 20:50:57 +0200
User-Agent: KMail/1.9
Cc:	linux-mips@linux-mips.org
References: <a59861030601130120y3456b6dat@mail.gmail.com>
In-Reply-To: <a59861030601130120y3456b6dat@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601152050.59057.p_christ@hol.gr>
Return-Path: <p_christ@hol.gr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9875
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: p_christ@hol.gr
Precedence: bulk
X-list: linux-mips

On Friday 13 January 2006 11:20 am, Ivan Korzakow wrote:
> Hi
>
> Could anybody tell me why I can't apply cleanly the
> "patch-2.6.15-git7.bz2" patchset on a mips repository ? Of course I
> tried to apply this patch on a 2.6.15 tree...
> Actually only mips files failed to be patched.
>
If it's only one file, you could resolve it manually.
It is common that, if you apply Linus' patch to a MIPS tree, sth may fail.


> Ivan
