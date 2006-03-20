Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Mar 2006 13:02:04 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:49156 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S8133830AbWCTNBx (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 20 Mar 2006 13:01:53 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id A7CA264D3D; Mon, 20 Mar 2006 13:11:25 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id E253C66ED5; Mon, 20 Mar 2006 13:10:53 +0000 (GMT)
Date:	Mon, 20 Mar 2006 13:10:53 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc:	akpm@osdl.org, linux-kernel@vger.kernel.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH 1/12] [MIPS] Improve description of VR41xx based machines
Message-ID: <20060320131053.GA29434@deprecation.cyrius.com>
References: <20060320043802.GA20389@deprecation.cyrius.com> <20060320043902.GA20416@deprecation.cyrius.com> <20060320152646.1c5690e3.yoichi_yuasa@tripeaks.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060320152646.1c5690e3.yoichi_yuasa@tripeaks.co.jp>
User-Agent: Mutt/1.5.11+cvs20060126
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10877
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp> [2006-03-20 15:26]:
> > MIPS supports various NEC VR41XX chips and not just the VR4100.
> > Update Kconfig accordingly, thereby bringing the file in sync with
> > the linux-mips tree.
> The linux-mips tree is older than kernel.org about this part.

Have you looked at the exact change I sent (I know that linux-mips has
some older stuff, but the patch I sent was against linux-mips+new).
IOW, is it more correct to say "VR4100" in Kconfig rather than
"VR41XX", even though more CPUs than the VR4100 are supported?

All my patch does is a a/VR4100/VR41XX/, really.


> > -	bool "Support for NEC VR4100 series based machines"
> > +	bool "Support for NEC VR41XX-based machines"
...
> > -	  The options selects support for the NEC VR4100 series of processors.
> > +	  The options selects support for the NEC VR41xx series of processors.
> >  	  Only choose this option if you have one of these processors as a

-- 
Martin Michlmayr
http://www.cyrius.com/
