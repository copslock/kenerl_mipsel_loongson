Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Dec 2002 15:15:52 +0000 (GMT)
Received: from nixon.xkey.com ([209.245.148.124]:14742 "HELO nixon.xkey.com")
	by linux-mips.org with SMTP id <S8225268AbSLLPPw>;
	Thu, 12 Dec 2002 15:15:52 +0000
Received: (qmail 2104 invoked from network); 12 Dec 2002 15:15:48 -0000
Received: from localhost (HELO localhost.conservativecomputer.com) (127.0.0.1)
  by localhost with SMTP; 12 Dec 2002 15:15:48 -0000
Received: (from lindahl@localhost)
	by localhost.conservativecomputer.com (8.11.6/8.11.0) id gBCFErx02816
	for linux-mips@linux-mips.org; Thu, 12 Dec 2002 07:14:53 -0800
X-Authentication-Warning: localhost.localdomain: lindahl set sender to lindahl@keyresearch.com using -f
Date: Thu, 12 Dec 2002 07:14:53 -0800
From: Greg Lindahl <lindahl@keyresearch.com>
To: linux-mips@linux-mips.org
Subject: Re: R_MIPS_26 etc.
Message-ID: <20021212071453.A1895@wumpus.attbi.com>
Mail-Followup-To: linux-mips@linux-mips.org
References: <ECEPLLMMNGHMFBLHCLMAOEDMDGAA.yaelgilad@myrealbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <ECEPLLMMNGHMFBLHCLMAOEDMDGAA.yaelgilad@myrealbox.com>; from yaelgilad@myrealbox.com on Thu, Dec 12, 2002 at 09:07:27AM +0200
Return-Path: <lindahl@keyresearch.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 888
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lindahl@keyresearch.com
Precedence: bulk
X-list: linux-mips

On Thu, Dec 12, 2002 at 09:07:27AM +0200, yaelgilad wrote:

> Looking in the assembly code of my driver, I see the following
> pattern repeating with every function call.
>     4ce4: 0c000000  jal 0
>       4ce4: R_MIPS_26 rx_wait_packet
> (R_MIPS_26 is sometimes replaces by a similar command)

jal takes a 26 bit address. R_MIPS_26 is the corresponding relocation.

-- greg
