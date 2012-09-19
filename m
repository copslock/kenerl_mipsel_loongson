Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Sep 2012 16:55:14 +0200 (CEST)
Received: from plane.gmane.org ([80.91.229.3]:37709 "EHLO plane.gmane.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903291Ab2ISOzC (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 19 Sep 2012 16:55:02 +0200
Received: from list by plane.gmane.org with local (Exim 4.69)
        (envelope-from <sgi-linux-mips@m.gmane.org>)
        id 1TELg8-0007e7-Gd
        for linux-mips@linux-mips.org; Wed, 19 Sep 2012 16:55:04 +0200
Received: from sestofw01.enea.se ([192.36.1.252])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mips@linux-mips.org>; Wed, 19 Sep 2012 16:55:04 +0200
Received: from ola.liljedahl by sestofw01.enea.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mips@linux-mips.org>; Wed, 19 Sep 2012 16:55:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-mips@linux-mips.org
From:   Ola Liljedahl <ola.liljedahl@gmail.com>
Subject: Re: [PATCH 1/1] Pendantic stack backtrace code
Date:   Wed, 19 Sep 2012 14:52:02 +0000 (UTC)
Message-ID: <loom.20120919T164755-469@post.gmane.org>
References: <20110706233614.GA19332@dvomlehn-lnx2.corp.sa.net> <20110802155759.GA891@linux-mips.org> <20110805020242.GA23916@dvomlehn-lnx2.corp.sa.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 192.36.1.252 (Mozilla/5.0 (Windows NT 5.1; rv:15.0) Gecko/20100101 Firefox/15.0)
X-archive-position: 34530
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ola.liljedahl@gmail.com
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

I have also written a back-trace utility for MIPS, for Enea's "OSE" realtime OS.
Again, it was the sentences in "See MIPS Run" which inspired me (well the whole
book is full of inspiration, a great read). My twist to the solution is that my
design always scans instructions in the *forward* direction (from the specified
PC), trying to find the end of the function. In the process of doing so,
unconditional jumps are followed and conditional branches are followed both
ways. There is however no support for tracing over signal handlers since in the
OSE error handler, we will get the user space register dump for most exceptions
and can start back-tracing there.

The code is available here: https://dl.dropbox.com/u/45566557/mips_backtrace.c

Improvement suggestions and other comments are welcome.

-- Ola Liljedahl
