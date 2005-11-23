Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Nov 2005 00:22:30 +0000 (GMT)
Received: from smtp102.biz.mail.re2.yahoo.com ([68.142.229.216]:52835 "HELO
	smtp102.biz.mail.re2.yahoo.com") by ftp.linux-mips.org with SMTP
	id S8134463AbVKWAWM (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 23 Nov 2005 00:22:12 +0000
Received: (qmail 75346 invoked from network); 23 Nov 2005 00:24:48 -0000
Received: from unknown (HELO ?192.168.253.28?) (dan@embeddedalley.com@209.113.146.155 with plain)
  by smtp102.biz.mail.re2.yahoo.com with SMTP; 23 Nov 2005 00:24:48 -0000
In-Reply-To: <20051123001534.GA18119@cosmic.amd.com>
References: <20051122221526.GZ18119@cosmic.amd.com> <6dabaec28e238ccc915f20f51ee28327@embeddedalley.com> <20051123001534.GA18119@cosmic.amd.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <968d9f47767cad14f9924abc1d07972b@embeddedalley.com>
Content-Transfer-Encoding: 7bit
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
From:	Dan Malek <dan@embeddedalley.com>
Subject: Re: Fix board type in db1x00
Date:	Tue, 22 Nov 2005 19:24:51 -0500
To:	"Jordan Crouse" <jordan.crouse@amd.com>
X-Mailer: Apple Mail (2.623)
Return-Path: <dan@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9544
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@embeddedalley.com
Precedence: bulk
X-list: linux-mips


On Nov 22, 2005, at 7:15 PM, Jordan Crouse wrote:

> ....  That means either the mess goes in here or it goes
> in asm-mips/mach-db1x00/db1x00.h,

You are already doing this for other things, like the BCSR
differences with the db1550.  Why not put it all on one place?
You could even generate out of the Kconfig process and
not need it in any file. :-)  The problem is if you propagate
stuff like this "...  because there isn't an include file ..." others
will also take that attitude.  Someone has to start the
process.  For something as generic as these boards, the
next one should simply be an include file update, not the
need to edit various source files as is necessary today.

Thanks.

	-- Dan
