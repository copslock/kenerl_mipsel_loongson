Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Aug 2017 19:32:08 +0200 (CEST)
Received: from shards.monkeyblade.net ([184.105.139.130]:57318 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23995041AbdHURb7tuTyW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 21 Aug 2017 19:31:59 +0200
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id F0746125BAD2D;
        Mon, 21 Aug 2017 10:31:52 -0700 (PDT)
Date:   Mon, 21 Aug 2017 10:31:52 -0700 (PDT)
Message-Id: <20170821.103152.1302932686530323238.davem@davemloft.net>
To:     david.daney@cavium.com
Cc:     ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        ralf@linux-mips.org
Subject: Re: [PATCH 0/3] MIPS,bpf: Improvements for MIPS eBPF JIT
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20170818234033.5990-1-david.daney@cavium.com>
References: <20170818234033.5990-1-david.daney@cavium.com>
X-Mailer: Mew version 6.7 on Emacs 25.2 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 21 Aug 2017 10:31:53 -0700 (PDT)
Return-Path: <davem@davemloft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59737
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: davem@davemloft.net
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

From: David Daney <david.daney@cavium.com>
Date: Fri, 18 Aug 2017 16:40:30 -0700

> Here are several improvements and bug fixes for the MIPS eBPF JIT.
> 
> The main change is the addition of support for JLT, JLE, JSLT and JSLE
> ops, that were recently added.
> 
> Also fix WARN output when used with preemptable kernel, and a small
> cleanup/optimization in the use of BPF_OP(insn->code).
> 
> I suggest that the whole thing go via the BPF/net-next path as there
> are dependencies on code that is not yet merged to Linus' tree.
> 
> Still pending are changes to reduce stack usage when the verifier can
> determine the maximum stack size.

Applied to net-next.
