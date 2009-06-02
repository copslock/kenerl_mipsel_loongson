Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Jun 2009 18:53:52 +0100 (WEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:45358 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20021336AbZFBRxp (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 2 Jun 2009 18:53:45 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n52HrM8X004792;
	Tue, 2 Jun 2009 18:53:22 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n52HrMwd004791;
	Tue, 2 Jun 2009 18:53:22 +0100
Date:	Tue, 2 Jun 2009 18:53:22 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Imre Kaloz <kaloz@openwrt.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Remove standalone SiByte kernel support
Message-ID: <20090602175322.GD32078@linux-mips.org>
References: <1243945326-5029-1-git-send-email-kaloz@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1243945326-5029-1-git-send-email-kaloz@openwrt.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23185
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jun 02, 2009 at 02:22:06PM +0200, Imre Kaloz wrote:

> CFE is the only supported and used bootloader on the SiByte boards,
> the standalone kernel support has been never used outside Broadcom.
> Remove it and make the kernel use CFE by default.

Applied.  Kösönöm!

  Ralf
