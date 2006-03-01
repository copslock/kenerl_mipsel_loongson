Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Mar 2006 23:07:09 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:35598 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S8133712AbWCAXGf (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 1 Mar 2006 23:06:35 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 36B1764D3D; Wed,  1 Mar 2006 23:14:27 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id D28CA86BB; Thu,  2 Mar 2006 00:14:19 +0100 (CET)
Date:	Wed, 1 Mar 2006 23:14:19 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Peter Horton <pdh@colonel-panic.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: Crash on Cobalt with CONFIG_SERIO=y
Message-ID: <20060301231419.GS26088@deprecation.cyrius.com>
References: <20060120004208.GA18327@deprecation.cyrius.com> <20060120144710.GA30415@linux-mips.org> <20060121010455.GC3514@colonel-panic.org> <20060228165404.GA8442@deprecation.cyrius.com> <20060301224001.GA719@colonel-panic.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060301224001.GA719@colonel-panic.org>
User-Agent: Mutt/1.5.11
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10712
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Peter Horton <pdh@colonel-panic.org> [2006-03-01 22:40]:
> Those addresses that begin 9b640000 (including the fault address) look
> very strange. The low 32-bits look like a valid physical address in the
> PCI space but the top bits definitely don't look right (unless the
> kernel's playing tricks with unused address bits; I'll have to check the
> RM523x data sheet to see if they have any effect). Have any of the MIPs
> experts commented ?

Raaalf? ;-)
-- 
Martin Michlmayr
http://www.cyrius.com/
