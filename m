Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Feb 2008 12:32:08 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:19145 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28577432AbYBVMcG (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 22 Feb 2008 12:32:06 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m1MCW55B018128;
	Fri, 22 Feb 2008 12:32:06 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m1MCW5rZ018127;
	Fri, 22 Feb 2008 12:32:05 GMT
Date:	Fri, 22 Feb 2008 12:32:05 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Anirban Sinha <ASinha@zeugmasystems.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: kdb patches?!
Message-ID: <20080222123205.GC17312@linux-mips.org>
References: <DDFD17CC94A9BD49A82147DDF7D545C5842C91@exchange.ZeugmaSystems.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DDFD17CC94A9BD49A82147DDF7D545C5842C91@exchange.ZeugmaSystems.local>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18289
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Feb 21, 2008 at 01:08:26PM -0800, Anirban Sinha wrote:

> I know this has been previously discussed in the mailing list but since
> the last relevant post I see was Sept 2005, I ask again:
> 
> Has anyone done any work regarding porting kdb (*not* kgdb) patches to
> mips? Is there any recent (or hope of any future) work in this space? 

I've taken a stab at porting kdb in late 2004.  I still have the patches
sitting somewhere.  Various others seem tohave taken a stab at porting
kdn later on.

  Ralf
