Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Oct 2010 14:32:01 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:59587 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491027Ab0JKMb6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 11 Oct 2010 14:31:58 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.4/8.14.3) with ESMTP id o9BCVpNn027071;
        Mon, 11 Oct 2010 13:31:51 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.4/8.14.4/Submit) id o9BCVoKx027070;
        Mon, 11 Oct 2010 13:31:50 +0100
Date:   Mon, 11 Oct 2010 13:31:50 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Sergei Shtylyov <sshtylyov@mvista.com>
Cc:     David Daney <ddaney@caviumnetworks.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH 08/14] MIPS: Octeon: Scale Octeon2 clocks in
 octeon_init_cvmcount()
Message-ID: <20101011123150.GA27067@linux-mips.org>
References: <1286492633-26885-1-git-send-email-ddaney@caviumnetworks.com>
 <1286492633-26885-9-git-send-email-ddaney@caviumnetworks.com>
 <4CAEF427.9030608@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4CAEF427.9030608@mvista.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28019
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Oct 08, 2010 at 02:36:23PM +0400, Sergei Shtylyov wrote:

> >+	while (loops--) {
> >+		u64 ipd_clk_count = cvmx_read_csr(CVMX_IPD_CLK_COUNT);
> >+		if (rdiv != 0) {
> >+			ipd_clk_count = ipd_clk_count * rdiv;
> 
>    Why not:
> 
> 			ipd_clk_count *= rdiv;

Not sure if it really helps readability if the lhs of the assignment is only
a simple variable.  Either way, I changed it.

  Ralf
