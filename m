Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Jul 2010 19:02:16 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:46381 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492562Ab0GWRCJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 23 Jul 2010 19:02:09 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.4/8.14.3) with ESMTP id o6NH26Gw011471;
        Fri, 23 Jul 2010 18:02:06 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.4/8.14.4/Submit) id o6NH25H6011469;
        Fri, 23 Jul 2010 18:02:05 +0100
Date:   Fri, 23 Jul 2010 18:02:05 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Manuel Lauss <manuel.lauss@googlemail.com>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        Linux-serial <linux-serial@vger.kernel.org>
Subject: Re: [PATCH 2/2] serial: 8250: remove SERIAL_8250_AU1X00
Message-ID: <20100723170205.GB3923@linux-mips.org>
References: <1279223105-23816-1-git-send-email-manuel.lauss@googlemail.com>
 <1279223105-23816-2-git-send-email-manuel.lauss@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1279223105-23816-2-git-send-email-manuel.lauss@googlemail.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27442
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jul 15, 2010 at 09:45:05PM +0200, Manuel Lauss wrote:

Thanks, queued for 2.6.36.

It's probably harmless but there was a fairly large line offset in
arch/mips/alchemy/common/platform.c so you may want to check that what I
queued is ok.

  Ralf
