Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Nov 2009 21:03:18 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:42453 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492541AbZK3UDP (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 30 Nov 2009 21:03:15 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nAUK3OQk027138;
        Mon, 30 Nov 2009 20:03:25 GMT
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nAUK3KAZ027124;
        Mon, 30 Nov 2009 20:03:20 GMT
Date:   Mon, 30 Nov 2009 20:03:19 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Arnaldo Carvalho de Melo <acme@infradead.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH 1/1] MIPS: Wire up recvmmsg syscall
Message-ID: <20091130200319.GA26639@linux-mips.org>
References: <1259610615-23996-1-git-send-email-acme@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1259610615-23996-1-git-send-email-acme@infradead.org>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25210
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Nov 30, 2009 at 05:50:15PM -0200, Arnaldo Carvalho de Melo wrote:

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  arch/mips/include/asm/unistd.h |   15 +++++++++------
>  1 files changed, 9 insertions(+), 6 deletions(-)

Looks good.  Dave, wanna merge this through the netdev tree?

Acked-by: Ralf Baechle <ralf@linux-mips.org>

  Ralf
