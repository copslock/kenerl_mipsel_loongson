Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Nov 2010 16:17:33 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:43533 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491927Ab0KEPRa (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 5 Nov 2010 16:17:30 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.4/8.14.3) with ESMTP id oA5FHRWE006936;
        Fri, 5 Nov 2010 15:17:27 GMT
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.4/8.14.4/Submit) id oA5FHPAx006934;
        Fri, 5 Nov 2010 15:17:25 GMT
Date:   Fri, 5 Nov 2010 15:17:24 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org, Camm Maguire <camm@maguirefamily.org>,
        Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH 2/2] MIPS: Don't clobber personality bits in 32-bit
 sys_personality().
Message-ID: <20101105151724.GA6838@linux-mips.org>
References: <1288658588-26801-1-git-send-email-ddaney@caviumnetworks.com>
 <1288658588-26801-2-git-send-email-ddaney@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1288658588-26801-2-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28313
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

Applied, including some whitespace whitewash according to my personal
religion :)

Thanks,

  Ralf
