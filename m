Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Mar 2010 19:41:37 +0100 (CET)
Received: from apfelkorn.psychaos.be ([195.144.77.38]:53055 "EHLO
        apfelkorn.psychaos.be" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492419Ab0CZSle (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 26 Mar 2010 19:41:34 +0100
Received: from p2 by apfelkorn.psychaos.be with local (Exim 4.69)
        (envelope-from <p2@psychaos.be>)
        id 1NvETM-00065Q-RZ
        for linux-mips@linux-mips.org; Fri, 26 Mar 2010 20:41:32 +0200
Date:   Fri, 26 Mar 2010 20:41:32 +0200
From:   Peter 'p2' De Schrijver <p2@debian.org>
To:     linux-mips@linux-mips.org
Subject: movidis x16 hard lockup using 2.6.33
Message-ID: <20100326184132.GU2437@apfelkorn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Unexpected-Header: The spanish inquisition !
X-mate: Mate, mann gewohnt sich an alles
X-Paddo: Munch, Munch
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <p2@psychaos.be>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26320
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: p2@debian.org
Precedence: bulk
X-list: linux-mips

Hi,

Thanks to Jan Rovins and David Daney we linux 2.6.33 working fine with 1 additional
patch for the ethernet NICs. We are using this machine as a buildd. Unfortunately
we found out that building gcc 4.5 using all available 16 cores causes the machine
to lock up after about 6 hours of building. There is no output on the serial
console indicating a kernel panic or some malfunction. The machine is hosted in 
some data center so physical access is difficult.

Any insight welcome !

Thanks,

Peter.
