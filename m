Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Oct 2008 16:27:54 +0000 (GMT)
Received: from h4.dl5rb.org.uk ([81.2.74.4]:41868 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S22594626AbYJ1Q1o (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 28 Oct 2008 16:27:44 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m9SGRfq8000943;
	Tue, 28 Oct 2008 16:27:41 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m9SGRf48000941;
	Tue, 28 Oct 2008 16:27:41 GMT
Date:	Tue, 28 Oct 2008 16:27:41 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Chad Reese <kreese@caviumnetworks.com>
Cc:	"Maciej W. Rozycki" <macro@linux-mips.org>,
	David Daney <ddaney@caviumnetworks.com>,
	linux-mips@linux-mips.org,
	Tomaso Paoletti <tpaoletti@caviumnetworks.com>
Subject: Re: [PATCH 11/36] MIPSR2 ebase isn't just CAC_BASE
Message-ID: <20081028162741.GC349@linux-mips.org>
References: <1225152181-3221-5-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-6-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-7-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-8-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-9-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-10-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-11-git-send-email-ddaney@caviumnetworks.com> <20081028095655.GB18610@linux-mips.org> <alpine.LFD.1.10.0810281604250.27396@ftp.linux-mips.org> <49073A38.3070808@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49073A38.3070808@caviumnetworks.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21063
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Oct 28, 2008 at 09:13:44AM -0700, Chad Reese wrote:

> From an Octeon perspective, we'd prefer that the kernel not touch ebase
> as we set it in the bootloader. The bootloader sets the proper value
> based on the number of kernels being loaded and which cores the kernel
> is loaded on. This allows some interesting things, like running 16
> kernels each on a different CPU. Although 16 kernels is just a toy
> project, we have a number of customers that run two kernels. They choose
> which cores the kernels run on dynamically at boot time.

I see your point.  If we dynamically allocate memory for exception handlers
at run-time and point ebase to it multi-kernel systems should till work
unless maybe the firmware gets disturbed by such a change of ebase.

  Ralf
