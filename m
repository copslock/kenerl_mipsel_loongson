Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Apr 2005 11:41:07 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:63236 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8225527AbVDRKkx>; Mon, 18 Apr 2005 11:40:53 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.1/8.13.1) with ESMTP id j3IAemuL008505;
	Mon, 18 Apr 2005 11:40:48 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j3IAemJE008504;
	Mon, 18 Apr 2005 11:40:48 +0100
Date:	Mon, 18 Apr 2005 11:40:48 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Ulrich Eckhardt <eckhardt@satorlaser.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [patch] add missing declaration of smp_processor_id
Message-ID: <20050418104048.GD4572@linux-mips.org>
References: <200504181146.26588.eckhardt@satorlaser.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200504181146.26588.eckhardt@satorlaser.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7744
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Apr 18, 2005 at 11:46:26AM +0200, Ulrich Eckhardt wrote:

> The missing declaration leads to warnings during compilation for Alchemy 
> boards.

Applied,

  Ralf
