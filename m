Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 May 2005 16:12:17 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:1563 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8224990AbVEEPMA>; Thu, 5 May 2005 16:12:00 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.1/8.13.1) with ESMTP id j45FBlUs009110;
	Thu, 5 May 2005 16:11:47 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j45FBlln009109;
	Thu, 5 May 2005 16:11:47 +0100
Date:	Thu, 5 May 2005 16:11:47 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Bryan Althouse <bryan.althouse@3phoenix.com>
Cc:	linux-mips@linux-mips.org
Subject: Re:
Message-ID: <20050505151147.GK17119@linux-mips.org>
References: <20050505145508.GJ17119@linux-mips.org> <20050505150853Z8224990-1340+6554@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050505150853Z8224990-1340+6554@linux-mips.org>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7857
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, May 05, 2005 at 11:08:39AM -0400, Bryan Althouse wrote:

> Right, there is no AGP.  At first, I was unable to locate the
> yosemite_defconfig, so I was running xconfig without a properly defaulted
> .config.  I inadvertently left the AGP support enabled.  Now that I am
> starting with yosemite_defcofig as a base-line, I have no problems compiling
> the kernel.

Oh, I was pretty sure you'd not have AGP.  However there are a few systems
which need high graphics performance and that's where AGP would make sense,
so while it's not very likely I could see some need for AGP for such
systems and did my posting in the hope somebody would raise his hand in
case there's AGP for MIPS after all ...

  Ralf
