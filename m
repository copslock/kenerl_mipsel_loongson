Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Dec 2002 19:43:26 +0000 (GMT)
Received: from nixon.xkey.com ([IPv6:::ffff:209.245.148.124]:13752 "HELO
	nixon.xkey.com") by linux-mips.org with SMTP id <S8225353AbSLRTn0>;
	Wed, 18 Dec 2002 19:43:26 +0000
Received: (qmail 17036 invoked from network); 18 Dec 2002 19:43:23 -0000
Received: from localhost (HELO localhost.conservativecomputer.com) (127.0.0.1)
  by localhost with SMTP; 18 Dec 2002 19:43:23 -0000
Received: (from lindahl@localhost)
	by localhost.conservativecomputer.com (8.11.6/8.11.0) id gBIJgKT02223
	for linux-mips@linux-mips.org; Wed, 18 Dec 2002 11:42:20 -0800
X-Authentication-Warning: localhost.localdomain: lindahl set sender to lindahl@keyresearch.com using -f
Date: Wed, 18 Dec 2002 11:42:20 -0800
From: Greg Lindahl <lindahl@keyresearch.com>
To: linux mips mailing list <linux-mips@linux-mips.org>
Subject: Re: [PATCH]: fix compiler warnings in the math-emulator
Message-ID: <20021218114220.A2217@wumpus.internal.keyresearch.com>
Mail-Followup-To: linux mips mailing list <linux-mips@linux-mips.org>
References: <m2vg1rnrkg.fsf@demo.mitica> <Pine.GSO.3.96.1021218194246.5977G-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.3.96.1021218194246.5977G-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Wed, Dec 18, 2002 at 07:47:31PM +0100
Return-Path: <lindahl@keyresearch.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 958
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lindahl@keyresearch.com
Precedence: bulk
X-list: linux-mips

On Wed, Dec 18, 2002 at 07:47:31PM +0100, Maciej W. Rozycki wrote:

>  A few warnings are unavoidable -- e.g. there is no way to shut up gas
> complaining about macros expanding into multiple instructions in branch
> delay slots.  Too bad.

... why isn't that a bug?

greg
