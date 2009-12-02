Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Dec 2009 20:22:53 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:53891 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1493744AbZLBTWt (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 2 Dec 2009 20:22:49 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nB2JMj0h013491;
        Wed, 2 Dec 2009 19:22:45 GMT
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nB2JMi2J013488;
        Wed, 2 Dec 2009 19:22:44 GMT
Date:   Wed, 2 Dec 2009 19:22:43 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Martin Michlmayr <tbm@cyrius.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [RFC] [PATCH] Disable EMBEDDED on MIPS
Message-ID: <20091202192243.GA3485@linux-mips.org>
References: <20091119164632.GA15279@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20091119164632.GA15279@deprecation.cyrius.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25282
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Nov 19, 2009 at 04:46:32PM +0000, Martin Michlmayr wrote:

> There's no reason for MIPS to select EMBEDDED.  In fact, EMBEDDED
> makes MIPS more awkward to deal with because it makes it different
> to the majority of architectures for no good reason.

Historically disabling EMBEDDED had hid essential options for many MIPS
platforms such as serial console and forced crap like VGA support
or power managment enabled for platforms where those don't make any sense.

The name of the option is also _very_ missleading so many users don't
select it even where is was required for a functioning kernel.

After reviewing the current Kconfig files it seems this is no longer the
case, so I'll queue this patch for 2.6.33.

  Ralf
