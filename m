Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Sep 2005 15:54:12 +0100 (BST)
Received: from smtp102.biz.mail.mud.yahoo.com ([IPv6:::ffff:68.142.200.237]:21182
	"HELO smtp102.biz.mail.mud.yahoo.com") by linux-mips.org with SMTP
	id <S8224903AbVITOxw>; Tue, 20 Sep 2005 15:53:52 +0100
Received: (qmail 5629 invoked from network); 20 Sep 2005 14:53:44 -0000
Received: from unknown (HELO ?192.168.1.105?) (ppopov@embeddedalley.com@63.194.214.47 with plain)
  by smtp102.biz.mail.mud.yahoo.com with SMTP; 20 Sep 2005 14:53:44 -0000
Subject: Re: CVS Update@linux-mips.org: linux
From:	Pete Popov <ppopov@embeddedalley.com>
Reply-To: ppopov@embeddedalley.com
To:	Jerry <jerry@wicomtechnologies.com>
Cc:	"ppopov@linux-mips.org" <linux-mips@linux-mips.org>
In-Reply-To: <477557788.20050920111957@wicomtechnologies.com>
References: <20050920002016Z8225531-3678+9789@linux-mips.org>
	 <477557788.20050920111957@wicomtechnologies.com>
Content-Type: text/plain
Organization: Embedded Alley Solutions, Inc
Date:	Tue, 20 Sep 2005 07:53:48 -0700
Message-Id: <1127228028.4948.228.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8998
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips

On Tue, 2005-09-20 at 11:19 +0300, Jerry wrote:
> >[In reply to "CVS Update@linux-mips.org: linux" from ppopov@linux-mips.org <ppopov@linux-mips.org> to linux-cvs@linux-mips.org <linux-cvs@linux-mips.org>  20.09.2005 3:20]
> 
> > Log message:
> >         Au1200 fb driver. Updated db1200 defconfig to include driver by
> >         default.
> 
> Looks like a some early versions. Anyway good news that i'is in the
> tree. The bad news that it mostly unusable and needs a lot of work.
> (I don't think one can use it with IOCTL code defined in .c file :) )

What's mostly unusable? I only did cosmetic cleanups of this one and
gave it a quick test. Seemed to work fine. Let me know what you've
tested and didn't work for you and we'll fix it at some point.

> All society now waits for mae driver.

Pete
