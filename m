Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Apr 2003 16:32:08 +0100 (BST)
Received: from p508B74BA.dip.t-dialin.net ([IPv6:::ffff:80.139.116.186]:29336
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225268AbTDOPcH>; Tue, 15 Apr 2003 16:32:07 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h3FFJJE09957;
	Tue, 15 Apr 2003 17:19:19 +0200
Date: Tue, 15 Apr 2003 17:19:19 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: nemoto@toshiba-tops.co.jp, linux-mips@linux-mips.org
Subject: Re: End c-tx49.c's misserable existence
Message-ID: <20030415171919.A9902@linux-mips.org>
References: <20030414055038.A29923@linux-mips.org> <20030414.152903.41628304.nemoto@toshiba-tops.co.jp> <20030414174825.A9808@linux-mips.org> <20030416.001509.59462441.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030416.001509.59462441.anemo@mba.ocn.ne.jp>; from anemo@mba.ocn.ne.jp on Wed, Apr 16, 2003 at 12:15:09AM +0900
Return-Path: <ralf@linux-mips.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2061
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Apr 16, 2003 at 12:15:09AM +0900, Atsushi Nemoto wrote:
> Date:	Wed, 16 Apr 2003 00:15:09 +0900 (JST)
> To:	ralf@linux-mips.org
> Cc:	nemoto@toshiba-tops.co.jp, linux-mips@linux-mips.org
> Subject: Re: End c-tx49.c's misserable existence
> From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> Content-Type: Text/Plain; charset=us-ascii
> 
> >>>>> On Mon, 14 Apr 2003 17:48:25 +0200, Ralf Baechle <ralf@linux-mips.org> said:
> 
> >> One more request.  Please enclose R4600_V1_HIT_CACHEOP_WAR and
> >> R4600_V2_HIT_CACHEOP_WAR with appropriate CONFIG_CPU_XXX.  I do not
> >> know what CPUs need this workaround... (at least TX49 does not need
> >> this)
> 
> ralf> I'll leave it unconditionally enabled for now because the
> ralf> Makefiles could behave in undefined ways if multiple
> ralf> CONFIG_CPU_* options are selected and quite a few systems
> ralf> support both the R4600 and other processors like the Indy.
> ralf> Another day.
> 
> I have been misunderstood that people who needs the workaround always
> select CONFIG_CPU_R4X00.  But it is not true.  Now I understand.
> 
> But recent reorganization increased a number of c-r4k.c users
> somewhat.  How about introducing new config macros such as
> CONFIG_R4600_V1_WORKAROUNDS ?

That's all part of the Great Plan.  For now you can control many of the
workarounds in <asm/war.h>.

  Ralf
