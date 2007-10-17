Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Oct 2007 15:09:25 +0100 (BST)
Received: from mx3.mail.elte.hu ([157.181.1.138]:57805 "EHLO mx3.mail.elte.hu")
	by ftp.linux-mips.org with ESMTP id S20029190AbXJQOJP (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 17 Oct 2007 15:09:15 +0100
Received: from elvis.elte.hu ([157.181.1.14])
	by mx3.mail.elte.hu with esmtp (Exim)
	id 1Ii9aE-0000J0-Po
	from <mingo@elte.hu>; Wed, 17 Oct 2007 16:09:14 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id A7E473E2160; Wed, 17 Oct 2007 16:09:07 +0200 (CEST)
Date:	Wed, 17 Oct 2007 16:09:11 +0200
From:	Ingo Molnar <mingo@elte.hu>
To:	Dhaval Giani <dhaval@linux.vnet.ibm.com>
Cc:	Ralf Baechle <ralf@linux-mips.org>, torvalds@linux-foundation.org,
	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
	Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] Fix build breakage if !SYSFS
Message-ID: <20071017140911.GA4798@elte.hu>
References: <20071016130231.GA10778@linux-mips.org> <20071016174016.GC5693@linux.vnet.ibm.com> <20071016190044.GA24696@linux-mips.org> <20071017051611.GA11422@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071017051611.GA11422@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Received-SPF: neutral (mx3: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -1.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.5 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.1.7-deb
	-1.5 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Return-Path: <mingo@elte.hu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17090
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mingo@elte.hu
Precedence: bulk
X-list: linux-mips


* Dhaval Giani <dhaval@linux.vnet.ibm.com> wrote:

> Could you please include this patch to fix the build breakage?

thanks - i've added this to the scheduler patch-queue.

	Ingo
