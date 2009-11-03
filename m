Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Nov 2009 05:25:53 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:59173 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1491894AbZKCEZs (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 3 Nov 2009 05:25:48 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nA34RDqW015257;
	Tue, 3 Nov 2009 05:27:13 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nA34RCOe015255;
	Tue, 3 Nov 2009 05:27:12 +0100
Date:	Tue, 3 Nov 2009 05:27:12 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Emulate 64-bit FPU on 64-bit CPUs.
Message-ID: <20091103042712.GA14423@linux-mips.org>
References: <1257190426-29346-1-git-send-email-ddaney@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1257190426-29346-1-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24628
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Nov 02, 2009 at 11:33:46AM -0800, David Daney wrote:

> Running a 64-bit kernel on a 64-bit CPU without an FPU would cause the
> emulator to run in 32-bit mode.  The c0_Status.FR bit is wired to zero
> on systems without an FPU, so using that bit to decide how the
> emulator behaves doesn't allow for proper emulation on 64-bit FPU-less
> processors.
> 
> Instead, we need to select the emulator mode based on the user-space
> ABI.  Since the thread flag TIF_32BIT_REGS is used to set
> c0_Status.FR, we can just use it to decide if the emulator should be
> in 32-bit or 64-bit mode.

Thanks, applied!

  Ralf
