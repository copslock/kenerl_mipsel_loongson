Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Oct 2002 21:58:43 +0200 (CEST)
Received: from pizda.ninka.net ([216.101.162.242]:55452 "EHLO pizda.ninka.net")
	by linux-mips.org with ESMTP id <S1123903AbSJNT6n>;
	Mon, 14 Oct 2002 21:58:43 +0200
Received: from localhost (IDENT:davem@localhost.localdomain [127.0.0.1])
	by pizda.ninka.net (8.9.3/8.9.3) with ESMTP id MAA30656;
	Mon, 14 Oct 2002 12:51:35 -0700
Date: Mon, 14 Oct 2002 12:51:34 -0700 (PDT)
Message-Id: <20021014.125134.98070597.davem@redhat.com>
To: hjl@lucon.org
Cc: aoliva@redhat.com, rsandifo@redhat.com, linux-mips@linux-mips.org,
	gcc@gcc.gnu.org, binutils@sources.redhat.com
Subject: Re: MIPS gas relaxation still doesn't work
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021014125549.A32575@lucon.org>
References: <20021014123940.A32333@lucon.org>
	<20021014.123510.00003943.davem@redhat.com>
	<20021014125549.A32575@lucon.org>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <davem@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 425
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: davem@redhat.com
Precedence: bulk
X-list: linux-mips

   From: "H. J. Lu" <hjl@lucon.org>
   Date: Mon, 14 Oct 2002 12:55:49 -0700

           .set    noreorder
           .set    nomacro
   
           bne     $2,$0,$L7493
           nop
           j       $L2
           nop
   
           .set    macro
           .set    reorder
   
   answer your question?
   
   
What instruction would you like to place in the bne's delay
slot?  'j' cannot go into a delay slot.

And likewise, 'bne' cannot go into j's delay slot.
