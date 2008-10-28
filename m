Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Oct 2008 16:22:10 +0000 (GMT)
Received: from h4.dl5rb.org.uk ([81.2.74.4]:58004 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S22594491AbYJ1QWA (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 28 Oct 2008 16:22:00 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m9SGLq77000810;
	Tue, 28 Oct 2008 16:21:52 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m9SGLqJi000808;
	Tue, 28 Oct 2008 16:21:52 GMT
Date:	Tue, 28 Oct 2008 16:21:52 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	David Daney <ddaney@caviumnetworks.com>, linux-mips@linux-mips.org,
	Tomaso Paoletti <tpaoletti@caviumnetworks.com>
Subject: Re: [PATCH 11/36] MIPSR2 ebase isn't just CAC_BASE
Message-ID: <20081028162152.GB349@linux-mips.org>
References: <1225152181-3221-4-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-5-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-6-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-7-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-8-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-9-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-10-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-11-git-send-email-ddaney@caviumnetworks.com> <20081028095655.GB18610@linux-mips.org> <alpine.LFD.1.10.0810281604250.27396@ftp.linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0810281604250.27396@ftp.linux-mips.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21062
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Oct 28, 2008 at 04:05:34PM +0000, Maciej W. Rozycki wrote:

> > Another thing I noticed is that we don't use write_c0_ebase(), so the
> > firmware better setup this correctly or we crash and burn.  We better
> > should initialize that right ...
> 
>  Well, your version still does not do it...

Intentional omission.  We didn't do that before and Cavium didn't seem to
need it so we can put off fixing that for a little longer.  It needs a
little thought to get NUMA right ...

  Ralf
