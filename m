Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Nov 2008 17:12:42 +0000 (GMT)
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:34753 "EHLO
	lxorguk.ukuu.org.uk") by ftp.linux-mips.org with ESMTP
	id S23909426AbYKYRMf (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 25 Nov 2008 17:12:35 +0000
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by lxorguk.ukuu.org.uk (8.14.2/8.14.2) with ESMTP id mAPHCO55011386;
	Tue, 25 Nov 2008 17:12:25 GMT
Date:	Tue, 25 Nov 2008 17:12:24 +0000
From:	Alan Cox <alan@lxorguk.ukuu.org.uk>
To:	Jeff Garzik <jeff@garzik.org>
Cc:	David Daney <ddaney@caviumnetworks.com>, linux-ide@vger.kernel.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH 1/2] libata: Add three more columns to the ata_timing
 table.
Message-ID: <20081125171224.297931b2@lxorguk.ukuu.org.uk>
In-Reply-To: <492C2F23.8050105@garzik.org>
References: <492B56B0.9030409@caviumnetworks.com>
	<1227577181-30206-1-git-send-email-ddaney@caviumnetworks.com>
	<492C2F23.8050105@garzik.org>
X-Mailer: Claws Mail 3.5.0 (GTK+ 2.12.12; x86_64-redhat-linux-gnu)
Organization: Red Hat UK Cyf., Amberley Place, 107-111 Peascod Street,
 Windsor, Berkshire, SL4 1TE, Y Deyrnas Gyfunol. Cofrestrwyd yng Nghymru a
 Lloegr o'r rhif cofrestru 3798903
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <alan@lxorguk.ukuu.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21422
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips

On Tue, 25 Nov 2008 12:00:19 -0500
Jeff Garzik <jeff@garzik.org> wrote:

> David Daney wrote:
> > The forthcoming OCTEON SOC Compact Flash driver needs a few more
> > timing values than were available in the ata_timing table.  I add new
> > columns for write_hold, read_hold, and read_holdz times.  The values
> > were obtained from the Compact Flash specification Rev 4.1.
> > 
> > Signed-off-by: David Daney <ddaney@caviumnetworks.com>
> > ---
> >  drivers/ata/libata-core.c |   76 ++++++++++++++++++++++++--------------------
> >  include/linux/libata.h    |   14 ++++++--
> >  2 files changed, 52 insertions(+), 38 deletions(-)
> 
> I would be happy to go ahead and apply this...  Alan, any last minute 
> objections?

Its close but I think Sergei is right about columns with all the same
value - they can be constants and just computed into the final timing
data in terms of clocks.
