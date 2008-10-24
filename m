Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Oct 2008 20:56:56 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:475 "EHLO
	localhost.localdomain") by ftp.linux-mips.org with ESMTP
	id S22313091AbYJXT4w (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 24 Oct 2008 20:56:52 +0100
Date:	Fri, 24 Oct 2008 20:56:52 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	David Daney <ddaney@caviumnetworks.com>
cc:	linux-mips@linux-mips.org,
	Tomaso Paoletti <tpaoletti@caviumnetworks.com>
Subject: Re: [PATCH 11/37] Cavium OCTEON: ebase isn't just CAC_BASE
In-Reply-To: <1224809821-5532-12-git-send-email-ddaney@caviumnetworks.com>
Message-ID: <alpine.LFD.1.10.0810242054420.31223@ftp.linux-mips.org>
References: <1224809821-5532-1-git-send-email-ddaney@caviumnetworks.com> <1224809821-5532-12-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20950
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 23 Oct 2008, ddaney@caviumnetworks.com wrote:

> From: David Daney <ddaney@caviumnetworks.com>
> 
> On Cavium, the ebase isn't just CAC_BASE, but also the part of
> read_c0_ebase() too.

 How is that unique to CONFIG_CPU_CAVIUM_OCTEON?  That's a general feature 
of the MIPS revision 2 architecture, so please make it right from the 
beginning.  You'll avoid an ugly #ifdef this way too.

  Maciej
