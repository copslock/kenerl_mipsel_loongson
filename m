Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 26 Jan 2013 22:01:50 +0100 (CET)
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:14145 "EHLO
        hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6833509Ab3AZVBsproVk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 26 Jan 2013 22:01:48 +0100
X-Authority-Analysis: v=2.0 cv=QcjkT7nv c=1 sm=0 a=rXTBtCOcEpjy1lPqhTCpEQ==:17 a=mNMOxpOpBa8A:10 a=XFXzPjxE9FUA:10 a=5SG0PmZfjMsA:10 a=Q9fys5e9bTEA:10 a=meVymXHHAAAA:8 a=Wg9lMJmbmcwA:10 a=gu6fZOg2AAAA:8 a=qvmll_tEmR6I0gQtaioA:9 a=PUjeQqilurYA:10 a=GC8p-B92FUEA:10 a=NWVoK91CQyQA:10 a=rXTBtCOcEpjy1lPqhTCpEQ==:117
X-Cloudmark-Score: 0
X-Authenticated-User: 
X-Originating-IP: 74.67.115.198
Received: from [74.67.115.198] ([74.67.115.198:53144] helo=[192.168.23.10])
        by hrndva-oedge03.mail.rr.com (envelope-from <rostedt@goodmis.org>)
        (ecelerity 2.2.3.46 r()) with ESMTP
        id 53/98-06396-83444015; Sat, 26 Jan 2013 21:01:45 +0000
Message-ID: <1359234104.17639.2.camel@gandalf.local.home>
Subject: Re: [PATCH] mips: Move __virt_addr_valid() to a place for MIPS 64
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-mips <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Date:   Sat, 26 Jan 2013 16:01:44 -0500
In-Reply-To: <20130126201541.GF23053@blackmetal.musicnaut.iki.fi>
References: <1359137595.21576.246.camel@gandalf.local.home>
         <20130126201541.GF23053@blackmetal.musicnaut.iki.fi>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.4.4-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-archive-position: 35564
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rostedt@goodmis.org
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

On Sat, 2013-01-26 at 22:15 +0200, Aaro Koskinen wrote:
> Hi,
> 
> On Fri, Jan 25, 2013 at 01:13:15PM -0500, Steven Rostedt wrote:
> > Commit d3ce88431892 "MIPS: Fix modpost error in modules attepting to use
> > virt_addr_valid()" moved __virt_addr_valid() from a macro in a header
> > file to a function in ioremap.c. But ioremap.c is only compiled for MIPS
> > 32, and not for MIPS 64.
> > 
> > When compiling for my yeeloong2, which supposedly supports hibernation,
> > which compiles kernel/power/snapshot.c which calls virt_addr_valid(), I
> > got this error:
> 
> This has been reported also here:
> 
> 	http://marc.info/?l=linux-mips&m=135788867604856&w=2
> 
> and here:
> 
> 	http://marc.info/?l=linux-mips&m=135876719403187&w=2
> 

Hmm, interesting. Although, I prefer my change as it doesn't require
compiling all of ioremap.c where it's not needed.

> It's pretty sad that MIPS has been pretty much broken during the whole
> 3.8-rc cycle. :-(
> 

Yeah, that happens.

-- Steve
