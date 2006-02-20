Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Feb 2006 15:21:04 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:24324 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S8133390AbWBTPUw (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 20 Feb 2006 15:20:52 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 9BC9564D3D; Mon, 20 Feb 2006 15:27:43 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 4F2688DC5; Mon, 20 Feb 2006 15:27:36 +0000 (GMT)
Date:	Mon, 20 Feb 2006 15:27:36 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Jordan Crouse <jordan.crouse@amd.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Diff between Linus' and linux-mips git: drivers!
Message-ID: <20060220152736.GB4796@deprecation.cyrius.com>
References: <20060219234318.GA16311@deprecation.cyrius.com> <20060220152734.GM30429@cosmic.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060220152734.GM30429@cosmic.amd.com>
User-Agent: Mutt/1.5.11
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10570
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Jordan Crouse <jordan.crouse@amd.com> [2006-02-20 08:27]:
> Meh - I think there's something to be said for platform specific trees.
> Why bother Linus with code that 99% of the users will never compile?

If there are any major changes to the video layer, people will fix
your driver if it's in mainline; but not if it's in some obscure tree.
Also, peer review, etc.

> >  sound/oss/au1550_i2s.c                     | 2029  ++++++++++++++++++++++++++++
> I thought we agreed that this would stay in linux-mips until such
> time that somebody (probably me) got annoyed enough to write an ALSA
> driver.

lkml people seem to be trying hard recently to finally get rid of OSS,
so that would be nice.
-- 
Martin Michlmayr
http://www.cyrius.com/
