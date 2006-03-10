Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Mar 2006 16:30:04 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:3542 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133959AbWCJQ3z (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 10 Mar 2006 16:29:55 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.4/8.13.4) with ESMTP id k2AGcdLK014285;
	Fri, 10 Mar 2006 16:38:39 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k2AGcaWn014281;
	Fri, 10 Mar 2006 16:38:36 GMT
Date:	Fri, 10 Mar 2006 16:38:36 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Fuxin Zhang <fxzhang@ict.ac.cn>
Cc:	Thiemo Seufer <ths@networkno.de>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: tools to convert debian sarge to 16K page size
Message-ID: <20060310163836.GA13976@linux-mips.org>
References: <44113DC6.1010607@ict.ac.cn> <20060310131625.GA4821@networkno.de> <44118268.5030109@ict.ac.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <44118268.5030109@ict.ac.cn>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10781
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Mar 10, 2006 at 09:43:04PM +0800, Fuxin Zhang wrote:

> Thiemo Seufer 写道:
> > Can you provide information about the performance impact? That is,
> > what system(s) you use, and some basic benchmark numbers. Did you also
> > try 64k pages?
> The system is running debian sarge,with a mips like Chinese 4-way
> superscalar CPU and marvell 64240 system bridge, 256M sdram.Maybe
> related information: this CPU has 64K 4-way dcache/icache，so cache
> alias exists with 4K configuration.
> 
> Big page size helps a bit with at least computational programs, such as
> SPEC CPU2000 benchmarks. The attached jpg is a graph showing the results
> of some SPEC programs under different page sizes. But we have not
> benchmarked other workloads. 16K page size is used mainly to avoid cache
> alias, which caused us too much time.
> 
> Yes, with 64k more patches needed(some "short" field overflow?I don't
> remember the exact modifications,other guys did it)

There is more to large pages than just improved performance.  They'll
also save 75% memory for mem_map, will eleminate cache aliases in a
bulletproof way.  And will make allocation of memory larger than 4kB
reliable - this especially is a big bonus with ethernet jumboframes with
some NICs.

  Ralf
