Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jan 2006 14:22:42 +0000 (GMT)
Received: from mipsfw.mips-uk.com ([194.74.144.146]:36101 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133644AbWAYOW0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 25 Jan 2006 14:22:26 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.4) with ESMTP id k0PEOhP4011242;
	Wed, 25 Jan 2006 14:24:43 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k0PEOhRk011241;
	Wed, 25 Jan 2006 14:24:43 GMT
Date:	Wed, 25 Jan 2006 14:24:43 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Martin Michlmayr <tbm@cyrius.com>
Cc:	Kaj-Michael Lang <milang@tal.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] IP32 gbefb depth change fix
Message-ID: <20060125142443.GA4909@linux-mips.org>
References: <Pine.LNX.4.61.0601251502170.11000@tori.tal.org> <20060125141639.GA20977@deprecation.cyrius.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060125141639.GA20977@deprecation.cyrius.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10142
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jan 25, 2006 at 02:16:39PM +0000, Martin Michlmayr wrote:

> * Kaj-Michael Lang <milang@tal.org> [2006-01-25 15:06]:
> > +		info->fix.visual = FB_VISUAL_PSEUDOCOLOR;	
> 
> Minor note: there a trailing tab at the end of this line.

Many Linux developers use git-applymbox which has the habbit of removing
trailing whitespace.  This may cause some inconvenience for the patch
submitter because what he's pulling back is different from what was
originally submitted.

  Ralf
