Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Jun 2011 09:09:21 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:56214 "EHLO duck.linux-mips.net"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491817Ab1FXHJR (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 24 Jun 2011 09:09:17 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.3) with ESMTP id p5O79FD7003308;
        Fri, 24 Jun 2011 08:09:15 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p5O798Cg003281;
        Fri, 24 Jun 2011 08:09:08 +0100
Date:   Fri, 24 Jun 2011 08:09:08 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     naveen yadav <yad.naveen@gmail.com>
Cc:     Sergei Shtylyov <sshtylyov@mvista.com>,
        Christoph Hellwig <hch@lst.de>, linux-mips@linux-mips.org
Subject: Re: flush_kernel_vmap_range() invalidate_kernel_vmap_range() API not
 exists for MIPS
Message-ID: <20110624070908.GB32070@linux-mips.org>
References: <AANLkTimkh2QLvupu+62NGrKfqRb_gC7KLCAKkEoS9N9N@mail.gmail.com>
 <20110325172709.GC8483@linux-mips.org>
 <BANLkTimo6BEgDnTh+sPVR+MELyxiwJoFGw@mail.gmail.com>
 <20110616180250.GA13025@lst.de>
 <20110617152028.GA14107@linux-mips.org>
 <4DFCA2DD.9060707@mvista.com>
 <20110620095625.GA3227@linux-mips.org>
 <BANLkTi=HhABKb+FCtp5Z+W4i9hNvapoPLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BANLkTi=HhABKb+FCtp5Z+W4i9hNvapoPLQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 30502
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 20145

On Fri, Jun 24, 2011 at 10:36:13AM +0530, naveen yadav wrote:

> Dear Ralf and Sergei,
> 
> If we have L2 cache, then we need to invalidate them also ?

No.  S-cache and T-cache (rare, only the RM7000 has one) are physically
indexed.

  Ralf
