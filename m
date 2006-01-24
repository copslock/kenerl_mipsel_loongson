Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jan 2006 02:48:31 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:32274 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S3458479AbWAXCsN (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 24 Jan 2006 02:48:13 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id F2C4464D3D; Tue, 24 Jan 2006 02:51:51 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 34F58892F; Tue, 24 Jan 2006 02:51:31 +0000 (GMT)
Date:	Tue, 24 Jan 2006 02:51:30 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	linux-fbdev-devel@lists.sourceforge.net, jgarzik@pobox.com
Cc:	linux-mips@linux-mips.org
Subject: Compiler error in =?utf-8?Q?drivers=2Fvide?=
	=?utf-8?Q?o=2Fcirrusfb=2Ec=3A_syntax_error_before_=E2=80=98volatile?=
	=?utf-8?B?4oCZ?=
Message-ID: <20060124025130.GA8418@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.11
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10090
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

I get the following compiler error for drivers/video/cirrusfb.c on
mips:

  CC      drivers/video/cirrusfb.o
In file included from include/video/vga.h:25,
                 from drivers/video/cirrusfb.c:70:
include/asm/vga.h:29: error: syntax error before ‘volatile’
include/asm/vga.h:34: error: syntax error before ‘volatile’
make[2]: *** [drivers/video/cirrusfb.o] Error 1

These lines define scr_writew() and scr_readw():

29:static inline void scr_writew(u16 val, volatile u16 *addr)
34:static inline u16 scr_readw(volatile const u16 *addr)

Note that some other arches (powerpc, alpha) have the same
definitions in vga.h.

This is with 2.6.15.
-- 
Martin Michlmayr
http://www.cyrius.com/
