Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 22 Jan 2006 02:32:16 +0000 (GMT)
Received: from p549F536B.dip.t-dialin.net ([84.159.83.107]:52929 "EHLO
	p549F536B.dip.t-dialin.net") by ftp.linux-mips.org with ESMTP
	id S8133437AbWAVCbM (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 22 Jan 2006 02:31:12 +0000
Received: from sorrow.cyrius.com ([IPv6:::ffff:65.19.161.204]:60429 "EHLO
	sorrow.cyrius.com") by linux-mips.net with ESMTP id <S870937AbWAUUBa>;
	Sat, 21 Jan 2006 21:01:30 +0100
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 83DA964D3D; Sat, 21 Jan 2006 20:00:22 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 9DF918486; Sat, 21 Jan 2006 19:59:56 +0000 (GMT)
Date:	Sat, 21 Jan 2006 19:59:56 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: DECstation compile fails: opcode not supported (eret)
Message-ID: <20060121195956.GA15498@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10036
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

linux-mips git with the standard DECstation config from
arch/mips/configs/decstation_defconfig fails with the following error:

  AS      arch/mips/kernel/genex.o
arch/mips/kernel/genex.S: Assembler messages:
arch/mips/kernel/genex.S:240: Error: opcode not supported on this processor: mips1 (mips1) `eret'
make[1]: *** [arch/mips/kernel/genex.o] Error 1
make: *** [arch/mips/kernel] Error 2

Toolchain used:
gcc version 4.0.3 20051201 (prerelease) (Debian 4.0.2-5)
binutils: 2.16.91 20051117 Debian GNU/Linux

-- 
Martin Michlmayr
http://www.cyrius.com/
