Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g23N4va24949
	for linux-mips-outgoing; Sun, 3 Mar 2002 15:04:57 -0800
Received: from darth.paname.org (root@ns0.paname.org [212.27.32.70])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g23N4p924946;
	Sun, 3 Mar 2002 15:04:51 -0800
Received: from darth.paname.org (localhost [127.0.0.1])
	by darth.paname.org (8.12.1/8.12.1/Debian -2) with ESMTP id g23M4nZB003147;
	Sun, 3 Mar 2002 23:04:49 +0100
Received: (from rani@localhost)
	by darth.paname.org (8.12.1/8.12.1/Debian -2) id g23M4nEB003146;
	Sun, 3 Mar 2002 23:04:49 +0100
From: Rani Assaf <rani@paname.org>
Date: Sun, 3 Mar 2002 23:04:49 +0100
To: Ralf Baechle <ralf@oss.sgi.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: Changes to head.S
Message-ID: <20020303230449.K1788@paname.org>
References: <20020303185049.A1788@paname.org> <20020303225630.A16898@dea.linux-mips.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020303225630.A16898@dea.linux-mips.net>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux darth 2.4.17-pre8 
X-NCC-RegID: fr.proxad
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk



On Sun, Mar 03, 2002 at 10:56:31PM +0100, Ralf Baechle wrote:
> you're observing an alignment problem I suspect you're using a too old
> egcs 1.1.2 variant.

Hmm.. It's the redhat one on ftp://oss.sgi.com/pub/linux/mips/:

Reading specs from
/opt/Mipsel/bin/../lib/gcc-lib/mipsel-linux/2.96/specs
gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-99.1)

Is there anything newer/better (I thought  that this is the place were
H.J. Lu binutils/gcc is stored)?

BTW, is there any interest in integrating the RC32355 support into the
main tree? (I can provide the code that runs on IDT eval boards though
we're not using them anymore).

Regards,
Rani
