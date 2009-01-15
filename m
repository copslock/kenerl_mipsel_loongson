Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Jan 2009 18:00:03 +0000 (GMT)
Received: from ns2.suse.de ([195.135.220.15]:34770 "EHLO mx2.suse.de")
	by ftp.linux-mips.org with ESMTP id S21365949AbZAOSAB (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 15 Jan 2009 18:00:01 +0000
Received: from Relay1.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 4628A483BB;
	Thu, 15 Jan 2009 18:59:57 +0100 (CET)
From:	Andreas Schwab <schwab@suse.de>
To:	Mike Travis <travis@sgi.com>
Cc:	Ingo Molnar <mingo@elte.hu>, Rusty Russell <rusty@rustcorp.com.au>,
	Yinghai Lu <yinghai@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"H. Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
	IA64 <linux-ia64@vger.kernel.org>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	David Howells <dhowells@redhat.com>,
	Koichi Yasutake <yasutake.koichi@jp.panasonic.com>,
	linux-am33-list@redhat.com,
	"David S. Miller" <davem@davemloft.net>,
	SPARC <sparclinux@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: crash: IP: [<ffffffff80478092>] __bitmap_intersects+0x48/0x73 [PATCH supplied]
References: <496BF6D5.9030403@sgi.com> <20090113130048.GB31147@elte.hu>
	<496CAF5A.3010304@sgi.com> <496D0F46.2010907@sgi.com>
	<496D2172.6030608@sgi.com> <20090114165431.GA18826@elte.hu>
	<20090114165524.GA21742@elte.hu> <20090114175126.GA21078@elte.hu>
	<496E78BA.5040609@sgi.com> <20090115101428.GG5833@elte.hu>
	<496F67D8.4060507@sgi.com>
X-Yow:	NOW, I'm supposed to SCRAMBLE two, and HOLD th' MAYO!!
Date:	Thu, 15 Jan 2009 18:59:54 +0100
In-Reply-To: <496F67D8.4060507@sgi.com> (Mike Travis's message of "Thu, 15 Jan
	2009 08:44:08 -0800")
Message-ID: <jepriolaat.fsf@sykes.suse.de>
User-Agent: Gnus/5.110009 (No Gnus v0.9) Emacs/22.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <schwab@suse.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21756
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: schwab@suse.de
Precedence: bulk
X-list: linux-mips

Mike Travis <travis@sgi.com> writes:

>  23> git-remote update
> Updating linus
> Updating tip

This only updates the remotes, but does not merge anything into your
local branch.  You need to run "git merge tip" to do that.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
