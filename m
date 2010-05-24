Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 May 2010 03:08:31 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:47861 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491999Ab0EXBI2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 24 May 2010 03:08:28 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o4O18QFN010455;
        Mon, 24 May 2010 02:08:26 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o4O18Q94010453;
        Mon, 24 May 2010 02:08:26 +0100
Date:   Mon, 24 May 2010 02:08:26 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Andrea Gelmini <andrea.gelmini@gelma.net>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH 171/199] arch/mips/sgi-ip27/ip27-klconfig.c: Checkpatch
 cleanup
Message-ID: <20100524010826.GK8522@linux-mips.org>
References: <1274644332-23964-1-git-send-email-andrea.gelmini@gelma.net>
 <1274644332-23964-11-git-send-email-andrea.gelmini@gelma.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1274644332-23964-11-git-send-email-andrea.gelmini@gelma.net>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26828
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

Queued for 2.6.36.  And just like for all the other patches of this series
which I handle - splitting this patches series into subatomic particles
is quite annoying for us maintainers - this series really should be
consolidated into far fewer patches.

Thanks,

  Ralf
