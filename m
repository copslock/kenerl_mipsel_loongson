Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Dec 2012 22:52:29 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:42196 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6823072Ab2L1Vw2IRDoq (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 28 Dec 2012 22:52:28 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id qBSLqQD5017704;
        Fri, 28 Dec 2012 22:52:26 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id qBSLqPNT017703;
        Fri, 28 Dec 2012 22:52:25 +0100
Date:   Fri, 28 Dec 2012 22:52:25 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Joshua Kinard <kumba@gentoo.org>
Cc:     Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: Unhandled kernel unaligned access on IP32 w/ network I/O &&
 3.7.1?
Message-ID: <20121228215225.GC6786@linux-mips.org>
References: <50DD1FB9.6060707@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50DD1FB9.6060707@gentoo.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 35347
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Thu, Dec 27, 2012 at 11:27:37PM -0500, Joshua Kinard wrote:

> Has anyone run into an unhandled kernel unaligned access under 3.7.1?  I've
> triggered it twice w/ network I/O on an SGI IP32 machine, however, the stack
> trace does not appear to be specific to any of IP32's own drivers.  3.6.7
> was very stable, and the two oopses I've triggered so far both happened
> under 3.7.1.
> 
> It looks like the culprit is in sk_stream_alloc_skb or tcp_sendmsg, however,
> I have little experience in the higher-level networking stack within Linux
> and wanted to see if anyone else has triggered this on other MIPS systems.
> 
> Seems to happen when I am logged in via SSH (on IPv6) and generating a burst
> of console output.
> 
> Unhandled kernel unaligned access[#3]:
> Cpu 0
> $ 0   : 0000000000000000 0000000000000010 0000000000000000 bfffff005671271c
> $ 4   : 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> $ 8   : 980000005c24e000 0000000000000000 980000005c24e000 00000000000000cc
> $12   : ffffffff9001fce1 000000001000001e fffffffffffff000 000000000000001f
> $16   : 980000005c00fa40 ffffffffde0300b8 ffffff0000000000 0000000000000005
> $20   : 000000007f875700 00000000000005a8 0000000000000008 0000000000000005
> $24   : 0000000000000001 00000000000003f0
> $28   : 980000005c00c000 980000005c00fa10 0000000000000000 ffffffff800059a0
> Hi    : 0000000007a11c93
> Lo    : b645a1cac992645e
> epc   : ffffffff8000b700 do_ade+0x1b0/0x480
>     Tainted: G      D
                     ^^^

This kernel has already oopsed before.  Which means this oops message is
pretty much worthless.

  Ralf
