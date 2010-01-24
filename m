Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 24 Jan 2010 01:23:57 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:51228 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1492774Ab0AXAXx (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 24 Jan 2010 01:23:53 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o0O0NsIh017700;
        Sun, 24 Jan 2010 01:23:55 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o0O0NqlE017694;
        Sun, 24 Jan 2010 01:23:52 +0100
Date:   Sun, 24 Jan 2010 01:23:52 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Roel Kluin <roel.kluin@gmail.com>
Cc:     linux-mips@linux-mips.org,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MIPS: cleanup switches with cases that can be merged
Message-ID: <20100124002352.GB3251@linux-mips.org>
References: <4B56475F.8070608@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4B56475F.8070608@gmail.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
X-archive-position: 25644
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 15516

On Wed, Jan 20, 2010 at 12:59:27AM +0100, Roel Kluin wrote:

> I did a search for switch statements with cases that can be merged, but maybe
> some were not intended?
> ---------------->8------------------------------------------8<-----------------
> In these cases the same code was executed.

Queued for 2.6.34.

  Ralf
