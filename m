Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Nov 2002 02:42:22 +0100 (CET)
Received: from nixon.xkey.com ([209.245.148.124]:44717 "HELO nixon.xkey.com")
	by linux-mips.org with SMTP id <S1124139AbSKNBmV>;
	Thu, 14 Nov 2002 02:42:21 +0100
Received: (qmail 4254 invoked from network); 14 Nov 2002 01:42:13 -0000
Received: from localhost (HELO localhost.conservativecomputer.com) (127.0.0.1)
  by localhost with SMTP; 14 Nov 2002 01:42:13 -0000
Received: (from lindahl@localhost)
	by localhost.conservativecomputer.com (8.11.6/8.11.0) id gAE1g0a02920
	for linux-mips@linux-mips.org; Wed, 13 Nov 2002 17:42:00 -0800
X-Authentication-Warning: localhost.localdomain: lindahl set sender to lindahl@keyresearch.com using -f
Date: Wed, 13 Nov 2002 17:42:00 -0800
From: Greg Lindahl <lindahl@keyresearch.com>
To: linux-mips@linux-mips.org
Subject: explain to me how this works...
Message-ID: <20021113174200.A2874@wumpus.internal.keyresearch.com>
Mail-Followup-To: linux-mips@linux-mips.org
References: <20021005095335.B4079@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021005095335.B4079@lucon.org>; from hjl@lucon.org on Sat, Oct 05, 2002 at 09:53:35AM -0700
Return-Path: <lindahl@keyresearch.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 635
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lindahl@keyresearch.com
Precedence: bulk
X-list: linux-mips

I have a 64-bit kernel and O32 userland.

I notice that arping gets confused because the syscall socket() is
returning 4183 instead of a reasonable value like 3... if strace()
isn't lying to me.

How do I debug this? The O32 userland calls through the socketcall()
syscall. It looks OK.

greg
