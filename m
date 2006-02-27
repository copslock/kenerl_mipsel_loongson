Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Feb 2006 19:03:18 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:16651 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S8133489AbWB0TDK (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 27 Feb 2006 19:03:10 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id B4AB664D3D; Mon, 27 Feb 2006 19:10:42 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id C3CE08FD8; Mon, 27 Feb 2006 20:10:33 +0100 (CET)
Date:	Mon, 27 Feb 2006 19:10:33 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	linux-mips@linux-mips.org
Cc:	dan@embeddededge.com, yoichi_yuasa@tripeaks.co.jp
Subject: Re: Diff between Linus' and linux-mips git: drivers!
Message-ID: <20060227191033.GB22383@deprecation.cyrius.com>
References: <20060219234318.GA16311@deprecation.cyrius.com> <20060220003439.GA18438@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060220003439.GA18438@deprecation.cyrius.com>
User-Agent: Mutt/1.5.11
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10664
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Martin Michlmayr <tbm@cyrius.com> [2006-02-20 00:34]:
> >  drivers/char/ibm_workpad_keymap.map        |  343 ++++
> > Michael Klar <wyldfier@iname.com>

Yoichi, as the maintainre of the IBM z50 support, can you comment?

> >  drivers/video/smivgxfb.c                   |  387 +++++
> > johuang@siliconmotion.com

Dan, are you willing to take responsibility for this driver (and
forward it upstream)?
-- 
Martin Michlmayr
http://www.cyrius.com/
