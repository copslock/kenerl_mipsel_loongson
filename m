Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Nov 2002 22:51:13 +0100 (CET)
Received: from nixon.xkey.com ([209.245.148.124]:32905 "HELO nixon.xkey.com")
	by linux-mips.org with SMTP id <S1124131AbSKNVvM>;
	Thu, 14 Nov 2002 22:51:12 +0100
Received: (qmail 9181 invoked from network); 14 Nov 2002 21:51:05 -0000
Received: from localhost (HELO localhost.conservativecomputer.com) (127.0.0.1)
  by localhost with SMTP; 14 Nov 2002 21:51:05 -0000
Received: (from lindahl@localhost)
	by localhost.conservativecomputer.com (8.11.6/8.11.0) id gAELopv01982
	for linux-mips@linux-mips.org; Thu, 14 Nov 2002 13:50:51 -0800
X-Authentication-Warning: localhost.localdomain: lindahl set sender to lindahl@keyresearch.com using -f
Date: Thu, 14 Nov 2002 13:50:51 -0800
From: Greg Lindahl <lindahl@keyresearch.com>
To: linux-mips@linux-mips.org
Subject: Re: explain to me how this works...
Message-ID: <20021114135051.D1896@wumpus.internal.keyresearch.com>
Mail-Followup-To: linux-mips@linux-mips.org
References: <20021005095335.B4079@lucon.org> <20021113174200.A2874@wumpus.internal.keyresearch.com> <20021114193924.A5610@linux-mips.org> <20021114113045.D1494@wumpus.internal.keyresearch.com> <20021114120746.E28717@mvista.com> <20021114211251.C5610@linux-mips.org> <20021114131232.B1706@wumpus.internal.keyresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021114131232.B1706@wumpus.internal.keyresearch.com>; from lindahl@keyresearch.com on Thu, Nov 14, 2002 at 01:12:32PM -0800
Return-Path: <lindahl@keyresearch.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 648
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lindahl@keyresearch.com
Precedence: bulk
X-list: linux-mips

On Thu, Nov 14, 2002 at 01:12:32PM -0800, Greg Lindahl wrote:

> socket(PF_PACKET, SOCK_DGRAM, 0)        = 4183
> socket(PF_PACKET, SOCK_DGRAM, 0)        = 4183
> socket(PF_PACKET, SOCK_DGRAM, 0)        = -1 EAFNOSUPPORT (Address family not supported by protocol)

strace is useless.

My problem was that CONFIG_PACKET was not set in my .config, which causes
EAFNOSUPPORT.

-- greg
