Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Nov 2005 17:16:19 +0000 (GMT)
Received: from smtp102.biz.mail.re2.yahoo.com ([68.142.229.216]:41334 "HELO
	smtp102.biz.mail.re2.yahoo.com") by ftp.linux-mips.org with SMTP
	id S8133839AbVK3RP5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 30 Nov 2005 17:15:57 +0000
Received: (qmail 94018 invoked from network); 30 Nov 2005 16:27:01 -0000
Received: from unknown (HELO ?10.1.7.13?) (dan@embeddedalley.com@12.6.244.2 with plain)
  by smtp102.biz.mail.re2.yahoo.com with SMTP; 30 Nov 2005 16:27:01 -0000
In-Reply-To: <17AB476A04B7C842887E0EB1F268111E027190@xpserver.intra.lexbox.org>
References: <17AB476A04B7C842887E0EB1F268111E027190@xpserver.intra.lexbox.org>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <cf72b856706166dfcfc3de18af976400@embeddedalley.com>
Content-Transfer-Encoding: 7bit
Cc:	<linux-mips@linux-mips.org>
From:	Dan Malek <dan@embeddedalley.com>
Subject: Re: DbAu1550 copy file corruption
Date:	Wed, 30 Nov 2005 11:27:16 -0500
To:	"David Sanchez" <david.sanchez@lexbox.fr>
X-Mailer: Apple Mail (2.623)
Return-Path: <dan@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9569
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@embeddedalley.com
Precedence: bulk
X-list: linux-mips


On Nov 30, 2005, at 5:14 AM, David Sanchez wrote:

> On my DbAu155 + Sata HDD on PDC20579 + Linux Kernel 2.6.10 + busybox

Are you sure your disk interface is working properly?
Have you tested this on an NFS partition?  Does
the on-board HPT371 work?  I know the latter two
used to work, but I don't remember testing a 2.6.10
kernel, I've been using newer ones.


	-- Dan
