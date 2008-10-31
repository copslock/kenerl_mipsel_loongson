Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 01 Nov 2008 08:42:22 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:703 "EHLO
	localhost.localdomain") by ftp.linux-mips.org with ESMTP
	id S22832094AbYJaOYK (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 31 Oct 2008 14:24:10 +0000
Date:	Fri, 31 Oct 2008 14:24:10 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Kumba <kumba@gentoo.org>
cc:	gcc-patches@gcc.gnu.org,
	Richard Sandiford <rdsandiford@googlemail.com>,
	Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: [PATCH]: R10000 Needs LL/SC Workaround in Gcc
In-Reply-To: <490A90F4.6040601@gentoo.org>
Message-ID: <alpine.LFD.1.10.0810311420320.11348@ftp.linux-mips.org>
References: <490A90F4.6040601@gentoo.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21149
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, 31 Oct 2008, Kumba wrote:

> Feedback would be welcome on any suggestions for improving this patch (please
> CC, as I'm not subscribed to the ML).

 Please make it run-time selectable, aggregating all the workarounds for 
the R10000 under -mfix-r10000, similarly to how it is done for other 
silicon errata.  You probably want it on by default for -march=r10000 (but 
not necessarily -march=r12000).  You need to supply a suitable 
documentation update too.

  Maciej
