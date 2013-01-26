Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 26 Jan 2013 21:15:48 +0100 (CET)
Received: from filtteri1.pp.htv.fi ([213.243.153.184]:38461 "EHLO
        filtteri1.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6833509Ab3AZUPoAzE0d (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 26 Jan 2013 21:15:44 +0100
Received: from localhost (localhost [127.0.0.1])
        by filtteri1.pp.htv.fi (Postfix) with ESMTP id 0E94821B6FB;
        Sat, 26 Jan 2013 22:15:43 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp5.welho.com ([213.243.153.39])
        by localhost (filtteri1.pp.htv.fi [213.243.153.184]) (amavisd-new, port 10024)
        with ESMTP id wES81wfNH1Af; Sat, 26 Jan 2013 22:15:42 +0200 (EET)
Received: from musicnaut.iki.fi (cs181064211.pp.htv.fi [82.181.64.211])
        by smtp5.welho.com (Postfix) with SMTP id A4A345BC002;
        Sat, 26 Jan 2013 22:15:41 +0200 (EET)
Received: by musicnaut.iki.fi (sSMTP sendmail emulation); Sat, 26 Jan 2013 22:15:41 +0200
Date:   Sat, 26 Jan 2013 22:15:41 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-mips <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] mips: Move __virt_addr_valid() to a place for MIPS 64
Message-ID: <20130126201541.GF23053@blackmetal.musicnaut.iki.fi>
References: <1359137595.21576.246.camel@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1359137595.21576.246.camel@gandalf.local.home>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 35563
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Hi,

On Fri, Jan 25, 2013 at 01:13:15PM -0500, Steven Rostedt wrote:
> Commit d3ce88431892 "MIPS: Fix modpost error in modules attepting to use
> virt_addr_valid()" moved __virt_addr_valid() from a macro in a header
> file to a function in ioremap.c. But ioremap.c is only compiled for MIPS
> 32, and not for MIPS 64.
> 
> When compiling for my yeeloong2, which supposedly supports hibernation,
> which compiles kernel/power/snapshot.c which calls virt_addr_valid(), I
> got this error:

This has been reported also here:

	http://marc.info/?l=linux-mips&m=135788867604856&w=2

and here:

	http://marc.info/?l=linux-mips&m=135876719403187&w=2

It's pretty sad that MIPS has been pretty much broken during the whole
3.8-rc cycle. :-(

A.
