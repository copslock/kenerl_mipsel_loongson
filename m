Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Apr 2010 15:32:38 +0200 (CEST)
Received: from alius.ayous.org ([78.46.213.165]:42383 "EHLO alius.ayous.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491777Ab0DBNcd (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 2 Apr 2010 15:32:33 +0200
Received: from eos.turmzimmer.net ([2001:a60:f006:aba::1])
        by alius.turmzimmer.net with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.69)
        (envelope-from <aba@not.so.argh.org>)
        id 1Nxgz8-0002h4-Ih; Fri, 02 Apr 2010 13:32:31 +0000
Received: from aba by eos.turmzimmer.net with local (Exim 4.69)
        (envelope-from <aba@not.so.argh.org>)
        id 1Nxgz2-0004y2-J4; Fri, 02 Apr 2010 15:32:24 +0200
Date:   Fri, 2 Apr 2010 15:32:24 +0200
From:   Andreas Barth <aba@not.so.argh.org>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     Peter 'p2' De Schrijver <p2@debian.org>, linux-mips@linux-mips.org
Subject: Re: movidis x16 hard lockup using 2.6.33
Message-ID: <20100402133224.GR27216@mails.so.argh.org>
References: <20100326184132.GU2437@apfelkorn> <4BAD03A5.9070701@caviumnetworks.com> <20100327230744.GG27216@mails.so.argh.org> <4BB0DB2A.9080405@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4BB0DB2A.9080405@caviumnetworks.com>
X-Editor: Vim http://www.vim.org/
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <aba@not.so.argh.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26341
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aba@not.so.argh.org
Precedence: bulk
X-list: linux-mips

* David Daney (ddaney@caviumnetworks.com) [100329 18:54]:
> [...]

I need to admit I'm sorry but I can't read enough from the log file.
Serial console output is http://alius.ayous.org/~aba/screenlog.0

This kernel is with the NMI-handler but without the "don't reboot"
patch:
Linux version 2.6.34-rc2-dsa-octeon (aba@gabrielli) (gcc version 4.4.3
(Debian 4.4.3-3) ) #5 SMP Sat Mar 27 10:16:03 UTC 2010

and this one has NMI-handler plus the small loop:
Linux version 2.6.34-rc2-dsa-octeon (aba@gabrielli) (gcc version 4.4.3
(Debian 4.4.3-3) ) #6 SMP Mon Mar 29 22:23:26 UTC 2010


Unfortunatly it looks like we get neither the information nor don't
reboot, but adding the NMU handler changed behaviour from "machine
freezes" to "machine reboots".


Thanks for helping us so much.



Andi
