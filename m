Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Jan 2006 12:29:16 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:43793 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S8133593AbWARM25 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 18 Jan 2006 12:28:57 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 3F86864D54; Wed, 18 Jan 2006 12:31:40 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 85D328456; Wed, 18 Jan 2006 12:31:10 +0000 (GMT)
Date:	Wed, 18 Jan 2006 12:31:10 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	linux-mips@linux-mips.org
Subject: CONFIG_64BIT and CONFIG_BUILD_ELF64
Message-ID: <20060118123110.GA21786@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9959
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

I'm trying to build a 64bit kernel for Cobalt and get the following.
Is there a good reason why CONFIG_64BIT does not activate
CONFIG_BUILD_ELF64 automatically?

  CC      init/main.o
Assembler messages:
Error: -mgp64 used with a 32-bit ABI
make[1]: *** [init/main.o] Error 1

-- 
Martin Michlmayr
http://www.cyrius.com/
