Received:  by oss.sgi.com id <S553822AbRAOIm4>;
	Mon, 15 Jan 2001 00:42:56 -0800
Received: from brutus.conectiva.com.br ([200.250.58.146]:56566 "EHLO
        lappi.waldorf-gmbh.de") by oss.sgi.com with ESMTP
	id <S553812AbRAOImx>; Mon, 15 Jan 2001 00:42:53 -0800
Received: (ralf@lappi.waldorf-gmbh.de) by bacchus.dhis.org
	id <S867058AbRAOIm0>; Mon, 15 Jan 2001 06:42:26 -0200
Date:	Mon, 15 Jan 2001 06:42:26 -0200
From:	Ralf Baechle <ralf@oss.sgi.com>
To:	"Kevin D. Kissell" <kevink@mips.com>
Cc:	"Jun Sun" <jsun@mvista.com>, <linux-mips@oss.sgi.com>
Subject: Re: broken RM7000 in CVS ...
Message-ID: <20010115064226.D8866@bacchus.dhis.org>
References: <3A5E7FFB.79925DF9@mvista.com> <001e01c07c68$96155f80$0deca8c0@Ulysses> <3A5F53CB.F8EC3947@mvista.com> <020a01c07ccf$cf11d220$0deca8c0@Ulysses>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <020a01c07ccf$cf11d220$0deca8c0@Ulysses>; from kevink@mips.com on Fri, Jan 12, 2001 at 08:42:24PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, Jan 12, 2001 at 08:42:24PM +0100, Kevin D. Kissell wrote:

> And thereby hangs a tale.  MIPS tweaked the Config register, and has
> added additional registers "behind" the Config register (a previously
> reserved zero field in the mtc0/mfc0 instructions now serves as a
> sort of bank select, and most current gnu assemblers recognize
> "mfc0 $2, 16, 1", etc.) in MIPS32 to allow MMU and cache configuration,

Do you know when the ability to address the additional register banks got
added to gas?  I'd like to get rid of the sucky .word <opcode> thing we're
using right now to address the additional register banks.

  Ralf
