Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Jul 2010 16:04:38 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:50757 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491943Ab0GZOEa (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 26 Jul 2010 16:04:30 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.4/8.14.3) with ESMTP id o6QE4KrX021676;
        Mon, 26 Jul 2010 15:04:21 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.4/8.14.4/Submit) id o6QE4IEb021673;
        Mon, 26 Jul 2010 15:04:18 +0100
Date:   Mon, 26 Jul 2010 15:04:17 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Kulikov Vasiliy <segooon@gmail.com>
Cc:     kernel-janitors@vger.kernel.org, Chris Dearman <chris@mips.com>,
        "Robert P. J. Day" <rpjday@crashcourse.ca>,
        Rusty Russell <rusty@rustcorp.com.au>,
        =?iso-8859-1?Q?Andr=E9?= Goddard Rosa <andre.goddard@gmail.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/11] arch/mips/kernel/smtc.c: formatting of pointers in
 printk()
Message-ID: <20100726140417.GA12084@linux-mips.org>
References: <1279130502-10777-1-git-send-email-segooon@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1279130502-10777-1-git-send-email-segooon@gmail.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27485
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jul 14, 2010 at 10:01:42PM +0400, Kulikov Vasiliy wrote:

> Use %p instead of %08x in printk().

Queued for 2.6.36, thanks!

Yes, %p is prefered here.  But your log message doesn't mention that your
patch also does a functional change, it drops the 0x prefix of the printed
value ...

  Ralf
