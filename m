Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Jun 2003 00:15:54 +0100 (BST)
Received: from p508B7EE4.dip.t-dialin.net ([IPv6:::ffff:80.139.126.228]:21723
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225252AbTFDXPw>; Thu, 5 Jun 2003 00:15:52 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h54NFnbY029013;
	Wed, 4 Jun 2003 16:15:49 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h54NFmww029012;
	Thu, 5 Jun 2003 01:15:48 +0200
Date: Thu, 5 Jun 2003 01:15:47 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Jun Sun <jsun@mvista.com>
Cc: linux-mips@linux-mips.org
Subject: Re: [RFC] synchronized CPU count registers on SMP machines
Message-ID: <20030604231547.GA22410@linux-mips.org>
References: <20030604153930.H19122@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030604153930.H19122@mvista.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2525
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jun 04, 2003 at 03:39:30PM -0700, Jun Sun wrote:

> 1) clocks on different CPUs don't have the same frequency
> 2) clocks on different CPUs drift to each other
> 2) some fancy power saving feature such as frequency scaling
> 
> But I think for a foreseeable future most MIPS SMP machines
> don't have the above issues (true?).  And it is probably worthwile
> to synchronize count registers for them.

1) and 2) affect most SGI systems.

  Ralf
