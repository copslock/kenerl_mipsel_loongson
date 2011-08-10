Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Aug 2011 23:25:11 +0200 (CEST)
Received: from lo.gmane.org ([80.91.229.12]:35276 "EHLO lo.gmane.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491864Ab1HJVZH (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 10 Aug 2011 23:25:07 +0200
Received: from list by lo.gmane.org with local (Exim 4.69)
        (envelope-from <sgi-linux-mips@m.gmane.org>)
        id 1QrGGw-00008F-12
        for linux-mips@linux-mips.org; Wed, 10 Aug 2011 23:25:06 +0200
Received: from indra.secretlabs.de ([78.46.94.148])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mips@linux-mips.org>; Wed, 10 Aug 2011 23:25:06 +0200
Received: from zecke by indra.secretlabs.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mips@linux-mips.org>; Wed, 10 Aug 2011 23:25:06 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-mips@linux-mips.org
From:   Holger Freyther <zecke@selfish.org>
Subject: Re: [RFC][PATCH] Implement =?utf-8?b?cGVyZl9jYWxsY2hhaW5fdXNlcg==?= for o32 ABI (on mipsel)
Date:   Wed, 10 Aug 2011 21:19:49 +0000 (UTC)
Message-ID: <loom.20110810T231842-192@post.gmane.org>
References: <4E423228.2080309@freyther.de> <4E42BEF0.1040502@cavium.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 78.46.94.148 (Mozilla/5.0 (X11; Linux i686) AppleWebKit/534.30 (KHTML, like Gecko) Ubuntu/11.04 Chromium/12.0.742.112 Chrome/12.0.742.112 Safari/534.30)
X-archive-position: 30847
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zecke@selfish.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 7920

David Daney <david.daney <at> cavium.com> writes:


> We probably could use some sort of backtrace code in the kernel, but 
> three seperate implementations are too many.
> 
> Also separating most of the unwinder into a separate file would be 
> preferable to mixing it into the perf counter driver.


Ah great, the oprofile support didn't exist when I was starting. Yes,
I will move the userspace unwinding into a common file and then build
the perf support on top of it.

holger
