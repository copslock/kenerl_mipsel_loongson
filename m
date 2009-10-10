Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 Oct 2009 03:07:18 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:35287 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1493511AbZJJBHP (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 10 Oct 2009 03:07:15 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n9A18LWN001716;
	Sat, 10 Oct 2009 03:08:23 +0200
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n9A18KQW001713;
	Sat, 10 Oct 2009 03:08:20 +0200
Date:	Sat, 10 Oct 2009 03:08:20 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH 0/2] USB: Add USB HCD for Octeon SOCs.
Message-ID: <20091010010820.GA1151@linux-mips.org>
References: <4ACD2EBF.8020901@caviumnetworks.com> <4ACE1CBD.6000106@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ACE1CBD.6000106@caviumnetworks.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24210
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Oct 08, 2009 at 10:09:17AM -0700, David Daney wrote:

>> I will reply with the two patches.
>>
>
> I did in fact reply with the two patches.  However some spam filtering  
> seems to have stopped '[PATCH 2/2] USB: Add HCD for Octeon SOC' from  
> making it to the lists.
>
> Ralf has released it to linux-mips@linux-mips.org, but  
> linux-usb@vger.kernel.org seems to have eaten it.

Since a while lmo's spamfilter which is trying to find stuff like "via.ra"
has figured out that this might be spam in disguise and unfortunately
there is plenty of that sort of stuff in C code so occasionally posted
patches go to neverland.  Unfortunately that's far more likely to happen
than I'd like to - this USB driver caused about a dozen hits.

Suspected spam postings will be re-routed to a moderator queue.  The volume
of spam that ends up in the moderator queue has become so high that I don't
normally follow it because that's another like 4,000 emails per month ...
If a patch doesn't make it to the list then drop me a note best within
< 24h of the initial posting; after 24h postings are dropped from the
moderator queue so I can't approve them anymore.

  Ralf
