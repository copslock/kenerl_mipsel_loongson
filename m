Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Oct 2008 21:13:02 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:15251 "EHLO
	localhost.localdomain") by ftp.linux-mips.org with ESMTP
	id S22314318AbYJXUMt (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 24 Oct 2008 21:12:49 +0100
Date:	Fri, 24 Oct 2008 21:12:49 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	David Daney <ddaney@caviumnetworks.com>
cc:	linux-mips@linux-mips.org,
	Tomaso Paoletti <tpaoletti@caviumnetworks.com>
Subject: Re: [PATCH 29/37] Don't clobber spinlocks in 8250.
In-Reply-To: <1224809821-5532-30-git-send-email-ddaney@caviumnetworks.com>
Message-ID: <alpine.LFD.1.10.0810242105160.31223@ftp.linux-mips.org>
References: <1224809821-5532-1-git-send-email-ddaney@caviumnetworks.com> <1224809821-5532-30-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20951
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 23 Oct 2008, ddaney@caviumnetworks.com wrote:

> From: David Daney <ddaney@caviumnetworks.com>
> 
> In serial8250_isa_init_ports(), the port's lock is initialized.  We
> should not overwrite it.  Only copy in the fields we need.

 I suggest you to send all the 8250 patches to 
linux-serial@vger.kernel.org and most probably the LKML.  I don't think 
the relevant maintainers read this list -- note that they will be the 
general Linux maintainers as the serial subsystem doesn't have a dedicated 
one at the moment.  Please always consult the MAINTAINERS file before 
posting patches (see Documentation/SubmittingPatches too).

  Maciej
