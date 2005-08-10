Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Aug 2005 15:46:04 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:34581 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8225234AbVHJOpt>; Wed, 10 Aug 2005 15:45:49 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j7AEnmGG013673;
	Wed, 10 Aug 2005 15:49:48 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j7AEnlxL013672;
	Wed, 10 Aug 2005 15:49:47 +0100
Date:	Wed, 10 Aug 2005 15:49:47 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Greg Weeks <greg.weeks@timesys.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: 24K malta
Message-ID: <20050810144947.GE2840@linux-mips.org>
References: <42FA03D4.5060400@timesys.com> <20050810140243.GD2840@linux-mips.org> <42FA0B9E.4030900@timesys.com> <42FA1311.4060903@timesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42FA1311.4060903@timesys.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8719
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Aug 10, 2005 at 10:45:37AM -0400, Greg Weeks wrote:

> Current CVS fails to build the malta_defconfig with:
> 
> 
> scripts/kconfig/mconf arch/mips/Kconfig
> arch/mips/Kconfig:690: can't open file "arch/mips/tx4938/Kconfig"
> make[1]: *** [menuconfig] Error 1
> make: *** [menuconfig] Error 2

CVS pilot error.  cvs -q update -d -P and don't forget to bitch about it ;)

  Ralf
