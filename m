Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Sep 2006 15:27:19 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:63450 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20038533AbWIYO1S (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 25 Sep 2006 15:27:18 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.7/8.13.7) with ESMTP id k8PES73F023497;
	Mon, 25 Sep 2006 15:28:07 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.7/8.13.7/Submit) id k8PES6xD023496;
	Mon, 25 Sep 2006 15:28:06 +0100
Date:	Mon, 25 Sep 2006 15:28:06 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH 1/3] fixed mtc0_tlbw_hazard
Message-ID: <20060925142805.GF20048@linux-mips.org>
References: <20060922010713.657f2861.yoichi_yuasa@tripeaks.co.jp> <4512BC2A.6040003@dev.rtsoft.ru> <20060922014142.2a1985c1.yoichi_yuasa@tripeaks.co.jp> <4512C55A.6070206@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4512C55A.6070206@ru.mvista.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12654
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Sep 21, 2006 at 09:01:14PM +0400, Sergei Shtylyov wrote:

>    I fail to see what was changed WRT SB1 CPUs by the suspected patch. 
>    Though wait... the previous version was inconsistent, using the different 
> barrier definitions for C and assembly (nops in the former, and branch in 
> the latter). But since the assembly version was not really used, it 
> couldn't break anything... :-/
> 
>    Anyway, shouldn't ssnop's be used for SB1 instead? CPU has quad-issue 
> pipeline, hasn't it?

SB1 is almost fully interlocked so the right thing to do is doing nothing.

  Ralf
