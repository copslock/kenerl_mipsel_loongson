Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 01 Nov 2014 13:19:38 +0100 (CET)
Received: from filtteri6.pp.htv.fi ([213.243.153.189]:48394 "EHLO
        filtteri6.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012225AbaKAMTgktWD3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 1 Nov 2014 13:19:36 +0100
Received: from localhost (localhost [127.0.0.1])
        by filtteri6.pp.htv.fi (Postfix) with ESMTP id 22FFA56F1DF;
        Sat,  1 Nov 2014 14:19:36 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp5.welho.com ([213.243.153.39])
        by localhost (filtteri6.pp.htv.fi [213.243.153.189]) (amavisd-new, port 10024)
        with ESMTP id 1y9nsKm6+lcQ; Sat,  1 Nov 2014 14:19:29 +0200 (EET)
Received: from drone (91-145-91-118.bb.dnainternet.fi [91.145.91.118])
        by smtp5.welho.com (Postfix) with ESMTP id 8DE3B5BC003;
        Sat,  1 Nov 2014 14:19:29 +0200 (EET)
Date:   Sat, 1 Nov 2014 14:19:29 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Mike Frysinger <vapier@gentoo.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: asm/ptrace.h: include linux/types.h
Message-ID: <20141101121929.GA18404@drone.musicnaut.iki.fi>
References: <1414807159-6036-1-git-send-email-vapier@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1414807159-6036-1-git-send-email-vapier@gentoo.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43817
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
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

On Fri, Oct 31, 2014 at 09:59:19PM -0400, Mike Frysinger wrote:
> The header uses __u64 but doesn't include linux/types.h which breaks
> userspace apps that try to use asm/ptrace.h.  Like gdb:

Already fixed in the mainline, see cdb685ad44996e9a113a10002cb42d40ff29db99
(MIPS: ptrace.h: Add a missing include).

A.
