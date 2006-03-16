Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Mar 2006 14:05:53 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:44551 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S8133710AbWCPOFp (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 16 Mar 2006 14:05:45 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 5507C64D3D; Thu, 16 Mar 2006 14:15:01 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 7F36A66ED5; Thu, 16 Mar 2006 14:14:47 +0000 (GMT)
Date:	Thu, 16 Mar 2006 14:14:47 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	linux-mips@linux-mips.org
Subject: Re: [MIPS] Sibyte: Fix race in sb1250_gettimeoffset().
Message-ID: <20060316141447.GV25322@deprecation.cyrius.com>
References: <S8133620AbWCPM6I/20060316125808Z+139@ftp.linux-mips.org> <20060316141127.GS25322@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060316141127.GS25322@deprecation.cyrius.com>
User-Agent: Mutt/1.5.11+cvs20060126
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10821
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Martin Michlmayr <tbm@cyrius.com> [2006-03-16 14:11]:
> This leads to compiler errors on 1480 because sb1250_hpt_setup() is

linker

> [MIPS] don't call sb1250_hpt_setup on 1480
> 
> sb1250_hpt_setup() should not be called on the 1480 board since it's
> note defined there, leading to a linking error.

s/note/not/

-- 
Martin Michlmayr
http://www.cyrius.com/
