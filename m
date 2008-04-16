Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Apr 2008 21:12:54 +0100 (BST)
Received: from fmmailgate03.web.de ([217.72.192.234]:63617 "EHLO
	fmmailgate03.web.de") by ftp.linux-mips.org with ESMTP
	id S20030350AbYDPUMw (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 16 Apr 2008 21:12:52 +0100
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate03.web.de (Postfix) with ESMTP id 6AABDD74FFD0;
	Wed, 16 Apr 2008 22:12:43 +0200 (CEST)
Received: from [77.178.173.29] (helo=merkur.sol.de)
	by smtp05.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.109 #226)
	id 1JmDzn-0007wa-00; Wed, 16 Apr 2008 22:12:43 +0200
Received: from jens by merkur.sol.de with local (Exim 4.63)
	(envelope-from <tux-master@web.de>)
	id 1JmDsd-0005dw-4n; Wed, 16 Apr 2008 22:05:19 +0200
Date:	Wed, 16 Apr 2008 22:05:19 +0200
From:	Jens Seidel <jensseidel@users.sf.net>
To:	linux-mips@linux-mips.org,
	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] Alchemy: kill useless #include's, #define's and extern's (take 3)
Message-ID: <20080416200517.GA21402@merkur.sol.de>
References: <200804162115.59620.sshtylyov@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200804162115.59620.sshtylyov@ru.mvista.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Sender: tux-master@web.de
X-Provags-ID: V01U2FsdGVkX1/99qTNxT3eGWA3/Cp5LnB7txU2eRKN0jGLU/lt
	w6cONwVsMu5T8sf1UtodlIOHhmQTcxE3qXrEMLo8dgnVhlsRNj
	zHXdTcK3A=
Return-Path: <tux-master@web.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18942
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jensseidel@users.sf.net
Precedence: bulk
X-list: linux-mips

Hi Sergei,

On Wed, Apr 16, 2008 at 09:15:59PM +0400, Sergei Shtylyov wrote:
> Go thru the Alchemy code and hunt down every unneeded #include, #define, and
> extern (some of which refer to already long dead functions).

that's an impressive patch! Did you created it manually or do you have a
script which does the checks for you?

I have a program which would probably profit from it as well.

Jens
