Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Nov 2003 00:59:45 +0000 (GMT)
Received: from p508B62C3.dip.t-dialin.net ([IPv6:::ffff:80.139.98.195]:12491
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225402AbTKDA7d>; Tue, 4 Nov 2003 00:59:33 +0000
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id hA40xWsY031897;
	Tue, 4 Nov 2003 01:59:32 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id hA40xVIW031896;
	Tue, 4 Nov 2003 01:59:31 +0100
Date: Tue, 4 Nov 2003 01:59:31 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Dennis Castleman <Dennis.Castleman@zoran.com>
Cc: linux-mips@linux-mips.org
Subject: Re: MIPS 4KCE Core
Message-ID: <20031104005931.GB27415@linux-mips.org>
References: <56BEF0DBC8B9D611BFDB00508B5E263410313F@tlexmail.teralogic-inc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56BEF0DBC8B9D611BFDB00508B5E263410313F@tlexmail.teralogic-inc.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3570
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Nov 03, 2003 at 01:56:54PM -0800, Dennis Castleman wrote:

> Any body know if MIPS 4KEm is supported.
> 
> The 4KEm provides a simpler scheme (less expansive) for virtual to physical
> address translation. It is based on FMT (Fixed map translation) that
> provides a direct address translation that is not configurable.
> 
> Question is whether a 16 dual entries FMT as described above would be
> sufficient in order to run linux.   

Linux 2.6 supports something like if CONFIG_MMU is disabled which looks
like it could suit your particular type of application.  So far nobody
has made any attempt to get this to run on MIPS but doesn't look too hard.
This of course will have serious impact on userspace applications -
the ABI necessarily has to change if the MMU is gone.

  Ralf
