Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Oct 2002 19:20:28 +0200 (CEST)
Received: from pizda.ninka.net ([216.101.162.242]:26523 "EHLO pizda.ninka.net")
	by linux-mips.org with ESMTP id <S1122169AbSJNRU1>;
	Mon, 14 Oct 2002 19:20:27 +0200
Received: from localhost (IDENT:davem@localhost.localdomain [127.0.0.1])
	by pizda.ninka.net (8.9.3/8.9.3) with ESMTP id KAA29478;
	Mon, 14 Oct 2002 10:13:19 -0700
Date: Mon, 14 Oct 2002 10:13:18 -0700 (PDT)
Message-Id: <20021014.101318.31058876.davem@redhat.com>
To: hjl@lucon.org
Cc: rsandifo@redhat.com, aoliva@redhat.com, linux-mips@linux-mips.org,
	gcc@gcc.gnu.org, binutils@sources.redhat.com
Subject: Re: MIPS gas relaxation still doesn't work
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021014101640.A30133@lucon.org>
References: <20021014091649.A29353@lucon.org>
	<wvnfzv9ou6j.fsf@talisman.cambridge.redhat.com>
	<20021014101640.A30133@lucon.org>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <davem@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 420
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: davem@redhat.com
Precedence: bulk
X-list: linux-mips

   From: "H. J. Lu" <hjl@lucon.org>
   Date: Mon, 14 Oct 2002 10:16:40 -0700
   
   The problem here is when gcc fills the delay slot with nop, it kills
   branch relaxation. My request is gcc never fills the delay slot with
   nop. If gcc can't find any insn to fill, don't emit .set noreorder.

Why not work on making gcc fill the delay slot with something
suitable if you think the branch relaxer can do better for
your testcase?
