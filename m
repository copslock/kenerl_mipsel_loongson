Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 12 Jan 2008 07:27:34 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:58376 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S20024252AbYALH10 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 12 Jan 2008 07:27:26 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 48364D8DC; Sat, 12 Jan 2008 07:27:14 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 7499654422; Sat, 12 Jan 2008 08:27:02 +0100 (CET)
Date:	Sat, 12 Jan 2008 08:27:02 +0100
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] Fix ethernet interrupts for Cobalt RaQ1
Message-ID: <20080112072702.GA10988@deprecation.cyrius.com>
References: <20080111232514.64772C2F2A@solo.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080111232514.64772C2F2A@solo.franken.de>
User-Agent: Mutt/1.5.16 (2007-06-11)
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17997
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Thomas Bogendoerfer <tsbogend@alpha.franken.de> [2008-01-12 00:25]:
> RAQ1 uses the same interrupt routing as qube2.

I guess should be "as qube1"?

> -	if (cobalt_board_id < COBALT_BRD_ID_QUBE2)
> +	if (cobalt_board_id <= COBALT_BRD_ID_QUBE1)

-- 
Martin Michlmayr
http://www.cyrius.com/
