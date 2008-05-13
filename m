Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 May 2008 00:25:23 +0100 (BST)
Received: from vigor.karmaclothing.net ([217.169.26.28]:8389 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20023867AbYEMXZT (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 14 May 2008 00:25:19 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m4DNP8UV000768;
	Wed, 14 May 2008 00:25:08 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m4DNP7Hs000755;
	Wed, 14 May 2008 00:25:07 +0100
Date:	Wed, 14 May 2008 00:25:07 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@helsinki.fi>
Cc:	linux-mips@linux-mips.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH RESEND] [MIPS]: multi-statement if() seems to be
	missing braces
Message-ID: <20080513232507.GA24102@linux-mips.org>
References: <Pine.LNX.4.64.0805131444360.15369@wrl-59.cs.helsinki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.64.0805131444360.15369@wrl-59.cs.helsinki.fi>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19261
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, May 13, 2008 at 02:50:50PM +0300, Ilpo Järvinen wrote:

> In case this is a genuine bug, somebody else more familiar
> with that stuff should evaluate it's effects (I just found it
> by some shell pipeline and it seems suspicious looking).

Should be fairly as proven by practice; it's there since day of of 64-bit
pagetable for 32-bit hw support which was November 29, 2004.

  Ralf
