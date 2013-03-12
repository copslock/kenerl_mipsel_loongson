Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Mar 2013 17:09:21 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:58509 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6827515Ab3CLQJS2KSkQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 12 Mar 2013 17:09:18 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r2CG9FZ1023203;
        Tue, 12 Mar 2013 17:09:15 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r2CG9Cj6023202;
        Tue, 12 Mar 2013 17:09:12 +0100
Date:   Tue, 12 Mar 2013 17:09:12 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Paul Bolle <pebolle@tiscali.nl>
Cc:     Jonas Gorski <jogo@openwrt.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org,
        Chris Dearman <chris.dearman@imgtec.com>
Subject: Re: [PATCH v2] MIPS: Get rid of CONFIG_CPU_HAS_LLSC again
Message-ID: <20130312160911.GA17165@linux-mips.org>
References: <1362477800.16460.69.camel@x61.thuisdomein>
 <CAOiHx=nzNVatEp0nyfZKU2p35+1kjrw6VsvZTP+QPJykWF3JAg@mail.gmail.com>
 <1362486020.16460.73.camel@x61.thuisdomein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1362486020.16460.73.camel@x61.thuisdomein>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 35883
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

On Tue, Mar 05, 2013 at 01:20:20PM +0100, Paul Bolle wrote:

> Commit f7ade3c168e4f437c11f57be012992bbb0e3075c ("MIPS: Get rid of
> CONFIG_CPU_HAS_LLSC") did what it promised to do. But since then that
> macro and its Kconfig symbol popped up again. Get rid of those again.
> 
> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
> ---
> 0) This version fixes an embarrassing dangling "#endif" spotted by
> Jonas. Thanks for that! Still untested.

Thanks, I've applied your v2 patch.

It's good that your cleanup doesn't change the behaviour of the existing
code - however the current behaviour doesn't seem to be the intended
behaviour so I'm going to commit a separate patch to define cpu_has_llsc
to 1.

  Ralf
