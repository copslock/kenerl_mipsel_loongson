Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Nov 2009 12:38:19 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:45868 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1492947AbZKWLiM (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 23 Nov 2009 12:38:12 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nANBcLgo004275;
	Mon, 23 Nov 2009 11:38:22 GMT
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nANBcKO5004273;
	Mon, 23 Nov 2009 11:38:20 GMT
Date:	Mon, 23 Nov 2009 11:38:20 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Mikael Starvik <mikael.starvik@axis.com>
Cc:	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: COP2 unaligned -> SIGBUS
Message-ID: <20091123113820.GA4217@linux-mips.org>
References: <4BEA3FF3CAA35E408EA55C7BE2E61D0546A5E6F9DC@xmail3.se.axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4BEA3FF3CAA35E408EA55C7BE2E61D0546A5E6F9DC@xmail3.se.axis.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25054
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Nov 23, 2009 at 07:31:28AM +0100, Mikael Starvik wrote:

> Since there are now at least two users of cop2 I propose the following:

Yes, the comment is not quite correct.  CP2 has always been available for
application specific extensions and a few imlementations have made use of
that.  I'll update the comment.  Oh and the Praystation has a TLB.

Thanks!

  Ralf
