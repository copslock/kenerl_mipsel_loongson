Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Mar 2004 04:09:18 +0000 (GMT)
Received: from p508B7FA9.dip.t-dialin.net ([IPv6:::ffff:80.139.127.169]:63323
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8224773AbUCCEJQ>; Wed, 3 Mar 2004 04:09:16 +0000
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i2349Fex028721
	for <linux-mips@linux-mips.org>; Wed, 3 Mar 2004 05:09:15 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i2349FkB028718
	for linux-mips@linux-mips.org; Wed, 3 Mar 2004 05:09:15 +0100
Date: Wed, 3 Mar 2004 05:09:15 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: linux-mips@linux-mips.org
Subject: Re: CVS Update@-mips.org: linux
Message-ID: <20040303040915.GA28186@linux-mips.org>
References: <20040303034310Z8225905-9616+2989@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040303034310Z8225905-9616+2989@linux-mips.org>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4465
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Mar 03, 2004 at 03:43:05AM +0000, sjhill@linux-mips.org wrote:

> Modified files:
> 	arch/mips/kernel: signal.c 
> 
> Log message:
> 	Fix conditions to properly handle SA_ONSTACK for the 'sigaction' syscall
> 	when the stack to be switched to is invalid. All the other architectures
> 	do it properly except for MIPS...not anymore.

You missed half the other occurances.

  Ralf
