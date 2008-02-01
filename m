Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Feb 2008 12:21:55 +0000 (GMT)
Received: from bobafett.staff.proxad.net ([213.228.1.121]:57730 "EHLO
	bobafett.staff.proxad.net") by ftp.linux-mips.org with ESMTP
	id S20027576AbYBAMVp (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 1 Feb 2008 12:21:45 +0000
Received: from localhost (localhost [127.0.0.1])
	by bobafett.staff.proxad.net (Postfix) with ESMTP id 12E832868E;
	Fri,  1 Feb 2008 13:21:45 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at staff.proxad.net
Received: from bobafett.staff.proxad.net ([127.0.0.1])
	by localhost (bobafett.staff.proxad.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id wqPvvLOgxsTe; Fri,  1 Feb 2008 13:21:43 +0100 (CET)
Received: from nschichan.priv.staff.proxad.net (nschichan.priv.staff.proxad.net [172.18.3.120])
	by bobafett.staff.proxad.net (Postfix) with ESMTP id D7E67CE8C;
	Fri,  1 Feb 2008 13:21:43 +0100 (CET)
From:	Nicolas Schichan <nschichan@freebox.fr>
Organization: Freebox
To:	"Chris Friesen" <cfriesen@nortel.com>
Subject: Re: kexec on SMP mips64?
Date:	Fri, 1 Feb 2008 13:21:43 +0100
User-Agent: KMail/1.9.6
References: <47A21286.3020009@nortel.com>
In-Reply-To: <47A21286.3020009@nortel.com>
Cc:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200802011321.43399.nschichan@freebox.fr>
Return-Path: <nschichan@freebox.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18164
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nschichan@freebox.fr
Precedence: bulk
X-list: linux-mips

On Thursday 31 January 2008 19:25:10 you wrote:

Hi,

> We're starting work on an embedded highly-available product using dual
> Octeon cpus, and I'm looking into the possibility of using kexec/kdump
> as a "flight recorder" to dump fault information to a persistant storage
> location.
>
> I saw the patch adding initial support for kexec, but I was curious
> about the current status.  Is anyone using kexec for mips64 SMP systems?
>   Is it known to be broken?  I'm just trying to get a feel for how much
> work might be involved.

The code used to work on the 32bit mips board I have access to, but as far as 
I know it has not been tested on 64bit. I have not tested it on SMP, but 
chances are that kexec on mips is broken here too.

Regards,

-- 
Nicolas Schichan
