Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Oct 2008 00:45:14 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:41886 "EHLO
	localhost.localdomain") by ftp.linux-mips.org with ESMTP
	id S21520835AbYJNXpG (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 15 Oct 2008 00:45:06 +0100
Date:	Wed, 15 Oct 2008 00:45:05 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	David Daney <ddaney@caviumnetworks.com>
cc:	linux-mips@linux-mips.org, dvomlehn@cisco.com,
	"Paoletti, Tomaso" <Tomaso.Paoletti@caviumnetworks.com>
Subject: Re: [PATCH] MIPS: Rewrite cpu_to_name so it has one statement per
 line (version 2).
In-Reply-To: <48F51BF7.2040906@caviumnetworks.com>
Message-ID: <alpine.LFD.1.10.0810150042090.18823@ftp.linux-mips.org>
References: <48F51BF7.2040906@caviumnetworks.com>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20766
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, 14 Oct 2008, David Daney wrote:

> Rewrite cpu_to_name so it has one statement per line.
> 
> David VomLehn shamed me into it...
> 
> Future changes can now pass checkpatch.pl
> 
> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
> ---
> arch/mips/kernel/cpu-probe.c |  156 +++++++++++++++++++++--------------------
> 1 files changed, 80 insertions(+), 76 deletions(-)

Acked-by: Maciej W. Rozycki <macro@linux-mips.org>

 I like this one -- you've got my blessing for what it's worth.

  Maciej
