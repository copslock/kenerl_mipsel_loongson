Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Sep 2003 12:31:00 +0100 (BST)
Received: from p508B5D2A.dip.t-dialin.net ([IPv6:::ffff:80.139.93.42]:18122
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225348AbTIILa6>; Tue, 9 Sep 2003 12:30:58 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h89BUnLT006799;
	Tue, 9 Sep 2003 13:30:49 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h89BUmqN006798;
	Tue, 9 Sep 2003 13:30:48 +0200
Date: Tue, 9 Sep 2003 13:30:48 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Keith M Wesolowski <wesolows@foobazco.org>
Cc: linux-mips@linux-mips.org
Subject: Re: PATCH: avoid glibc conflict
Message-ID: <20030909113048.GD6715@linux-mips.org>
References: <20030828043112.GA11094@foobazco.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030828043112.GA11094@foobazco.org>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3142
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Aug 27, 2003 at 09:31:12PM -0700, Keith M Wesolowski wrote:

> This is needed to avoid a conflict with glibc on bigendian platforms
> when -O or higher is specified.  It's already in 2.6, and I'm not sure
> why it hasn't been seen in 2.4.  The symptom is that this program will
> not compile with -O2:
> 
> #include <asm/byteorder.h>
> #include <netinet/in.h>
> int main () { }
> 
> Here's the patch.

I sent one to Marcelo.

  Ralf
