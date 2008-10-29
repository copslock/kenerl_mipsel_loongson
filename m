Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Oct 2008 19:24:47 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:31672 "EHLO
	localhost.localdomain") by ftp.linux-mips.org with ESMTP
	id S22676006AbYJ2TYo (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 29 Oct 2008 19:24:44 +0000
Date:	Wed, 29 Oct 2008 19:24:44 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	David Daney <ddaney@caviumnetworks.com>
cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	Tomaso Paoletti <tpaoletti@caviumnetworks.com>,
	Paul Gortmaker <Paul.Gortmaker@windriver.com>
Subject: Re: [PATCH 15/36] Probe for Cavium OCTEON CPUs.
In-Reply-To: <49088FF7.9060103@caviumnetworks.com>
Message-ID: <alpine.LFD.1.10.0810291915540.13373@ftp.linux-mips.org>
References: <1225152181-3221-8-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-9-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-10-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-11-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-12-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-13-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-14-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-15-git-send-email-ddaney@caviumnetworks.com>
 <20081029121737.GA26256@linux-mips.org> <49088CBF.8060109@caviumnetworks.com> <20081029162642.GC26256@linux-mips.org> <49088FF7.9060103@caviumnetworks.com>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21086
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 29 Oct 2008, David Daney wrote:

> R4400 and R10K have the watch registers, but they do not have mips semantics,
> so are not currently usable with the watch register support.   This is why I
> initially was very conservative about the conditions under which I probed
> watch registers.  So I think it is good to try to verify these things.

 Neither is a MIPS architecture processor -- they are legacy MIPS III and 
MIPS IV processors, respectively, and as such do not have a MIPS-compliant 
set of CP0 Config registers nor they support the select specifier for 
coprocessor transfer operations (although unlike some earlier 
implementations they do have a CP0.Config register).  Watchpoint support 
would have to be done specifically for them; as I have a moderate interest 
in it and I have R4000/R4400 hardware, I may look into it eventually (but 
then, I have meant so for some last six years or so, so...).  The same 
applies to the R4650 which defines watchpoints in yet a different way, but 
that one does not have an MMU, so we can safely skip it for the time 
being.

  Maciej
