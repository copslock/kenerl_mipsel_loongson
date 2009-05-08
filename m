Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 May 2009 17:34:26 +0100 (BST)
Received: from sj-iport-6.cisco.com ([171.71.176.117]:50041 "EHLO
	sj-iport-6.cisco.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20025252AbZEHQeU (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 8 May 2009 17:34:20 +0100
X-IronPort-AV: E=Sophos;i="4.40,318,1238976000"; 
   d="scan'208";a="301008844"
Received: from sj-dkim-4.cisco.com ([171.71.179.196])
  by sj-iport-6.cisco.com with ESMTP; 08 May 2009 16:34:00 +0000
Received: from sj-core-5.cisco.com (sj-core-5.cisco.com [171.71.177.238])
	by sj-dkim-4.cisco.com (8.12.11/8.12.11) with ESMTP id n48GY0X9027840;
	Fri, 8 May 2009 09:34:00 -0700
Received: from cuplxvomd02.corp.sa.net ([64.101.20.155])
	by sj-core-5.cisco.com (8.13.8/8.13.8) with ESMTP id n48GY03x019746;
	Fri, 8 May 2009 16:34:00 GMT
Date:	Fri, 8 May 2009 09:34:00 -0700
From:	David VomLehn <dvomlehn@cisco.com>
To:	Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH 2/3] mips:powertv: Make kernel command line size
	configurable (resend)
Message-ID: <20090508163400.GA5466@cuplxvomd02.corp.sa.net>
References: <20090504225719.GA22417@cuplxvomd02.corp.sa.net> <7d1d9c250905080825n62f46b2bk254a736d3bce2ec6@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7d1d9c250905080825n62f46b2bk254a736d3bce2ec6@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
DKIM-Signature:	v=1; a=rsa-sha256; q=dns/txt; l=1429; t=1241800440; x=1242664440;
	c=relaxed/simple; s=sjdkim4002;
	h=Content-Type:From:Subject:Content-Transfer-Encoding:MIME-Version;
	d=cisco.com; i=dvomlehn@cisco.com;
	z=From:=20David=20VomLehn=20<dvomlehn@cisco.com>
	|Subject:=20Re=3A=20[PATCH=202/3]=20mips=3Apowertv=3A=20Mak
	e=20kernel=20command=20line=20size=0A=09configurable=20(rese
	nd)
	|Sender:=20;
	bh=deS/nAUJmBtlUNEKOGKSAEjDeBbbp8QeLmth4BUN69E=;
	b=n/eDT9enyxUq98Z3/ck/BSenxSGAZYf+WkQJiuEbYfVjkJq8EzmfyDqCTy
	rcexybjPnXyR1Kr/s02o/zbwJGPr5tG7cjVcNMlLoBIvCPKg6hJM6OO+rVqf
	kAAcPTAgPL;
Authentication-Results:	sj-dkim-4; header.From=dvomlehn@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim4002 verified; ); 
Return-Path: <dvomlehn@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22670
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dvomlehn@cisco.com
Precedence: bulk
X-list: linux-mips

On Fri, May 08, 2009 at 11:25:35AM -0400, Paul Gortmaker wrote:
> On Mon, May 4, 2009 at 6:57 PM, David VomLehn <dvomlehn@cisco.com> wrote:
> > Most platforms can get by perfectly well with the default command line size,
> > but some platforms need more. This patch allows the command line size to
> > be configured for those platforms that need it. The default remains 256
> > characters.
> 
> The one thing I see when I look at this patch, is that it lands in the
> arch/mips/Kconfig -- but is there really anything fundamentally
> architecture specific about the allowed length of the kernel command
> line?.  It probably belongs somewhere alongside the setting for
> LOG_BUF_LEN or similar (and then add the other respective changes
> to make all arch actually respect the setting.)
> 
> Paul.
> 
> >
> > Signed-off-by: David VomLehn <dvomlehn@cisco.com>
> > ---
> >  arch/mips/Kconfig             |    7 +++++++
> >  arch/mips/include/asm/setup.h |    2 +-

The reason I put this configuration configuration in the architecture-
specific Kconfig is because COMMAND_LINE_SIZE is defined in the
architecture-specific file arch/mips/include/asm/setup.h. I strongly
agree that this really should not be an architecture-specific definition,
but it's much more complex to get a patch to change COMMAND_LINE_SIZE
in every architecture. Fixing in the MIPS tree seems like a good
start.

David VomLehn
