Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 06 Jan 2008 21:44:23 +0000 (GMT)
Received: from host194-211-dynamic.20-79-r.retail.telecomitalia.it ([79.20.211.194]:19376
	"EHLO eppesuigoccas.homedns.org") by ftp.linux-mips.org with ESMTP
	id S20026016AbYAFVoO (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 6 Jan 2008 21:44:14 +0000
Received: from localhost ([127.0.0.1] helo=sgi)
	by eppesuigoccas.homedns.org with smtp (Exim 4.63)
	(envelope-from <giuseppe@eppesuigoccas.homedns.org>)
	id 1JBdHo-0006oy-Vr
	for linux-mips@linux-mips.org; Sun, 06 Jan 2008 22:44:07 +0100
Date:	Sun, 6 Jan 2008 22:44:03 +0100
From:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>
To:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Fix IP32 breakage
Message-Id: <20080106224403.247879cf.giuseppe@eppesuigoccas.homedns.org>
In-Reply-To: <20080106185852.GA5530@deprecation.cyrius.com>
References: <20080105111311.2DE1CC2EF8@solo.franken.de>
	<20080106185852.GA5530@deprecation.cyrius.com>
X-Mailer: Sylpheed version 2.3.0beta5 (GTK+ 2.8.20; mips-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <giuseppe@eppesuigoccas.homedns.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17934
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giuseppe@eppesuigoccas.homedns.org
Precedence: bulk
X-list: linux-mips

I tested the original patch (2.6.24-rc6) and the system finally boot correctly. The second patch (related to meth) also works great on two different O2 systems.

On Sun, 6 Jan 2008 19:58:52 +0100 Martin Michlmayr <tbm@cyrius.com> wrote:
> The same patch is needed for 2.6.23.  Here's a version that will apply
> against 2.6.23.  Ralf, can you please commit that as well.
[...]
