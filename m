Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 27 Nov 2010 20:24:13 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:49627 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492340Ab0K0TYK (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 27 Nov 2010 20:24:10 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.4/8.14.3) with ESMTP id oARJO88X007209;
        Sat, 27 Nov 2010 19:24:08 GMT
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.4/8.14.4/Submit) id oARJO7dY007207;
        Sat, 27 Nov 2010 19:24:07 GMT
Date:   Sat, 27 Nov 2010 19:24:07 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     linux-mips@linux-mips.org, mb@bu3sch.de, netdev@vger.kernel.org
Subject: Re: [PATCH RESEND] ssb: fix nvram_get on bcm47xx platform
Message-ID: <20101127192407.GA7175@linux-mips.org>
References: <1290882392-28327-1-git-send-email-hauke@hauke-m.de>
 <20101127191138.GB4867@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20101127191138.GB4867@linux-mips.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28551
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Nov 27, 2010 at 07:11:38PM +0000, Ralf Baechle wrote:

> On Sat, Nov 27, 2010 at 07:26:32PM +0100, Hauke Mehrtens wrote:
> > Date:   Sat, 27 Nov 2010 19:26:32 +0100
> > From: Hauke Mehrtens <hauke@hauke-m.de>
> > To: ralf@linux-mips.org, linux-mips@linux-mips.org
> > Cc: mb@bu3sch.de, netdev@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
> > Subject: [PATCH RESEND] ssb: fix nvram_get on bcm47xx platform
> 
> This has been applied in August, so bitbucket.

Sorry - there was a different patch of similar subject which I accepted.
Will feed this one upstream after I seen an ACK from one of the SSB/BCM47xx
folks.

  Ralf
