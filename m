Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 May 2005 11:50:03 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:8207 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8225532AbVEYKtt>; Wed, 25 May 2005 11:49:49 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.1/8.13.1) with ESMTP id j4PAn6OA032259;
	Wed, 25 May 2005 11:49:06 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j4PAn6aD032258;
	Wed, 25 May 2005 11:49:06 +0100
Date:	Wed, 25 May 2005 11:49:05 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Jerry <jerry@wicomtechnologies.com>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: relocation truncated to fit
Message-ID: <20050525104905.GI4383@linux-mips.org>
References: <1399568766.20050525115143@wicomtechnologies.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1399568766.20050525115143@wicomtechnologies.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7972
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, May 25, 2005 at 11:51:43AM +0300, Jerry wrote:

> drivers/sound/sounddrivers.o: In function `sound_insert_unit':
> sound_core.c:(.text+0x1ac): undefined reference to `strcpy'
> sound_core.c:(.text+0x1ac): relocation truncated to fit: R_MIPS_26 against `strcpy'
> make[1]: *** [vmlinux] Ошибка 1
> make[1]: Leaving directory `/work/video/kernel'
> make: *** [vmlinux] Ошибка 2
> 
> It's not a "sound drivers" problem, howewer without it kernel compiles
> and run succesfully. Seems like gcc/bunitils bug/feature. What have to
> be done to eliminate this error?
> 
> GNU ld version 2.15.96 20050308
> gcc version 3.4.3

Don't use gcc 3.4 to compile Linux 2.4.  It may work for some kernel
configurations but it will fail for others.

  Ralf
