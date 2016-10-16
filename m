Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 16 Oct 2016 20:07:31 +0200 (CEST)
Received: from mail-out.m-online.net ([212.18.0.10]:46956 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992186AbcJPSHYbZde9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 16 Oct 2016 20:07:24 +0200
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 3sxq6w6MpNz3hklQ;
        Sun, 16 Oct 2016 20:07:20 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
        by mail.m-online.net (Postfix) with ESMTP id 3sxq6w3qjgzvkRc;
        Sun, 16 Oct 2016 20:07:20 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
        with ESMTP id DkpatXJst--J; Sun, 16 Oct 2016 20:07:18 +0200 (CEST)
X-Auth-Info: /PGoDo+6ikRkvaF8/UXXjmlXh1kpUpihPtFeNHv5mQFC2afOCxRb+jxMOhpggqso
Received: from igel.home (ppp-88-217-27-238.dynamic.mnet-online.de [88.217.27.238])
        (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Sun, 16 Oct 2016 20:07:18 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id 2673F2C294B; Sun, 16 Oct 2016 20:07:18 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>,
        Tejun Heo <tj@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Jiri Slaby <jslaby@suse.cz>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Ivan Delalande <colona@arista.com>,
        Thierry Reding <treding@nvidia.com>,
        Borislav Petkov <bp@suse.de>, Jan Kara <jack@suse.com>,
        Petr Mladek <pmladek@suse.com>, <linux-kernel@vger.kernel.org>,
        Joe Perches <joe@perches.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] console: Don't prefer first registered if DT specifies stdout-path
References: <20160809125010.14150-1-paul.burton@imgtec.com>
        <20160809151937.26118-1-paul.burton@imgtec.com>
X-Yow:  Is this my STOP??
Date:   Sun, 16 Oct 2016 20:07:18 +0200
In-Reply-To: <20160809151937.26118-1-paul.burton@imgtec.com> (Paul Burton's
        message of "Tue, 9 Aug 2016 16:19:37 +0100")
Message-ID: <87bmyk88x5.fsf@linux-m68k.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <whitebox@nefkom.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55437
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: schwab@linux-m68k.org
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

On Aug 09 2016, Paul Burton <paul.burton@imgtec.com> wrote:

> Fix this by not automatically preferring the first registered console if
> one is specified by the device tree. This allows consoles to be
> registered but not enabled, and once the driver for the console selected
> by stdout-path calls of_console_check() the driver will be added to the
> list of preferred consoles before any other console has been enabled.
> When that console is then registered via register_console() it will be
> enabled as expected.

This breaks the console on PowerMac.  There is no output and it panics
eventually.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
