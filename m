Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jan 2006 14:13:54 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:49423 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S8133612AbWAYONf (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 25 Jan 2006 14:13:35 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 5B15A64D3D; Wed, 25 Jan 2006 14:17:00 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 40C95892F; Wed, 25 Jan 2006 14:16:39 +0000 (GMT)
Date:	Wed, 25 Jan 2006 14:16:39 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Kaj-Michael Lang <milang@tal.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] IP32 gbefb depth change fix
Message-ID: <20060125141639.GA20977@deprecation.cyrius.com>
References: <Pine.LNX.4.61.0601251502170.11000@tori.tal.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0601251502170.11000@tori.tal.org>
User-Agent: Mutt/1.5.11
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10141
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Kaj-Michael Lang <milang@tal.org> [2006-01-25 15:06]:
> +		info->fix.visual = FB_VISUAL_PSEUDOCOLOR;	

Minor note: there a trailing tab at the end of this line.
-- 
Martin Michlmayr
http://www.cyrius.com/
