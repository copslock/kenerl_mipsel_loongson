Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Dec 2002 17:20:34 +0100 (CET)
Received: from nixon.xkey.com ([209.245.148.124]:11949 "HELO nixon.xkey.com")
	by linux-mips.org with SMTP id <S8225193AbSLJQUd>;
	Tue, 10 Dec 2002 17:20:33 +0100
Received: (qmail 2935 invoked from network); 10 Dec 2002 16:20:31 -0000
Received: from localhost (HELO localhost.conservativecomputer.com) (127.0.0.1)
  by localhost with SMTP; 10 Dec 2002 16:20:31 -0000
Received: (from lindahl@localhost)
	by localhost.conservativecomputer.com (8.11.6/8.11.0) id gBAGJb802600
	for linux-mips@linux-mips.org; Tue, 10 Dec 2002 08:19:37 -0800
X-Authentication-Warning: localhost.localdomain: lindahl set sender to lindahl@keyresearch.com using -f
Date: Tue, 10 Dec 2002 08:19:37 -0800
From: Greg Lindahl <lindahl@keyresearch.com>
To: linux-mips@linux-mips.org
Subject: Re: R_MIPS_26 etc.
Message-ID: <20021210081937.A2596@wumpus.attbi.com>
Mail-Followup-To: linux-mips@linux-mips.org
References: <ECEPLLMMNGHMFBLHCLMAAECMDGAA.yaelgilad@myrealbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <ECEPLLMMNGHMFBLHCLMAAECMDGAA.yaelgilad@myrealbox.com>; from yaelgilad@myrealbox.com on Tue, Dec 10, 2002 at 06:11:14PM +0200
Return-Path: <lindahl@keyresearch.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 840
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lindahl@keyresearch.com
Precedence: bulk
X-list: linux-mips

On Tue, Dec 10, 2002 at 06:11:14PM +0200, yaelgilad wrote:

> Looking in the assembly code of my driver, I see the following
> pattern repeating with every function call.
>     4ce4: 0c000000  jal 0
>       4ce4: R_MIPS_26 rx_wait_packet
> (R_MIPS_26 is sometimes replaces by a similar command)
> What is R_MIPS_26 ? What are the rest of them ?

R_MIPS_26 is a relocation. The jal command has 26 bits available for
the address. BTW, you should mention when you are showing objdump
output instead of the .s emitted by the compiler...

g
