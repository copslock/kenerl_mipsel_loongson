Received:  by oss.sgi.com id <S553798AbRAXQWg>;
	Wed, 24 Jan 2001 08:22:36 -0800
Received: from noose.gt.owl.de ([62.52.19.4]:55057 "HELO noose.gt.owl.de")
	by oss.sgi.com with SMTP id <S553792AbRAXQWX>;
	Wed, 24 Jan 2001 08:22:23 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id EF6847FA; Wed, 24 Jan 2001 17:22:19 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 08F9AEE9C; Wed, 24 Jan 2001 17:22:51 +0100 (CET)
Date:   Wed, 24 Jan 2001 17:22:51 +0100
From:   Florian Lohoff <flo@rfc822.org>
To:     linux-mips@oss.sgi.com
Subject: Re: OOps - very obscure
Message-ID: <20010124172250.D15348@paradigm.rfc822.org>
References: <20010124163048.B15348@paradigm.rfc822.org> <20010124165919.C15348@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010124165919.C15348@paradigm.rfc822.org>; from flo@rfc822.org on Wed, Jan 24, 2001 at 04:59:19PM +0100
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, Jan 24, 2001 at 04:59:19PM +0100, Florian Lohoff wrote:
> On Wed, Jan 24, 2001 at 04:30:48PM +0100, Florian Lohoff wrote:

> Process find (pid: 242, stackpage=8ec08000)
> Stack: 10011510 7ffffd10 88028344 00000000 7ffffc80 00402440 2aca4e00 2ac95d10
>        00000000 2ac95d10 10011510 00000002 00000001 8800fa88 000007d1 100235b0
>        10011510 00000000 00000003 00012000 00000000 1004fc01 00001035 00000000
>        000007d1 10011510 00000001 00000000 0000fc00 00000010 00000000 8ec09f0c
>        8ec09f10 8ec09f14 8ec09ef8 8ec09efc 2aca4e00 2ac95d10 10011510 00000002
>        00000001 ...
[...]
> >>RA;  00000000 Before first symbol
> >>PC;  00000000 Before first symbol
> Trace; 88028344 <sys_nanosleep+190/24c>
> Trace; 8800fa88 <stack_done+1c/38>

This is the relevant code piece in sys_nanosleep:

    88028338:   af820000        sw      $v0,0($gp)
    8802833c:   0e006b70        jal     8801adc0 <schedule_timeout>
    88028340:   00642021        addu    $a0,$v1,$a0
    88028344:   50400028        beqzl   $v0,880283e8 <sys_nanosleep+0x234>
    88028348:   00001021        move    $v0,$zero
    8802834c:   12000025        beqz    $s0,880283e4 <sys_nanosleep+0x230>

Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
