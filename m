Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Oct 2010 15:44:03 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:45897 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491087Ab0JKNn5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 11 Oct 2010 15:43:57 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.4/8.14.3) with ESMTP id o9BDhtnA031423;
        Mon, 11 Oct 2010 14:43:55 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.4/8.14.4/Submit) id o9BDhsmw031421;
        Mon, 11 Oct 2010 14:43:54 +0100
Date:   Mon, 11 Oct 2010 14:43:54 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org, Jeff Garzik <jgarzik@pobox.com>,
        linux-ide@vger.kernel.org
Subject: Re: [PATCH 12/14] ata: pata_octeon_cf: Use I/O clock rate for timing
 calculations.
Message-ID: <20101011134354.GI30695@linux-mips.org>
References: <1286492633-26885-1-git-send-email-ddaney@caviumnetworks.com>
 <1286492633-26885-13-git-send-email-ddaney@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1286492633-26885-13-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28034
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Oct 07, 2010 at 04:03:51PM -0700, David Daney wrote:

> The creation of the I/O clock domain requires some adjustments.  Since
> the CF bus timing logic is clocked by the I/O clock, use its rate for
> delay calculations.
> 
> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
> Cc: Jeff Garzik <jgarzik@pobox.com>
> Cc: linux-ide@vger.kernel.org

Haven't seen any ack yet but I assume due to the dependencies on other
MIPS patches it'll be ok if I merge this through the MIPS tree, so I
queued it for 2.6.37.

Thanks!

  Ralf
