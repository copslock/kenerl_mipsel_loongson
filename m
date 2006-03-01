Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Mar 2006 12:38:19 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:43529 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S8133138AbWCAMiL (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 1 Mar 2006 12:38:11 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id EC92A64D3D; Wed,  1 Mar 2006 12:45:59 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id AE55A9028; Wed,  1 Mar 2006 13:45:52 +0100 (CET)
Date:	Wed, 1 Mar 2006 12:45:52 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Dave Johnson <djohnson+linuxmips@sw.starentnetworks.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] fix lost ticks on SB1250
Message-ID: <20060301124552.GA5831@deprecation.cyrius.com>
References: <17118.25343.948383.547250@cortez.sw.starentnetworks.com> <20060116160031.GA28383@deprecation.cyrius.com> <17355.52046.456176.406834@cortez.sw.starentnetworks.com> <17355.59571.567485.592914@cortez.sw.starentnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17355.59571.567485.592914@cortez.sw.starentnetworks.com>
User-Agent: Mutt/1.5.11
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10699
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Dave Johnson <djohnson+linuxmips@sw.starentnetworks.com> [2006-01-16 13:40]:
> Patch is against 2.6.12 with some other patches unfortunatly (only
> the gettimeofday one should matter as far as merging)

Do you think you can update the patch for 2.6.16 and clean it up for
submission?

-- 
Martin Michlmayr
http://www.cyrius.com/
