Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Mar 2005 14:09:19 +0000 (GMT)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:9489 "EHLO
	mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225755AbVCHOJF>; Tue, 8 Mar 2005 14:09:05 +0000
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id j28E7lFx015431;
	Tue, 8 Mar 2005 14:07:47 GMT
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j28E7lRg015409;
	Tue, 8 Mar 2005 14:07:47 GMT
Date:	Tue, 8 Mar 2005 14:07:47 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	JP Foster <jp.foster@exterity.co.uk>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: clear_user_page in page.h
Message-ID: <20050308140747.GC9811@linux-mips.org>
References: <1110287573.30647.16.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1110287573.30647.16.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7402
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Mar 08, 2005 at 01:12:52PM +0000, JP Foster wrote:

> Hi all,
> I'm building the video4linux drivers as modules and the video-buf driver
> can't load as it has no reference to shm_align_mask and
> flush_data_cache_page. 
> 
> These are needed by asm-mips/page.h for the inline funcs, pages_do_alias
> and clear/copy_user_page.
> How should shm_align_mask and flush_data_cache_page. be exported to
> modules?
> 
> Most other asm-xxx/page.h doesn't need any externs, all is #defined
> within page.h or files included by it.
> 
> Any ideas how I deal with this? Presumably other modules will be 
> affected by this.

The code in question should be considered broken anyway but for the
time being until this is actually fixed I'm going to add the two symbol
exports.

  Ralf
