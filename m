Received:  by oss.sgi.com id <S553850AbRBTUl6>;
	Tue, 20 Feb 2001 12:41:58 -0800
Received: from u-12-18.karlsruhe.ipdial.viaginterkom.de ([62.180.18.12]:57838
        "EHLO dea.waldorf-gmbh.de") by oss.sgi.com with ESMTP
	id <S553768AbRBTUll>; Tue, 20 Feb 2001 12:41:41 -0800
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f1KKfPE04203
	for linux-mips@oss.sgi.com; Tue, 20 Feb 2001 21:41:25 +0100
Date:   Tue, 20 Feb 2001 21:41:25 +0100
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     linux-mips@oss.sgi.com
Subject: Re: strace sysmips support (was: Re: [FIX] sysmips(MIPS_ATMIC_SET, ...) ret_from_sys_call vs. o32_ret_from_sys_call)
Message-ID: <20010220214125.C2086@bacchus.dhis.org>
References: <20010124163048.B15348@paradigm.rfc822.org> <20010124165919.C15348@paradigm.rfc822.org> <20010125165530.B12576@paradigm.rfc822.org> <20010219141130.C17354@cistron.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010219141130.C17354@cistron.nl>; from wichert@cistron.nl on Mon, Feb 19, 2001 at 02:11:30PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Mon, Feb 19, 2001 at 02:11:30PM +0100, Wichert Akkerman wrote:

> > sysmips(0x7d1, 0x2ac95d24, 0x1, 0)      = 4149
> 
> FWIW, I've just put code in strace CVS to decode this properly. Looking
> in my (stock Linus) kerneltree I noticed the sys_sysmips code assumes
> it can get away with converting an int to a char*, which seems like a
> wrong assumption to me..
> 
> I don't have my indy up and running at the moment, so the code is
> completely untested. Feedback is welcomed :)

Some versions of the kernel were simply not return anything usefull, so
the the value in $v0 stayed unchanged; 4149 is the syscall number of
sysmips(2).

  Ralf
