Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3QL4VwJ006864
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 26 Apr 2002 14:04:31 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g3QL4Ui2006863
	for linux-mips-outgoing; Fri, 26 Apr 2002 14:04:30 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3QL4RwJ006860
	for <linux-mips@oss.sgi.com>; Fri, 26 Apr 2002 14:04:27 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.1) id g3QL51A05381;
	Fri, 26 Apr 2002 14:05:01 -0700
Date: Fri, 26 Apr 2002 14:05:01 -0700
From: Ralf Baechle <ralf@oss.sgi.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux/MIPS Development <linux-mips@oss.sgi.com>
Subject: Re: asm type names
Message-ID: <20020426140501.B5107@dea.linux-mips.net>
References: <Pine.GSO.4.21.0204261718450.28137-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.4.21.0204261718450.28137-100000@vervain.sonytel.be>; from geert@linux-m68k.org on Fri, Apr 26, 2002 at 05:21:12PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Apr 26, 2002 at 05:21:12PM +0200, Geert Uytterhoeven wrote:

> include/asm-mips*/unaligned.h uses different terminology for the same sizes,
> sometimes even in the same file, making things a bit confusing:
>   - double vs. quad
>   - word vs. long
>   - halfword vs. word
> 
> Which set of terms is preferred, so we can increase consistency?

The MIPS terminology is:

  - 2 bytes - halfword
  - 4 bytes - word
  - 8 bytes - doubleword
  - 16 bytes - quadword

Unfortunately part of the industry have a different idea of what the size
of a word should be, so for example on i386 the use of the terms is:

 - 2 bytes word
 - 4 bytes doubleword
 - 8 bytes quadword

At times it's hard to avoid confusion; in general I therefore prefer to
avoid these terms or their abreviations but there are places like the
old assembler implementation of inw() where both are used next to each
other ...

  Ralf
