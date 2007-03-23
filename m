Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Mar 2007 16:15:24 +0000 (GMT)
Received: from sakura.staff.proxad.net ([213.228.1.107]:15496 "EHLO
	sakura.staff.proxad.net") by ftp.linux-mips.org with ESMTP
	id S20022415AbXCWQPU (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 23 Mar 2007 16:15:20 +0000
Received: from max by sakura.staff.proxad.net with local (Exim 3.36 #1 (Debian))
	id 1HUmMu-00086t-00; Fri, 23 Mar 2007 17:11:56 +0100
Subject: RE: flush_anon_page for MIPS
From:	Maxime Bizon <mbizon@freebox.fr>
Reply-To: mbizon@freebox.fr
To:	Ravi Pratap <Ravi.Pratap@hillcrestlabs.com>
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, miklos@szeredi.hu,
	linux-mips@linux-mips.org
In-Reply-To: <36E4692623C5974BA6661C0B18EE8EDF6CD391@MAILSERV.hcrest.com>
References: <36E4692623C5974BA6661C0B18EE8EDF6CD391@MAILSERV.hcrest.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Freebox
Date:	Fri, 23 Mar 2007 17:11:55 +0100
Message-Id: <1174666315.30432.7.camel@sakura.staff.proxad.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Return-Path: <mbizon@freebox.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14642
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mbizon@freebox.fr
Precedence: bulk
X-list: linux-mips


On Fri, 2007-03-23 at 11:59 -0400, Ravi Pratap wrote:

> > What processor does it fail on?

> # cat /proc/cpuinfo
> system type             : Sigma Designs TangoX

Same processor, same problem:

Primary instruction cache 16kB, physically tagged, 2-way, linesize 16 bytes.
Primary data cache 16kB, 2-way, linesize 16 bytes.

-- 
Maxime
