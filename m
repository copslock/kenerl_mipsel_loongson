Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Jul 2009 23:44:28 +0200 (CEST)
Received: from sorrow.cyrius.com ([65.19.161.204]:33039 "EHLO
	sorrow.cyrius.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1492704AbZGDVoV (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 4 Jul 2009 23:44:21 +0200
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id A1363D8D1; Sat,  4 Jul 2009 21:37:51 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 47188151158; Sat,  4 Jul 2009 23:37:41 +0200 (CEST)
Date:	Sat, 4 Jul 2009 23:37:41 +0200
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Yoichi Yuasa <yuasa@linux-mips.org>, linux-mips@linux-mips.org
Cc:	dwmw2@infradead.org
Subject: mtd related Cobalt build failure with current git
Message-ID: <20090704213741.GA6438@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23644
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

I get the following Cobalt build failure with current git:

  CC      arch/mips/cobalt/mtd.o
cc1: warnings being treated as errors
In file included from arch/mips/cobalt/mtd.c:22:
include/linux/mtd/partitions.h:50: warning: ‘struct mtd_info’ declared inside parameter list
include/linux/mtd/partitions.h:50: warning: its scope is only this definition or declaration, which is probably not what you want
include/linux/mtd/partitions.h:51: warning: ‘struct mtd_info’ declared inside parameter list
include/linux/mtd/partitions.h:61: warning: ‘struct mtd_info’ declared inside parameter list
include/linux/mtd/partitions.h:67: warning: ‘struct mtd_info’ declared inside parameter list
make[1]: *** [arch/mips/cobalt/mtd.o] Error 1
make: *** [arch/mips/cobalt] Error 2

Does anyone know if there's a fix for this already?
-- 
Martin Michlmayr
http://www.cyrius.com/
