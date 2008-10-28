Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Oct 2008 17:31:01 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:11450 "EHLO
	localhost.localdomain") by ftp.linux-mips.org with ESMTP
	id S22597152AbYJ1Ray (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 28 Oct 2008 17:30:54 +0000
Date:	Tue, 28 Oct 2008 17:30:54 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
cc:	David Daney <ddaney@caviumnetworks.com>, linux-mips@linux-mips.org,
	Tomaso Paoletti <tpaoletti@caviumnetworks.com>
Subject: Re: [PATCH 11/36] MIPSR2 ebase isn't just CAC_BASE
In-Reply-To: <20081028162152.GB349@linux-mips.org>
Message-ID: <alpine.LFD.1.10.0810281729470.27396@ftp.linux-mips.org>
References: <1225152181-3221-4-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-5-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-6-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-7-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-8-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-9-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-10-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-11-git-send-email-ddaney@caviumnetworks.com>
 <20081028095655.GB18610@linux-mips.org> <alpine.LFD.1.10.0810281604250.27396@ftp.linux-mips.org> <20081028162152.GB349@linux-mips.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21068
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, 28 Oct 2008, Ralf Baechle wrote:

> Intentional omission.  We didn't do that before and Cavium didn't seem to
> need it so we can put off fixing that for a little longer.  It needs a
> little thought to get NUMA right ...

 Fair enough, but it is left a bit ambiguous in your description.

  Maciej
