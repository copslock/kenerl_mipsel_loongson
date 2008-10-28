Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Oct 2008 17:29:30 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:19385 "EHLO
	localhost.localdomain") by ftp.linux-mips.org with ESMTP
	id S22597141AbYJ1R3X (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 28 Oct 2008 17:29:23 +0000
Date:	Tue, 28 Oct 2008 17:29:23 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
cc:	Chad Reese <kreese@caviumnetworks.com>,
	David Daney <ddaney@caviumnetworks.com>,
	linux-mips@linux-mips.org,
	Tomaso Paoletti <tpaoletti@caviumnetworks.com>
Subject: Re: [PATCH 11/36] MIPSR2 ebase isn't just CAC_BASE
In-Reply-To: <20081028162741.GC349@linux-mips.org>
Message-ID: <alpine.LFD.1.10.0810281724550.27396@ftp.linux-mips.org>
References: <1225152181-3221-5-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-6-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-7-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-8-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-9-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-10-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-11-git-send-email-ddaney@caviumnetworks.com> <20081028095655.GB18610@linux-mips.org> <alpine.LFD.1.10.0810281604250.27396@ftp.linux-mips.org>
 <49073A38.3070808@caviumnetworks.com> <20081028162741.GC349@linux-mips.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21067
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, 28 Oct 2008, Ralf Baechle wrote:

> I see your point.  If we dynamically allocate memory for exception handlers
> at run-time and point ebase to it multi-kernel systems should till work
> unless maybe the firmware gets disturbed by such a change of ebase.

 A run-time sanity check would do I suppose.  I.e. that ebase points to 
somewhere within installed RAM and does not clash with the kernel in some 
way.  We can mark that page as reserved in the memory map then; something 
we ought to regardless and which I gather we do not at the moment.

  Maciej
