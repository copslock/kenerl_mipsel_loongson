Received:  by oss.sgi.com id <S553760AbRAUEkX>;
	Sat, 20 Jan 2001 20:40:23 -0800
Received: from brutus.conectiva.com.br ([200.250.58.146]:57073 "EHLO
        lappi.waldorf-gmbh.de") by oss.sgi.com with ESMTP
	id <S553744AbRAUEkO>; Sat, 20 Jan 2001 20:40:14 -0800
Received: (ralf@lappi.waldorf-gmbh.de) by bacchus.dhis.org
	id <S867210AbRAUEhV>; Sun, 21 Jan 2001 02:37:21 -0200
Date:	Sun, 21 Jan 2001 02:37:21 -0200
From:	Ralf Baechle <ralf@oss.sgi.com>
To:	Dave Gilbert <gilbertd@treblig.org>
Cc:	linux-mips@oss.sgi.com
Subject: Re: Trying to boot an Indy
Message-ID: <20010121023721.D853@bacchus.dhis.org>
References: <Pine.LNX.4.10.10101210150410.964-100000@tardis.home.dave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10101210150410.964-100000@tardis.home.dave>; from gilbertd@treblig.org on Sun, Jan 21, 2001 at 02:01:15AM +0000
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Sun, Jan 21, 2001 at 02:01:15AM +0000, Dave Gilbert wrote:

> 2) So I ftp'd the file over under Irix, gzip -d'd it and then rebooted and
> from sash did boot indyvmlinux - this immediatly after starting gave
> 'Exception: <vector=UTLB Miss>' plus details (available on request).
> (This is kernel vmlinux=001027-test9-r4x00.gz off
> download.ichilton.co.uk/pub/ichilton/linux-mips/kernels).
> 
> This is an Indy R4600PC with 64MB RAM.

You may have become a victim of a sash bug which makes the firmware report
used memory as free memory and in the end results in the kernel overwriting
itself.  The solution is easy; don't use sash.  This means you either
have to boot the kernel via ``bootp() -f ...'' from the network or you
use IRIX's dvhtool to write it into the volume header, then boot it from
the kernel prompt by just entering the kernel name.

  Ralf
