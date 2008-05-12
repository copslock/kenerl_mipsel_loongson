Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 May 2008 17:32:13 +0100 (BST)
Received: from sorrow.cyrius.com ([65.19.161.204]:37384 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S20030434AbYELQcJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 12 May 2008 17:32:09 +0100
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id E6968D8E7; Mon, 12 May 2008 16:32:05 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 283C6372609; Mon, 12 May 2008 18:32:01 +0200 (CEST)
Date:	Mon, 12 May 2008 18:32:01 +0200
From:	Martin Michlmayr <tbm@cyrius.com>
To:	linux-mips@linux-mips.org
Subject: Re: Malta build errors with 2.6.26-rc1
Message-ID: <20080512163200.GA19203@deprecation.cyrius.com>
References: <20080512163107.GA19052@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20080512163107.GA19052@deprecation.cyrius.com>
User-Agent: Mutt/1.5.16 (2007-06-11)
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19223
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Martin Michlmayr <tbm@cyrius.com> [2008-05-12 18:31]:
> Some Malta build errors:
> 
> cc1: warnings being treated as errors
> arch/mips/mips-boards/malta/malta_int.c: In function ‘gcmp_probe’:

Sorry, I forgot to mention that this is 64-bit Malta.  32-bit compiles
fine.
-- 
Martin Michlmayr
http://www.cyrius.com/
