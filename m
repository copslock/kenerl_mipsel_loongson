Received:  by oss.sgi.com id <S553828AbRCCHW6>;
	Fri, 2 Mar 2001 23:22:58 -0800
Received: from u-162-10.karlsruhe.ipdial.viaginterkom.de ([62.180.10.162]:19205
        "EHLO u-162-10.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S553795AbRCCHWo>; Fri, 2 Mar 2001 23:22:44 -0800
Received: from dea ([193.98.169.28]:17280 "EHLO dea.waldorf-gmbh.de")
	by bacchus.dhis.org with ESMTP id <S870761AbRCCHWb>;
	Fri, 2 Mar 2001 23:22:31 -0800
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f237LFp05873;
	Sat, 3 Mar 2001 08:21:15 +0100
Date:	Sat, 3 Mar 2001 08:21:15 +0100
From:	Ralf Baechle <ralf@oss.sgi.com>
To:	Carsten Langgaard <carstenl@mips.com>
Cc:	linux-mips@oss.sgi.com
Subject: Re: Bug in get_insn_opcode.
Message-ID: <20010303082115.B5750@bacchus.dhis.org>
References: <3A9FD0D0.887E372F@mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A9FD0D0.887E372F@mips.com>; from carstenl@mips.com on Fri, Mar 02, 2001 at 05:56:48PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, Mar 02, 2001 at 05:56:48PM +0100, Carsten Langgaard wrote:
> Date:   Fri, 02 Mar 2001 17:56:48 +0100
> From: Carsten Langgaard <carstenl@mips.com>
> To: linux-mips@oss.sgi.com
> Subject: Bug in get_insn_opcode.
> 
> There is a bug in the function get_insn_opcode in traps.c
> 
> As 'epc' is an int pointer here, it should only be increased by 1 (4
> byte) and not by 4 (4*4 = 16 bytes).
> See the patch below.

> Index: arch/mips/kernel/traps.c
> ===================================================================
> RCS file: /home/repository/sw/linux-2.4.0/arch/mips/kernel/traps.c,v
> retrieving revision 1.10
> diff -u -r1.10 traps.c
> --- traps.c     2001/02/28 13:46:43     1.10
> +++ traps.c     2001/03/02 16:50:27

Patch will behave (un-)funny on a cvs diff generated patch like this which
lacks full pathnames in the --- and +++ lines.  Patches for this
behaviour are available on ftp.cyclic.com (so it still exists ...) or in
more recent cvs rpms.

Applied anyway, of course.

  Ralf
