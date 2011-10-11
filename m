Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Oct 2011 01:17:52 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:56612 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491178Ab1JKXRt (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 12 Oct 2011 01:17:49 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id p9BNHaNs031856;
        Wed, 12 Oct 2011 00:17:36 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p9BNHZnH031853;
        Wed, 12 Oct 2011 00:17:35 +0100
Date:   Wed, 12 Oct 2011 00:17:35 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <david.daney@cavium.com>
Cc:     Joe Buehler <aspam@cox.net>, linux-mips@linux-mips.org
Subject: Re: using mprotect to write to .text
Message-ID: <20111011231735.GA19175@linux-mips.org>
References: <loom.20111010T215444-70@post.gmane.org>
 <4E9470A1.8020309@cavium.com>
 <4E947D8A.9090409@cox.net>
 <4E948593.6030604@cavium.com>
 <4E948C62.3000802@cox.net>
 <4E948E48.60205@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4E948E48.60205@cavium.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 31226
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 7656

On Tue, Oct 11, 2011 at 11:43:20AM -0700, David Daney wrote:

> 1) cacheflush() clears all hazards.

More by accident than design - when I wrote the cacheflush syscall and
manpage in 1995 the term execution hazard barrier didn't yet exist in
manuals though the CPU behaviour was documented in the R4000 / R4600
manual of those days as a small number of pipeline cycles required to
handle.  The return patch of the syscall was taking care of this
implicitly.  And today the required R2 hazard barrier is provided by
the ERET instruction of the return path, so everything is fine.

But it may be worth updating the man page.  A change every 15 years or
so isn't that bad ;-)

  Ralf
