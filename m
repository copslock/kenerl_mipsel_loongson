Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 May 2011 18:51:02 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:53312 "EHLO duck.linux-mips.net"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491077Ab1EQQvA (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 17 May 2011 18:51:00 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.3) with ESMTP id p4HGqgXS015853;
        Tue, 17 May 2011 17:52:42 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p4HGqfhI015852;
        Tue, 17 May 2011 17:52:41 +0100
Date:   Tue, 17 May 2011 17:52:41 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Kevin Cernekee <cernekee@gmail.com>
Cc:     Jian Peng <jipeng@broadcom.com>,
        David Daney <ddaney@caviumnetworks.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: patch to support topdown mmap allocation in MIPS
Message-ID: <20110517165241.GA15328@linux-mips.org>
References: <E18F441196CA634DB8E1F1C56A50A8743242B54C8A@IRVEXCHCCR01.corp.ad.broadcom.com>
 <4DD1BD72.2000408@caviumnetworks.com>
 <BANLkTikq04wuK=bz+Lieavmm3oDtoYWKxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BANLkTikq04wuK=bz+Lieavmm3oDtoYWKxg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 30069
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, May 16, 2011 at 06:27:17PM -0700, Kevin Cernekee wrote:

> >>  #define COLOUR_ALIGN(addr,pgoff)                              \
> >>        ((((addr) + shm_align_mask)&  ~shm_align_mask) +        \
> >>         (((pgoff)<<  PAGE_SHIFT)&  shm_align_mask))
> 
> I see COLOUR_ALIGN in arch/{arm,mips,sh,sparc} .  All sorts of
> embedded platforms have to worry about cache aliases nowadays.
> 
> Do you think this logic could be folded into the generic
> implementations in mm/mmap.c ?  Or is there something else inside our
> arch_get_unmapped_area* functions that's really, irreparably unique to
> MIPS?

There are always slightly odd architectures such as IA-64 where the page
size depends on the address or PARISC which in most of its cache handling
is about as straight forward as programming in Malbolge.

It should be easy enough to come up with a version however that fits most
architectures and everybody else can just override it just like the default
version of arch_get_unmapped_area.

  Ralf
