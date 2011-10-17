Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Oct 2011 16:57:10 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:35738 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491031Ab1JQO5F (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 17 Oct 2011 16:57:05 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id p9HEv3G9026072;
        Mon, 17 Oct 2011 15:57:03 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p9HEv3uu026071;
        Mon, 17 Oct 2011 15:57:03 +0100
Date:   Mon, 17 Oct 2011 15:57:03 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     loody <miloody@gmail.com>
Cc:     Linux MIPS Mailing List <linux-mips@linux-mips.org>
Subject: Re: some questions about translation lookaside buffer
Message-ID: <20111017145702.GC10290@linux-mips.org>
References: <CANudz+sswjeOP-JZfJnp5c+J0HAmY2OgCVJkdq9WK51ackb8vw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANudz+sswjeOP-JZfJnp5c+J0HAmY2OgCVJkdq9WK51ackb8vw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 31245
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 11977

On Mon, Oct 17, 2011 at 07:36:11PM +0800, loody wrote:

> Dear all:
> I have some questions about local_flush_tlb_one.
> 1. what will happen if I use local_flush_tlb_one to flush a page that
> doesn't exist in translation lookaside buffer entries.
> 
> The index return by read_c0_index(), should be negative.
> but this function seems not handle the case that idx < 0.
> 
> 2. as I know, translation lookaside buffer is a place to keep record
> the memory mapping, it doesn't like cache have place to store the
> data.
>     a. If the entry is cacheable, what we only to do is flush the cache?
>     b. if the entry is uncached, there is nothing to do?
> if above b is correct, what will happen if we have an entry that is
> uncached and dirty?

If c0_index contains a value < 0 (or rather one with bit 31 set) then
there is nothing that needs to be flushed.

Note that MIPS D-cache (I-caches don't get written back so are not of
concern) are tagged with a physical address so cache handling is no
consideration for local_flush_tlb_one or any of the other TLB flush
functions.

  Ralf
