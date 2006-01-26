Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Jan 2006 17:15:05 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:9994 "EHLO sorrow.cyrius.com")
	by ftp.linux-mips.org with ESMTP id S8133650AbWAZROq (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 26 Jan 2006 17:14:46 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id E5F6A64D3D; Thu, 26 Jan 2006 17:19:15 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id C0EAD8D5E; Thu, 26 Jan 2006 17:19:04 +0000 (GMT)
Date:	Thu, 26 Jan 2006 17:19:04 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Peter Horton <pdh@colonel-panic.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH 2.6] Cobalt IDE fix, again
Message-ID: <20060126171904.GA12850@deprecation.cyrius.com>
References: <20060125001303.GA2569@colonel-panic.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060125001303.GA2569@colonel-panic.org>
User-Agent: Mutt/1.5.11
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10189
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

now I get:

drivers/ide/mips/swarm.c: In function ‘swarm_ide_probe’:
drivers/ide/mips/swarm.c:78: error: ‘CONFIG_IDE_MAX_HWIFS’ undeclared (first use in this function)
drivers/ide/mips/swarm.c:78: error: (Each undeclared identifier is reported only once
drivers/ide/mips/swarm.c:78: error: for each function it appears in.)

-- 
Martin Michlmayr
http://www.cyrius.com/
