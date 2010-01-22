Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Jan 2010 20:29:26 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:59120 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1492381Ab0AVT3W (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 22 Jan 2010 20:29:22 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o0MEqvUw007031;
        Fri, 22 Jan 2010 15:52:59 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o0MEqu5b007029;
        Fri, 22 Jan 2010 15:52:56 +0100
Date:   Fri, 22 Jan 2010 15:52:56 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Alexander Clouter <alex@digriz.org.uk>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCHv2] MIPS: fix vmlinuz build for 32bit-only math shells
Message-ID: <20100122145256.GA5570@linux-mips.org>
References: <vs6k27-7b2.ln1@chipmunk.wormnet.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <vs6k27-7b2.ln1@chipmunk.wormnet.eu>
User-Agent: Mutt/1.5.20 (2009-08-17)
X-archive-position: 25630
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 14879

On Wed, Jan 20, 2010 at 08:50:07PM +0000, Alexander Clouter wrote:

> Counter to the documentation for the dash shell, it seems that on my
> x86_64 filth under Debian only does 32bit math.  As I have configured my

POSIX apparently specifies at least "long" type arithmetic for shells, so
if your dash indeed is a 64-bit binary it's in violation of POSIX.  What
does

  file $(which $SHELL)

say?

The dash binary on my Fedora 12 i386 seems to perform 64-bit arithmetic.

  Ralf
