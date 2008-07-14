Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Jul 2008 12:43:39 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:38806 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S28577518AbYGNLnh (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 14 Jul 2008 12:43:37 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m6EBhg9b026944;
	Mon, 14 Jul 2008 12:43:42 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m6EBhgs8026943;
	Mon, 14 Jul 2008 12:43:42 +0100
Date:	Mon, 14 Jul 2008 12:43:42 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Harald Krapfenbauer <krapfenbauer@ict.tuwien.ac.at>
Cc:	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: ptrace question
Message-ID: <20080714114342.GE10379@linux-mips.org>
References: <487B3242.60202@ict.tuwien.ac.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <487B3242.60202@ict.tuwien.ac.at>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19820
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jul 14, 2008 at 01:02:26PM +0200, Harald Krapfenbauer wrote:

> Hello,
> 
> If I write memory (maybe with instructions) of a traced application with
> the ptrace() call, are the caches invalidated automatically, i.e. can I
> assume that the processor uses the newly written values after continuing?

ptrace semantics requires PTRACE_POKETEXT to ensure I-cache coherency and
consistency.

  Ralf
