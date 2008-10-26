Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 26 Oct 2008 11:27:13 +0000 (GMT)
Received: from h4.dl5rb.org.uk ([81.2.74.4]:21948 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S22410576AbYJZL07 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 26 Oct 2008 11:26:59 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m9QBQSlP014900;
	Sun, 26 Oct 2008 11:26:29 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m9QBQ2fX014898;
	Sun, 26 Oct 2008 11:26:02 GMT
Date:	Sun, 26 Oct 2008 11:26:01 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Maxime Bizon <mbizon@freebox.fr>
Cc:	netdev@vger.kernel.org, afleming@freescale.com, jgarzik@pobox.com,
	linux-usb@vger.kernel.org, dbrownell@users.sourceforge.net,
	linux-pcmcia@lists.infradead.org, linux-serial@vger.kernel.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH/RFC v1 00/12] Support for Broadcom 63xx SOCs
Message-ID: <20081026112601.GA9364@linux-mips.org>
References: <1224382022-24173-1-git-send-email-mbizon@freebox.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1224382022-24173-1-git-send-email-mbizon@freebox.fr>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20972
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Oct 19, 2008 at 04:07:02AM +0200, Maxime Bizon wrote:

> [first try at patch series mailing, if you're in to/cc list by mistake
> please tell me]

In the Linux world people more complain about email they do not receive
than they receive unnecessarily.

Looks ok - the only thing that's a bit strange about this email is that
git-send-email which you seem to have used normally sends out all emails
as reply either to the one preceeding in the series or or the first of
all - but yours arrived without reply headers.

This means the receiver has to be careful to apply things in the right
order since the mail client probably will display them in the order of
arrival, if emails get reordered in transmission.

> This is a set of patches that add support for the Broadcom 63xx series
> of CPUs and  (some) integrated devices. These are  popular MIPS32 SOCs
> found in a lot of DSL modems.
> 
> CPUs supported are  6348 and 6358. Support is  provided for integrated
> UART,  USB OHCI  and  EHCI, PCI  controller,  ethernet MAC  & PHY  and
> PCMCIA/Cardbus controller.
> 
> Board support is still rough, each vendor seems to have its own way of
> identifying the board  type in nvram, that's why  it will probably not
> work out of  the box.  So DON'T FLASH IT BLINDLY  on your modem unless
> you have a serial cable, prefer tftpboot/nfsroot for testing.
> 
> I used linux-mips git tree  master to generate theses patches, this is
> probably  inappropriate considering  they  touch multiple  subsystems.
> Since all patches  depends on first two of the series  I wonder how to
> submit this properly for inclusion in one merge window (if that's even
> do-able).

As agreed earlier I've setup a git tree on linux-mips.org at
/pub/scm/linux-bcm63xx.git which also is visible on.
http://www.linux-mips.org/git.

If you want to send me any updates then it's also ok to send me a patch
relative to an earlier patch.  I'll then just fold it into that earlier
patch.

  Ralf
