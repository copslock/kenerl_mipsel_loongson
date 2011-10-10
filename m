Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Oct 2011 12:00:12 +0200 (CEST)
Received: from lo.gmane.org ([80.91.229.12]:50606 "EHLO lo.gmane.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491167Ab1JKKAH (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 11 Oct 2011 12:00:07 +0200
Received: from list by lo.gmane.org with local (Exim 4.69)
        (envelope-from <sgi-linux-mips@m.gmane.org>)
        id 1RDZ82-0000CN-HK
        for linux-mips@linux-mips.org; Tue, 11 Oct 2011 12:00:06 +0200
Received: from ip68-100-141-95.dc.dc.cox.net ([68.100.141.95])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mips@linux-mips.org>; Tue, 11 Oct 2011 12:00:06 +0200
Received: from aspam by ip68-100-141-95.dc.dc.cox.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mips@linux-mips.org>; Tue, 11 Oct 2011 12:00:06 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-mips@linux-mips.org
From:   Joe Buehler <aspam@cox.net>
Subject: using mprotect to write to .text
Date:   Mon, 10 Oct 2011 20:02:39 +0000 (UTC)
Message-ID: <loom.20111010T215444-70@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 68.100.141.95 (Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.7; en-US; rv:1.9.2.23) Gecko/20110920 Firefox/3.6.23)
X-archive-position: 31219
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aspam@cox.net
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 7014

I intend to use mprotect in a running binary to allow it to modify its .text
section.  The detailed behavior of mprotect for a multithreaded program on SMP
hardware is not documented as far as I can tell.

Can I depend on the LINUX mprotect call to take care of icache flushing,
handling of hazards, etc.?  I am using Octeon CN5650 on 2.6.21.7 and 2.6.27.7 if
it matters.

Joe Buehler
