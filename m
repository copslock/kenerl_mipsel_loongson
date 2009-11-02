Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Nov 2009 07:49:14 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:51913 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1492638AbZKBGtL (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 2 Nov 2009 07:49:11 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nA26oZq3014317;
	Mon, 2 Nov 2009 07:50:35 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nA26oYqc014308;
	Mon, 2 Nov 2009 07:50:34 +0100
Date:	Mon, 2 Nov 2009 07:50:34 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Arnaud Patard <apatard@mandriva.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Fix ppoll on o32 with 64bit kernel
Message-ID: <20091102065033.GA13360@linux-mips.org>
References: <m363aa8o70.fsf@anduin.mandriva.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m363aa8o70.fsf@anduin.mandriva.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24602
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Oct 20, 2009 at 10:27:47AM +0200, Arnaud Patard wrote:

> sys_ppoll syscall needs to use a compat handler on 64bit kernels with
> o32 user-space. This patch wires it.
> 
> Signed-off-by: Arnaud Patard <apatard@mandriva.com>

Cute.  This one applies to all kernel from 2.6.16 up.

Applied, thanks!

  Ralf
