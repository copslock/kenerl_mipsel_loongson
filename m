Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Sep 2010 10:55:31 +0200 (CEST)
Received: from verein.lst.de ([213.95.11.210]:58487 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491083Ab0ICIz1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 3 Sep 2010 10:55:27 +0200
Received: from verein.lst.de (localhost [127.0.0.1])
        by verein.lst.de (8.12.3/8.12.3/Debian-7.1) with ESMTP id o838tLWY000342
        (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
        Fri, 3 Sep 2010 10:55:21 +0200
Received: (from hch@localhost)
        by verein.lst.de (8.12.3/8.12.3/Debian-7.2) id o838tL7w000341;
        Fri, 3 Sep 2010 10:55:21 +0200
Date:   Fri, 3 Sep 2010 10:55:21 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Arnaud Patard <apatard@mandriva.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Bernhard Walle <walle@corscience.de>,
        linux-mips@linux-mips.org, ralf@linux-mips.org,
        ddaney@caviumnetworks.com, akpm@linux-foundation.org,
        ebiederm@xmission.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: N32: Fix getdents64 syscall for n32
Message-ID: <20100903085521.GA304@lst.de>
References: <1283501734-6532-1-git-send-email-walle@corscience.de> <20100903084213.GA32339@lst.de> <m3pqwvb438.fsf@anduin.mandriva.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3pqwvb438.fsf@anduin.mandriva.com>
User-Agent: Mutt/1.3.28i
X-Scanned-By: MIMEDefang 2.39
X-archive-position: 27714
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hch@lst.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 2411

On Fri, Sep 03, 2010 at 10:53:31AM +0200, Arnaud Patard wrote:
> Christoph Hellwig <hch@lst.de> writes:
> 
> Hi,
> 
> > I'm not sure why people suddenly started Ccing me on utterly random
> > patches, but could you guys please bloody stop it?  Thanks!
> 
> I guess the explanation is the one below :
> 
> $ ./scripts/get_maintainer.pl -f arch/mips/kernel/scall64-n32.S

I'm certainly not the maintainer of it, nor anything near it.  Whoever
wrote such a stupid script really needs to be beaten up seriously.
