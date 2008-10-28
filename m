Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Oct 2008 16:05:36 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:16016 "EHLO
	localhost.localdomain") by ftp.linux-mips.org with ESMTP
	id S22593816AbYJ1QFe (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 28 Oct 2008 16:05:34 +0000
Date:	Tue, 28 Oct 2008 16:05:34 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
cc:	David Daney <ddaney@caviumnetworks.com>, linux-mips@linux-mips.org,
	Tomaso Paoletti <tpaoletti@caviumnetworks.com>
Subject: Re: [PATCH 11/36] MIPSR2 ebase isn't just CAC_BASE
In-Reply-To: <20081028095655.GB18610@linux-mips.org>
Message-ID: <alpine.LFD.1.10.0810281604250.27396@ftp.linux-mips.org>
References: <1225152181-3221-2-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-3-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-4-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-5-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-6-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-7-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-8-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-9-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-10-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-11-git-send-email-ddaney@caviumnetworks.com> <20081028095655.GB18610@linux-mips.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21058
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, 28 Oct 2008, Ralf Baechle wrote:

> Another thing I noticed is that we don't use write_c0_ebase(), so the
> firmware better setup this correctly or we crash and burn.  We better
> should initialize that right ...

 Well, your version still does not do it...

> So below my version which solves the first mentioned problem.  Just like
> the bitops patch I posted earlier today this patch has become entirely
> unrelated to the rest of the series so can applied before or after the
> rest of the series.

 Anyway this is much better than the original proposal indeed, thanks.

  Maciej
