Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Apr 2003 21:49:51 +0100 (BST)
Received: from p508B5EC1.dip.t-dialin.net ([IPv6:::ffff:80.139.94.193]:59322
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225211AbTDVUtu>; Tue, 22 Apr 2003 21:49:50 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h3MKncq05654;
	Tue, 22 Apr 2003 22:49:38 +0200
Date: Tue, 22 Apr 2003 22:49:38 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Pete Popov <ppopov@mvista.com>
Cc: baitisj@evolution.com,
	Linux MIPS mailing list <linux-mips@linux-mips.org>
Subject: Re: Improperly handled case in arch/mips/au1000/common/time.c
Message-ID: <20030422224938.A5591@linux-mips.org>
References: <20030422125450.E10148@luca.pas.lab> <1051042821.511.296.camel@zeus.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1051042821.511.296.camel@zeus.mvista.com>; from ppopov@mvista.com on Tue, Apr 22, 2003 at 01:20:21PM -0700
Return-Path: <ralf@linux-mips.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2136
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Apr 22, 2003 at 01:20:21PM -0700, Pete Popov wrote:

> Thanks, I'll get to this this week. Are there other outstanding Au
> patches that you have sent me and I haven't applied yet? I just got back
> from vacation so I'll get to them.

I dealt with a few bugs introduced by the Great Cache Hackery; aside of
that I don't think there is much pending.

  Ralf
