Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Sep 2007 11:24:59 +0100 (BST)
Received: from sorrow.cyrius.com ([65.19.161.204]:7181 "EHLO sorrow.cyrius.com")
	by ftp.linux-mips.org with ESMTP id S20029487AbXIZKYv (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 26 Sep 2007 11:24:51 +0100
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 2875ED8DF; Wed, 26 Sep 2007 10:24:39 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 84619542CF; Wed, 26 Sep 2007 12:24:12 +0200 (CEST)
Date:	Wed, 26 Sep 2007 12:24:12 +0200
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc:	linux-mips@linux-mips.org, Franck Bui-Huu <fbuihuu@gmail.com>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: CONFIG_BUILD_ELF64 broken on IP32 since 2.6.20
Message-ID: <20070926102412.GK3337@deprecation.cyrius.com>
References: <20070925181353.GA15412@deprecation.cyrius.com> <46FA1260.4000404@gmail.com> <20070926091443.GA10236@deprecation.cyrius.com> <46FA2C39.9020503@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46FA2C39.9020503@gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-11)
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16687
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Franck Bui-Huu <vagabon.xyz@gmail.com> [2007-09-26 11:54]:
> >  memory: 0000000004000000 @ 0000000050000000 (usable)
> > *** __pa: symbol in CKSEG0 found: wireless_nlevent_queue+0x20/0x20
> > 
> 
> hmm it doesn't really help here. Could you print out the address value
> instead ?

*** __pa: symbol in CKSEG0 found: wireless_nlevent_queue+0x20/0x20
ffffffff8052bf70

> Weird, all these symbols seem to be 32 bits ones...
> 
> Could you put somewhere your vmlinux you're actually running ?

http://merkel.debian.org/~tbm/tmp/vmlinux.32
Note that I'm using "make vmlinux.32"
-- 
Martin Michlmayr
http://www.cyrius.com/
