Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Nov 2002 20:31:06 +0100 (CET)
Received: from nixon.xkey.com ([209.245.148.124]:39906 "HELO nixon.xkey.com")
	by linux-mips.org with SMTP id <S1122118AbSKNTbG>;
	Thu, 14 Nov 2002 20:31:06 +0100
Received: (qmail 14124 invoked from network); 14 Nov 2002 19:30:59 -0000
Received: from localhost (HELO localhost.conservativecomputer.com) (127.0.0.1)
  by localhost with SMTP; 14 Nov 2002 19:30:59 -0000
Received: (from lindahl@localhost)
	by localhost.conservativecomputer.com (8.11.6/8.11.0) id gAEJUj601609
	for linux-mips@linux-mips.org; Thu, 14 Nov 2002 11:30:45 -0800
X-Authentication-Warning: localhost.localdomain: lindahl set sender to lindahl@keyresearch.com using -f
Date: Thu, 14 Nov 2002 11:30:45 -0800
From: Greg Lindahl <lindahl@keyresearch.com>
To: linux-mips@linux-mips.org
Subject: Re: explain to me how this works...
Message-ID: <20021114113045.D1494@wumpus.internal.keyresearch.com>
Mail-Followup-To: linux-mips@linux-mips.org
References: <20021005095335.B4079@lucon.org> <20021113174200.A2874@wumpus.internal.keyresearch.com> <20021114193924.A5610@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021114193924.A5610@linux-mips.org>; from ralf@linux-mips.org on Thu, Nov 14, 2002 at 07:39:24PM +0100
Return-Path: <lindahl@keyresearch.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 644
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lindahl@keyresearch.com
Precedence: bulk
X-list: linux-mips

On Thu, Nov 14, 2002 at 07:39:24PM +0100, Ralf Baechle wrote:

> Eh?  Nothing on MIPS should use socketcall(2);

OK, so let's say it's using socket(). How do I go about debugging
this? I mean, I can start sprinkling printks all over the place, but is
there a more clever way?

greg
