Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 May 2009 00:33:57 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:39087 "EHLO
	localhost.localdomain" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20024385AbZERXdy (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 19 May 2009 00:33:54 +0100
Date:	Tue, 19 May 2009 00:33:54 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	David Daney <ddaney@caviumnetworks.com>
cc:	Ralf Baechle <ralf@linux-mips.org>,
	David VomLehn <dvomlehn@cisco.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Fold the TLB refill at the vmalloc path if
 possible
In-Reply-To: <4A11EEBF.8020007@caviumnetworks.com>
Message-ID: <alpine.LFD.1.10.0905190029410.20791@ftp.linux-mips.org>
References: <1242168316-4009-1-git-send-email-ddaney@caviumnetworks.com> <20090513002337.GA12536@cuplxvomd02.corp.sa.net> <4A0A1E6B.6050908@caviumnetworks.com> <alpine.LFD.1.10.0905160706300.12158@ftp.linux-mips.org> <4A118BE8.50201@caviumnetworks.com>
 <alpine.LFD.1.10.0905181829270.20791@ftp.linux-mips.org> <alpine.LFD.1.10.0905182011260.20791@ftp.linux-mips.org> <4A11EEBF.8020007@caviumnetworks.com>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22808
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, 18 May 2009, David Daney wrote:

> Unless you have an objection, I will test this, forward ported to the HEAD and
> modified to work with my patch that gets rid of all the magic numbers.  And
> then send the result to Ralf.

 Excellent -- thanks a lot!  And yes, getting rid of the magic numbers is 
a jolly good idea -- they work well until you discover you need to adjust 
them all at a time for some reason.

  Maciej
