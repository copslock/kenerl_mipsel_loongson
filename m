Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 May 2009 20:26:13 +0100 (BST)
Received: from sorrow.cyrius.com ([65.19.161.204]:37635 "EHLO
	sorrow.cyrius.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20024349AbZEMT0H (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 13 May 2009 20:26:07 +0100
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id AACEDD8D1; Wed, 13 May 2009 19:25:59 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 70B89150F6E; Wed, 13 May 2009 21:25:49 +0200 (CEST)
Date:	Wed, 13 May 2009 21:25:49 +0200
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Peter 'p2' De Schrijver <p2@debian.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: sb1250 ethernet driver problem
Message-ID: <20090513192549.GS2999@deprecation.cyrius.com>
References: <20090513191557.GN1835@apfelkorn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090513191557.GN1835@apfelkorn>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22701
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Peter 'p2' De Schrijver <p2@debian.org> [2009-05-13 22:15]:
> There seems to be a bug in the mdio part of the sb1250 ethernet
> driver in 2.6.30-rc5. See attached log file.

I believe this is a generic problem with CONFIG_FIXED_PHY,
see http://markmail.org/message/yhaorue23uuiqgal

-- 
Martin Michlmayr
http://www.cyrius.com/
