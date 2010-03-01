Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Mar 2010 03:33:55 +0100 (CET)
Received: from 124x34x33x190.ap124.ftth.ucom.ne.jp ([124.34.33.190]:56179 "EHLO
        master.linux-sh.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1492103Ab0CACdw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 1 Mar 2010 03:33:52 +0100
Received: from localhost (unknown [127.0.0.1])
        by master.linux-sh.org (Postfix) with ESMTP id EE7CE63758;
        Mon,  1 Mar 2010 02:33:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at linux-sh.org
Received: from master.linux-sh.org ([127.0.0.1])
        by localhost (master.linux-sh.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id mxxupwluW9ax; Mon,  1 Mar 2010 11:33:16 +0900 (JST)
Received: by master.linux-sh.org (Postfix, from userid 500)
        id AAA8D6375A; Mon,  1 Mar 2010 11:33:16 +0900 (JST)
Date:   Mon, 1 Mar 2010 11:33:16 +0900
From:   Paul Mundt <lethal@linux-sh.org>
To:     Andrea Gelmini <andrea.gelmini@gelma.net>
Cc:     linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        linux-mips@linux-mips.org, linux-sh@vger.kernel.org
Subject: Re: [PATCH 42/66] arch/mips/lib/libgcc.h: Checkpatch cleanup
Message-ID: <20100301023316.GB23086@linux-sh.org>
References: <1267289508-31031-1-git-send-email-andrea.gelmini@gelma.net> <1267289508-31031-43-git-send-email-andrea.gelmini@gelma.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1267289508-31031-43-git-send-email-andrea.gelmini@gelma.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <lethal@linux-sh.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26074
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lethal@linux-sh.org
Precedence: bulk
X-list: linux-mips

On Sat, Feb 27, 2010 at 05:51:23PM +0100, Andrea Gelmini wrote:
> arch/mips/lib/libgcc.h:21: ERROR: open brace '{' following union go on the same line
> 
> Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
> ---
>  arch/mips/lib/libgcc.h |    3 +--
>  arch/sh/lib/libgcc.h   |    3 +--
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
I'll apply the sh part by itself, and I suppose Ralf will do the same for
MIPS. I'm a bit confused as to why these were lumped together when 65 out
of 66 oneliner patches made no use of ad-hoc grouping.
