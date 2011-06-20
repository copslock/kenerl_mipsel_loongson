Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Jun 2011 11:56:38 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:36857 "EHLO duck.linux-mips.net"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491035Ab1FTJ4a (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 20 Jun 2011 11:56:30 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.3) with ESMTP id p5K9uREV004899;
        Mon, 20 Jun 2011 10:56:28 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p5K9uQNU004895;
        Mon, 20 Jun 2011 10:56:26 +0100
Date:   Mon, 20 Jun 2011 10:56:26 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Sergei Shtylyov <sshtylyov@mvista.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        naveen yadav <yad.naveen@gmail.com>, linux-mips@linux-mips.org
Subject: Re: flush_kernel_vmap_range() invalidate_kernel_vmap_range() API not
 exists for MIPS
Message-ID: <20110620095625.GA3227@linux-mips.org>
References: <AANLkTimkh2QLvupu+62NGrKfqRb_gC7KLCAKkEoS9N9N@mail.gmail.com>
 <20110325172709.GC8483@linux-mips.org>
 <BANLkTimo6BEgDnTh+sPVR+MELyxiwJoFGw@mail.gmail.com>
 <20110616180250.GA13025@lst.de>
 <20110617152028.GA14107@linux-mips.org>
 <4DFCA2DD.9060707@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4DFCA2DD.9060707@mvista.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 30452
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 15990

On Sat, Jun 18, 2011 at 05:06:37PM +0400, Sergei Shtylyov wrote:

> >+static inline void flush_kernel_vmap_range(void *vaddr, int size)
> >+{
> >+	if (cpu_has_dc_aliases)
> >+		__flush_kernel_vmap_range((unsigned long) vaddr, size);
> >+}
> >+
> >+static inline void invalidate_kernel_vmap_range(void *vaddr, int size)
> >+{
> >+	if (cpu_has_dc_aliases)
> >+		__flush_kernel_vmap_range((unsigned long) vaddr, size);
> 
>    Not __invalidate_kernel_vmap_range()?

No, for the moment both just do a writeback + invalidate.  I may change
that for something more efficient later once I understand the consequences
of this.

  Ralf
