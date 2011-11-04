Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Nov 2011 18:43:25 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:43817 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1904134Ab1KDRnV (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 4 Nov 2011 18:43:21 +0100
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id pA4HhKxd019320;
        Fri, 4 Nov 2011 17:43:20 GMT
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id pA4HhJIT019318;
        Fri, 4 Nov 2011 17:43:19 GMT
Date:   Fri, 4 Nov 2011 17:43:19 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Manuel Lauss <manuel.lauss@googlemail.com>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: remove port limit in ioport_map
Message-ID: <20111104174319.GA18037@linux-mips.org>
References: <1320418191-22096-1-git-send-email-manuel.lauss@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1320418191-22096-1-git-send-email-manuel.lauss@googlemail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 31389
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 3853

On Fri, Nov 04, 2011 at 03:49:51PM +0100, Manuel Lauss wrote:

> Alchemy PCMCIA IO lies outside the 32bit address space and needs to
> be ioremapped to be accessible.  The resulting address is
> then fed as IO-port base to all PCMCIA client drivers attached
> to a particular socket.  pata_pcmcia does devm_ioport_map() on
> the port address, which returns errors because MIPS' ioport_map()
> implementation rejects incoming port addresses which are not
> within the 0..64k window.  Other embedded architectures don't
> bother with a check like this;  this patch brings MIPS in line
> and in turn makes pata_pcmcia work on all my Alchemy systems
> (and doesn't break PCI).

The reason for this had something to do with multiple PCI busses with
devices using I/O ports but I forgot what it was :).  Need to think about
this one.

  Ralf
