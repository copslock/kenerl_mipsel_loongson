Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Aug 2005 16:05:55 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:14089 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8225244AbVHJPFg>; Wed, 10 Aug 2005 16:05:36 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j7AF9ZgR014407;
	Wed, 10 Aug 2005 16:09:35 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j7AF9Yq9014406;
	Wed, 10 Aug 2005 16:09:34 +0100
Date:	Wed, 10 Aug 2005 16:09:34 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Greg Weeks <greg.weeks@timesys.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: 24K malta
Message-ID: <20050810150934.GF2840@linux-mips.org>
References: <42FA03D4.5060400@timesys.com> <20050810140243.GD2840@linux-mips.org> <42FA0B9E.4030900@timesys.com> <42FA1311.4060903@timesys.com> <20050810144947.GE2840@linux-mips.org> <42FA1698.2060104@timesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42FA1698.2060104@timesys.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8722
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Aug 10, 2005 at 11:00:40AM -0400, Greg Weeks wrote:

> Now I get this:
> 
>  AS      arch/mips/kernel/r4k_switch.o
>  CC      arch/mips/kernel/vpe.o
> {standard input}: Assembler messages:
> {standard input}:1329: Error: unrecognized opcode `mftc0 $7,$2,4'
> {standard input}:1333: Error: unrecognized opcode `mftc0 $6,$2,1'

You have CONFIG_MT enabled but your binutils don't support these new
instructions yet.  Since you're using 4K and 24K CPUs only ATM I think
you should simply disable CONFIG_MT for now.

  Ralf
