Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 Jan 2016 13:39:34 +0100 (CET)
Received: from hall.aurel32.net ([195.154.112.97]:46859 "EHLO hall.aurel32.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008721AbcAWMjdYpBSI (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 23 Jan 2016 13:39:33 +0100
Received: from [2001:bc8:30d7:121:1a5e:fff:fe16:6c] (helo=ohm.rr44.fr)
        by hall.aurel32.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84)
        (envelope-from <aurelien@aurel32.net>)
        id 1aMxTY-00065z-FF; Sat, 23 Jan 2016 13:39:32 +0100
Received: from aurel32 by ohm.rr44.fr with local (Exim 4.86)
        (envelope-from <aurelien@aurel32.net>)
        id 1aMxTY-0005eF-2W; Sat, 23 Jan 2016 13:39:32 +0100
Date:   Sat, 23 Jan 2016 13:39:32 +0100
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     "Maciej W. Rozycki" <macro@imgtec.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH 0/7] MIPS: math-emu: Branch delay slot emulation fixes
Message-ID: <20160123123932.GA522@aurel32.net>
Mail-Followup-To: "Maciej W. Rozycki" <macro@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
References: <alpine.DEB.2.00.1601220227590.5958@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1601220227590.5958@tp.orcam.me.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <aurelien@aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51315
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

Hi,

On 2016-01-22 05:20, Maciej W. Rozycki wrote:
> Hi,
> 
>  This small patch series addresses the following issues with branch delay 
> slot emulation in our floating-point emulator:
> 
> - NOP emulation sometimes causes SIGILL (Aurelien's bug),
> 
> - microMIPS emulation always goes astray,
> 
> - microMIPS emulation of ADDIUPC always returns the wrong result.
> 
> Also included are a bunch of code clean-ups and comment fixes.  See 
> individual patch descriptions for further details.
> 
>  I attempted to move clean-ups to the end, so that they do not interfere 
> with backporting, except with 2/7 which, if reordered, would require 3/7 
> to become ill-formatted.  I hope this is OK.  Changes 5-7/7 do not require 
> backporting.
> 
>  This series has been validated with a MIPS M5150 processor.

Thanks for working on that. I have tested this series, and I confirm
this fixes the issue and works well, though I haven't tested them on
a system with microMIPS support.

So for all the patches:
Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>

And for patch 1:
Tested-by: Aurelien Jarno <aurelien@aurel32.net>


Aurelien
-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
