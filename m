Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Dec 2010 02:38:46 +0100 (CET)
Received: from p57B0EBBC.dip.t-dialin.net ([87.176.235.188]:36974 "EHLO
        h5.dl5rb.org.uk" rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org
        with ESMTP id S1491024Ab0L2Bin (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Dec 2010 02:38:43 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.4/8.14.3) with ESMTP id oBT1ca7c015613;
        Wed, 29 Dec 2010 02:38:37 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.4/8.14.4/Submit) id oBT1cXnJ015604;
        Wed, 29 Dec 2010 02:38:33 +0100
Date:   Wed, 29 Dec 2010 02:38:33 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org, Steven Rostedt <rostedt@goodmis.org>,
        Wu Zhangjin <wuzhangjin@gmail.com>
Subject: Re: [PATCH] MIPS: Mask jump target in ftrace_dyn_arch_init_insns().
Message-ID: <20101229013833.GA6271@linux-mips.org>
References: <1293571297-14337-1-git-send-email-ddaney@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1293571297-14337-1-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28763
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Dec 28, 2010 at 01:21:37PM -0800, David Daney wrote:

> The current code is abusing the uasm interface by passing jump target
> addresses with high bits set.  Mask the addresses to avoid annoying
> messages at boot time.
> 
> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Wu Zhangjin <wuzhangjin@gmail.com>

Thanks, applied.

  Ralf
