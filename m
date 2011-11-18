Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Nov 2011 19:28:39 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:58930 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1904133Ab1KRS2g (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 18 Nov 2011 19:28:36 +0100
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id pAIISY79021896;
        Fri, 18 Nov 2011 18:28:34 GMT
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id pAIISYaF021893;
        Fri, 18 Nov 2011 18:28:34 GMT
Date:   Fri, 18 Nov 2011 18:28:34 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Maxime Bizon <mbizon@freebox.fr>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH v2 01/11] MIPS: BCM63XX: set default pci cache line size.
Message-ID: <20111118182833.GA21848@linux-mips.org>
References: <1320430175-13725-1-git-send-email-mbizon@freebox.fr>
 <1320430175-13725-2-git-send-email-mbizon@freebox.fr>
 <20111115195438.GF26141@linux-mips.org>
 <1321639936.32730.33.camel@sakura.staff.proxad.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1321639936.32730.33.camel@sakura.staff.proxad.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 31802
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 15774

On Fri, Nov 18, 2011 at 07:12:16PM +0100, Maxime Bizon wrote:

> > 
> > Presumably because the CPU cache line size is 16 bytes?  On MIPS we
> > don't set pci_dfl_cache_line_size; a patch (only compile tested) to
> > pick a sane default is below.
> > 
> > Does this work for you? 
> 
> [    0.192000] PCI: CLS 0 bytes, default 16
> 
> yes it does

Excellent, thanks for testing.  So I also queued this one for 3.3.

  Ralf
