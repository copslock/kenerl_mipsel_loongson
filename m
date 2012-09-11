Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Sep 2012 02:29:58 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:37920 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903487Ab2IKA3w (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 11 Sep 2012 02:29:52 +0200
Date:   Tue, 11 Sep 2012 01:29:52 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Rich Felker <dalias@aerifal.cx>, Ralf Baechle <ralf@linux-mips.org>
cc:     linux-mips@linux-mips.org
Subject: Re: Is r25 saved across syscalls?
In-Reply-To: <20120910172248.GN27715@brightrain.aerifal.cx>
Message-ID: <alpine.LFD.2.00.1209110059580.8926@eddie.linux-mips.org>
References: <20120909193008.GA15157@brightrain.aerifal.cx> <20120910170830.GB24448@linux-mips.org> <20120910172248.GN27715@brightrain.aerifal.cx>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-archive-position: 34459
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Mon, 10 Sep 2012, Rich Felker wrote:

> As for my problem, I can use r7 as the temp ("move $2,$7 ; syscall")
> for syscalls with 3 or fewer args, but for the 4-arg syscall, $7 is
> occupied by an argument, and I'd need to spill the syscall number to
> the stack to be able to restore it if $25 is not available...

 If performance or some other factors require you to avoid spilling the 
syscall number to the stack or other readily-accessible (e.g. GP-relative) 
memory and the number is not a constant you could load with LI, then you 
can always store it in a call-saved register, one of $s0-$s8, that are 
guaranteed by the syscall ABI to be preserved across.

 Relying on any call-clobbered registers, including $7 to be preserved 
across a syscall is risky, to say the least, as this is not guaranteed by 
the syscall ABI.  I do wonder however why we have these instructions to 
save/restore $25 in SAVE_SOME/RESTORE_SOME.  This dates back to 2.4 at the 
very least.

 Ralf, any insights?

  Maciej
