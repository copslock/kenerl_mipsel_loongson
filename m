Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Nov 2005 17:55:44 +0000 (GMT)
Received: from web408.biz.mail.mud.yahoo.com ([68.142.201.39]:40598 "HELO
	web408.biz.mail.mud.yahoo.com") by ftp.linux-mips.org with SMTP
	id S3458471AbVKJRzZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 10 Nov 2005 17:55:25 +0000
Received: (qmail 44685 invoked by uid 60001); 10 Nov 2005 17:56:50 -0000
Message-ID: <20051110175650.44683.qmail@web408.biz.mail.mud.yahoo.com>
Received: from [64.163.129.139] by web408.biz.mail.mud.yahoo.com via HTTP; Thu, 10 Nov 2005 09:56:50 PST
Date:	Thu, 10 Nov 2005 09:56:50 -0800 (PST)
From:	Peter Popov <ppopov@embeddedalley.com>
Subject: Re: smc91x support
To:	Matej Kupljen <matej.kupljen@ultra.si>,
	"'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
In-Reply-To: <1131645167.1478.13.camel@orionlinux.starfleet.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9470
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips



> Wouldn't it be better to use SOC_AU1200 instead of
> SOC_AU1X00, because
> only AU1200 does not have integrated Ethernet
> controller?

Perhaps. But the Au1x could use it ... depending on
the HW design. Right now only the Db1200 has this
chip.

Pete
