Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Oct 2006 02:10:58 +0100 (BST)
Received: from p549F5BCD.dip.t-dialin.net ([84.159.91.205]:18644 "EHLO
	p549F5BCD.dip.t-dialin.net") by ftp.linux-mips.org with ESMTP
	id S20038954AbWJDBK4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 4 Oct 2006 02:10:56 +0100
Received: from localhost ([127.0.0.1]:33731 "EHLO dl5rb.ham-radio-op.net")
	by lappi.linux-mips.net with ESMTP id S1100411AbWJDBKy (ORCPT
	<rfc822;linux-mips@linux-mips.org> + 1 other);
	Wed, 4 Oct 2006 03:10:54 +0200
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.7/8.13.7) with ESMTP id k941AoAD010443;
	Wed, 4 Oct 2006 02:10:50 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.7/8.13.7/Submit) id k941Akha010441;
	Wed, 4 Oct 2006 02:10:46 +0100
Date:	Wed, 4 Oct 2006 02:10:46 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Andrew Morton <akpm@osdl.org>
Cc:	"Maciej W. Rozycki" <macro@linux-mips.org>,
	Jeff Garzik <jgarzik@pobox.com>,
	Andy Fleming <afleming@freescale.com>, netdev@vger.kernel.org,
	linux-mips@linux-mips.org
Subject: Re: [patch 4/6] 2.6.18: sb1250-mac: The actual driver update
Message-ID: <20061004011046.GA10247@linux-mips.org>
References: <Pine.LNX.4.64N.0610031549270.4642@blysk.ds.pg.gda.pl> <20061003164253.62f9d5a3.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061003164253.62f9d5a3.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12795
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Oct 03, 2006 at 04:42:53PM -0700, Andrew Morton wrote:

> On Tue, 3 Oct 2006 16:18:44 +0100 (BST)
> "Maciej W. Rozycki" <macro@linux-mips.org> wrote:
> 
> > +	sbmac_state_t		sbm_state;	/* current state */
> 
> argh.
> 
> The reader looks at this and doesn't know if it's an integer, a void*, a
> struct usb_ac_header_descriptor** or what.
> 
> 	enum sbmac_state	smb_state;
> 
> is nicer.  It has information.

De-typedef-ing would be a separate project for this driver which makes
quite generous use of typedefs.

  Ralf
