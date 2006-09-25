Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Sep 2006 22:09:43 +0100 (BST)
Received: from web31505.mail.mud.yahoo.com ([68.142.198.134]:47469 "HELO
	web31505.mail.mud.yahoo.com") by ftp.linux-mips.org with SMTP
	id S20037476AbWIYVJj (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 25 Sep 2006 22:09:39 +0100
Received: (qmail 36815 invoked by uid 60001); 25 Sep 2006 21:09:32 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=CA0zLVo1d6ija+y9JKHOre9/Mfh6LHiq1S1KkQ2LlSGInjZAZh6nXR51H2sjzyCU2UXK9D9dRPwpDNLG6xzitdlQbdV8SmVzc8/BmenGBjrgQ9YrAahiKvR3ENHiSScsucnQ41BKeIR9xcYcRV2e2/2gBs1Se5Sy9p1bxE6ypeY=  ;
Message-ID: <20060925210932.36813.qmail@web31505.mail.mud.yahoo.com>
Received: from [70.103.67.194] by web31505.mail.mud.yahoo.com via HTTP; Mon, 25 Sep 2006 14:09:32 PDT
Date:	Mon, 25 Sep 2006 14:09:32 -0700 (PDT)
From:	Jonathan Day <imipak@yahoo.com>
Subject: Re: 64K page patch hiccup on SB1
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20060923.235203.126573787.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <imipak@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12660
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: imipak@yahoo.com
Precedence: bulk
X-list: linux-mips

I'll take your word for it that it's more useful - it
doesn't look a whole lot clearer to me! Anyways, this
is the output, with CONFIG_KALLSYMS enabled:

**Exception 32: EPC=FFFFFFFF806B1DEC, Cause=00008024
(Breakpt  ) (CPU0)
                RA=FFFFFFFF806B1CF0,
VAddr=0000005555576F60, SR=10000082

        0  ($00) = 0000000000000000     AT ($01) =
FFFFFFFF806F0000
        v0 ($02) = FFFFFFFFFFFFFFF4     v1 ($03) =
0000000000000000
        a0 ($04) = 0000000000010000     a1 ($05) =
0000000000000002
        a2 ($06) = FFFFFFFFFFFFFFFF     a3 ($07) =
FFFFFFFFFFFFFFFF
        t0 ($08) = 0000000000000FEA     t1 ($09) =
FFFFFFFF806D11DA
        t2 ($10) = FFFFFFFFFFFFFFFF     t3 ($11) =
0000000000000006
        t4 ($12) = 0000000000000008     t5 ($13) =
FFFFFFFF802F4E48
        t6 ($14) = FFFFFFFF80565258     t7 ($15) =
FFFFFFFFFFFFFFFC
        s0 ($16) = FFFFFFFF805E6DA0     s1 ($17) =
FFFFFFFF805E6CA0
        s2 ($18) = 0000000000000000     s3 ($19) =
0000000000000002
        s4 ($20) = 0000000000000001     s5 ($21) =
0000000000000000
        s6 ($22) = 0000000000000000     s7 ($23) =
0000000000000001
        t8 ($24) = 0000000000000000     t9 ($25) =
0000000000000030
        k0 ($26) = 0000000000000FEA     k1 ($27) =
FFFFFFFF802F2AB0
        gp ($28) = FFFFFFFF805D0000     sp ($29) =
FFFFFFFF805CFD50
        fp ($30) = 0000000000000FEA     ra ($31) =
FFFFFFFF806B1CF0

Hope this says something more useful to others on this
list!

Jonathan

--- Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:

> On Fri, 22 Sep 2006 17:24:27 -0700 (PDT), Jonathan
> Day <imipak@yahoo.com> wrote:
> > Hi, tried using the 64K page patch with the latest
> GIT
> > repository. Everything runs fine. It brings up all
> the
> > networking code OK, the bonding driver warning is
> > perfectly normal, and then it throws a wobbly. Any
> > ideas?
> ...
> > Call
> >
>
Trace:[<ffffffff80102d38>][<ffffffff8010a020>][<ffffffff80126dec>][<ffffffff8010a020>][<ffffffff80102d38>][<ffffffff801273e0>][<ffffffff8012a7dc>][<fff]
> 
> Enable CONFIG_KALLSYMS.  Then you can see more
> useful information.
> 
> ---
> Atsushi Nemoto
> 
> 


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
