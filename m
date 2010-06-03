Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Jun 2010 13:39:59 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:42870 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491042Ab0FCLjz (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 3 Jun 2010 13:39:55 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o53BdrtU023251;
        Thu, 3 Jun 2010 12:39:53 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o53BdqsN023249;
        Thu, 3 Jun 2010 12:39:52 +0100
Date:   Thu, 3 Jun 2010 12:39:52 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
Cc:     Wu Zhangjin <wuzhangjin@gmail.com>,
        linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH -queue] MIPS: Move Loongson Makefile parts to their own
 Platform file (cont.)
Message-ID: <20100603113952.GA23033@linux-mips.org>
References: <95654e45e2f02133c6334fb147d3e28ef94f2bb0.1275439768.git.wuzhangjin@gmail.com>
 <AANLkTikKBasnKuS2Ym6fS8Wr17obMnFWSmA2mJxDIrjU@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AANLkTikKBasnKuS2Ym6fS8Wr17obMnFWSmA2mJxDIrjU@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
X-archive-position: 27043
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 2317

On Thu, Jun 03, 2010 at 02:10:26PM +0300, Dmitri Vorobiev wrote:

> > Hi, Ralf
> >
> > I have fogotten to remove the -Werror in the Makefiles under loongson/
> 
> I'm just curious: why would anyone want to remove -Werror? It's very
> useful in most cases, IMO.

arch/mips/Kbuild enables -Werror for all platforms.

  Ralf
