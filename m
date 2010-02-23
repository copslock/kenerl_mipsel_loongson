Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Feb 2010 23:59:43 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:40844 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1492424Ab0BWW7k (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 23 Feb 2010 23:59:40 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o1NMxcKR027158;
        Tue, 23 Feb 2010 23:59:38 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o1NMxbR5027156;
        Tue, 23 Feb 2010 23:59:37 +0100
Date:   Tue, 23 Feb 2010 23:59:37 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Manuel Lauss <manuel.lauss@googlemail.com>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        Manuel Lauss <manuel.lauss@gmail.com>
Subject: Re: [PATCH -queue] MIPS: Alchemy: devboard PM needs to save CPLD
 registers.
Message-ID: <20100223225937.GC21949@linux-mips.org>
References: <1266947863-11738-1-git-send-email-manuel.lauss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1266947863-11738-1-git-send-email-manuel.lauss@gmail.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26008
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Feb 23, 2010 at 06:57:43PM +0100, Manuel Lauss wrote:

> Save/restore CPLD registers when doing suspend-to-ram:  fixes
> issues with harddisk and ethernet not working correctly when
> resuming on DB1200.

Thanks, queued for 2.6.34.

  Ralf
