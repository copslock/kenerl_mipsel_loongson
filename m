Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Apr 2010 23:00:35 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:57149 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492275Ab0DZVAc (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 26 Apr 2010 23:00:32 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o3QL0N6q028582;
        Mon, 26 Apr 2010 22:00:23 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o3QL0NKh028580;
        Mon, 26 Apr 2010 22:00:23 +0100
Date:   Mon, 26 Apr 2010 22:00:23 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Cc:     linux-mips@linux-mips.org
Subject: Re: [RFC] net/sb1250: setup the pdevice within the soc code
Message-ID: <20100426210022.GE27656@linux-mips.org>
References: <20100426195229.GB22245@Chamillionaire.breakpoint.cc>
 <20100426202459.GD27656@linux-mips.org>
 <20100426204122.GA23697@Chamillionaire.breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100426204122.GA23697@Chamillionaire.breakpoint.cc>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26479
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Apr 26, 2010 at 10:41:22PM +0200, Sebastian Andrzej Siewior wrote:

> doing it within the driver does not look good.

And surely isn't how platform devices were meat to be used.

> Signed-off-by: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>

Go ahead:

Acked-by: Ralf Baechle <ralf@linux-mips.org>

Thanks!

  Ralf
