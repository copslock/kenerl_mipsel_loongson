Received:  by oss.sgi.com id <S305164AbQBVC7m>;
	Mon, 21 Feb 2000 18:59:42 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:20841 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305159AbQBVC7U>; Mon, 21 Feb 2000 18:59:20 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id TAA09728; Mon, 21 Feb 2000 19:02:15 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id SAA74829
	for linux-list;
	Mon, 21 Feb 2000 18:45:38 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from liveoak.engr.sgi.com (liveoak.engr.sgi.com [163.154.5.24])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id SAA67878
	for <linux@relay.engr.sgi.com>;
	Mon, 21 Feb 2000 18:45:35 -0800 (PST)
	mail_from (wje@liveoak.engr.sgi.com)
Received: (from wje@localhost)
	by liveoak.engr.sgi.com (8.9.3/8.8.7) id SAA01121
	for linux@engr.sgi.com; Mon, 21 Feb 2000 18:45:30 -0800
Date:   Mon, 21 Feb 2000 18:45:30 -0800
Message-Id: <200002220245.SAA01121@liveoak.engr.sgi.com>
X-Authentication-Warning: liveoak.engr.sgi.com: wje set sender to wje@liveoak.engr.sgi.com using -f
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
From:   Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To:     Ralf Baechle <ralf@oss.sgi.com>
cc:     linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: Re: CVS Update@oss.sgi.com: linux
In-Reply-To: <20000221125820.A11469@uni-koblenz.de>
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Mon, 21 Feb 2000, Ralf Baechle wrote:
> On Mon, Feb 21, 2000 at 10:54:45AM +0100, Geert Uytterhoeven wrote:
> > > Modified files:
> > > 	include/asm-mips: uaccess.h 
> > > 	include/asm-mips64: uaccess.h 
> > > 
> > > Log message:
> > > 	Fix copy_from_user() in modules and 64-bit kernel.
> > 
> > Now the assembler complains with
> > 
> >     Warning: Used $at without ".set noat"
> 
> I just tried to build an Indy kernel and did not get this warning.

I guess it depends on the configuration. From looking at the list of files I
got complaints for, I do believe you didn't get them when building for an Indy.

Can you try to compile the module for the loop block device? The problem
happens near the call to copy_from_user() in loop_set_status(). The generated
code is (warning position indicated with `>>>'):

	    .set    noreorder
	    .set    noat
	    .set    noat
	    la      $1, __copy_user
	    jalr    $1
	    .set    at
>>>	    addu    $1, $13, $7
	    .set    at
	    .set    reorder
	    move    $7, $6
     #NO_APP
    $L1492:
	    .set    noreorder
	    .set    nomacro
	    bne     $7,$0,$L1502
	    li      $2,-14                  # 0xfffffff2
	    .set    macro
	    .set    reorder

I guess the problem is the nested .set noat/at construct, where __MODULE_JAL
does .set at while copy_from_user() assumes we're still in noat mode?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven ------------- Sony Software Development Center Europe (SDCE)
Geert.Uytterhoeven@sonycom.com ------------------- Sint-Stevens-Woluwestraat 55
Voice +32-2-7248638 Fax +32-2-7262686 ---------------- B-1130 Brussels, Belgium
