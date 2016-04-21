Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Apr 2016 16:59:45 +0200 (CEST)
Received: from hall.aurel32.net ([195.154.112.97]:49173 "EHLO hall.aurel32.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27026753AbcDUO7m5XiOz (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 21 Apr 2016 16:59:42 +0200
Received: from ohm.aurel32.net ([2001:bc8:30d7:111::1000] helo=ohm.local)
        by hall.aurel32.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <aurelien@aurel32.net>)
        id 1atG4z-0008QM-UP; Thu, 21 Apr 2016 16:59:42 +0200
Received: from aurel32 by ohm.local with local (Exim 4.87)
        (envelope-from <aurelien@aurel32.net>)
        id 1atG4z-0004EW-DF; Thu, 21 Apr 2016 16:59:41 +0200
Date:   Thu, 21 Apr 2016 16:59:41 +0200
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] MIPS: Allow emulation for unaligned [LS]DXC1 instructions
Message-ID: <20160421145941.GA13269@aurel32.net>
Mail-Followup-To: Paul Burton <paul.burton@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
References: <20160421101923.GA24852@aurel32.net>
 <1461237938-15228-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1461237938-15228-1-git-send-email-paul.burton@imgtec.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <aurelien@aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53174
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aurelien@aurel32.net
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

On 2016-04-21 12:25, Paul Burton wrote:
> If an address error exception occurs for a LDXC1 or SDXC1 instruction,
> within the cop1x opcode space, allow it to be passed through to the FPU
> emulator rather than resulting in a SIGILL. This causes LDXC1 & SDXC1 to
> be handled in a manner consistent with the more common LDC1 & SDC1
> instructions.
> 
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> Cc: Aurelien Jarno <aurelien@aurel32.net>
> ---
> Hi Aurelien,
> 
> Thanks for tracking that down. Does this simple patch fix your problem?
> 

Thanks for the quick patch. I confirm this fixes the issue, so you can
add a:

Tested-by: Aurelien Jarno <aurelien@aurel32.net>

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
