Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Sep 2002 16:41:52 +0200 (CEST)
Received: from p508B798C.dip.t-dialin.net ([80.139.121.140]:10634 "EHLO
	dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S1122962AbSIPOlv>; Mon, 16 Sep 2002 16:41:51 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g8GEfbx02587;
	Mon, 16 Sep 2002 16:41:37 +0200
Date: Mon, 16 Sep 2002 16:41:37 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: atul srivastava <atulsrivastava9@rediffmail.com>
Cc: linux-mips@linux-mips.org
Subject: Re: reserved instruction exception on MIPS IDT 79S334A
Message-ID: <20020916164137.A2579@linux-mips.org>
References: <20020916131454.3464.qmail@webmail25.rediffmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020916131454.3464.qmail@webmail25.rediffmail.com>; from atulsrivastava9@rediffmail.com on Mon, Sep 16, 2002 at 01:14:54PM -0000
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 189
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Sep 16, 2002 at 01:14:54PM -0000, atul srivastava wrote:

> till now everything was alright...
> now enabled the support for NFS mounting of root filesystem 
> instead of Ramdisk , but running the
> image gave "Reserved Instruction Exception".
> 
> anybody has experienced this before ..?
> 
> do I need any flag in complier..?
> 
> on net i do find this type of exception description
> under topic "difference between IDT RC4640/RC64474/RC64574" ..but 
> how i take care of that..

I bet you're not properly flushing the caches before executing the unpacked
code.

  Ralf
