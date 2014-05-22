Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 May 2014 15:58:17 +0200 (CEST)
Received: from cpsmtpb-ews10.kpnxchange.com ([213.75.39.15]:53892 "EHLO
        cpsmtpb-ews10.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6817074AbaEVN6Oz1JqP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 22 May 2014 15:58:14 +0200
Received: from cpsps-ews04.kpnxchange.com ([10.94.84.171]) by cpsmtpb-ews10.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
         Thu, 22 May 2014 15:58:08 +0200
Received: from CPSMTPM-TLF104.kpnxchange.com ([195.121.3.7]) by cpsps-ews04.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
         Thu, 22 May 2014 15:58:08 +0200
Received: from [192.168.10.106] ([195.240.213.44]) by CPSMTPM-TLF104.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
         Thu, 22 May 2014 15:58:08 +0200
Message-ID: <1400767088.16407.14.camel@x220>
Subject: Re: [PATCH] MIPS: remove checks for CONFIG_SGI_IP35
From:   Paul Bolle <pebolle@tiscali.nl>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Date:   Thu, 22 May 2014 15:58:08 +0200
In-Reply-To: <20140522131243.GZ10287@linux-mips.org>
References: <1400584909.4912.35.camel@x220>
         <20140522131243.GZ10287@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4 (3.10.4-2.fc20) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 May 2014 13:58:08.0306 (UTC) FILETIME=[DC5C0920:01CF75C5]
X-RcptDomain: linux-mips.org
Return-Path: <pebolle@tiscali.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40244
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pebolle@tiscali.nl
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

On Thu, 2014-05-22 at 15:12 +0200, Ralf Baechle wrote:
> On Tue, May 20, 2014 at 01:21:49PM +0200, Paul Bolle wrote:
> 
> > Ever since (shortly before) v2.4.0 there have been checks for
> > CONFIG_SGI_IP35. But a Kconfig symbol SGI_IP35 was never added to the
> > tree. Remove these checks.
> > 
> > Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
> > ---
> > Untested.
> > 
> > For some reason CONFIG_SGI_IP35 was heavily used in arch/ia64 too.
> > Anyhow, IA64 has dropped that macro years ago.
> 
> The #ifdefs exist because these headers are originally from IRIX and the
> equivalent IRIX definitions were converted to Linux-style.  For the
> IA64 version keeping those ifdefs around obviously made no sense since -
> since IP35 (Origin 300/3000 series) is MIPS-based, so it was dropped
> again.

Nice to know. Thanks.

> There is some out-of-tree support for IP35 so I'd like to drop this
> patch.

Thanks for handling this (and the similar) patches so quickly. I
disagree with your decision here. But there are many, many issues like
this still left in the tree. So there's no point in making noise about
just this one Kconfig macro.

By the way, could you perhaps look at CONFIG_SYS_HAS_CPU_RM9000? It
seems the Kconfig entry for SYS_HAS_CPU_RM9000 is simply missing. But
the CPU support code is rather complicated and I stopped trying to
understand it after staring at it for way too long.

Thanks again,


Paul Bolle
