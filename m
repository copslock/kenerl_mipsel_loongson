Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Jul 2003 23:13:00 +0100 (BST)
Received: from web11903.mail.yahoo.com ([IPv6:::ffff:216.136.172.187]:49267
	"HELO web11903.mail.yahoo.com") by linux-mips.org with SMTP
	id <S8225230AbTGVWMz>; Tue, 22 Jul 2003 23:12:55 +0100
Message-ID: <20030722221252.37376.qmail@web11903.mail.yahoo.com>
Received: from [209.243.184.191] by web11903.mail.yahoo.com via HTTP; Tue, 22 Jul 2003 15:12:52 PDT
Date: Tue, 22 Jul 2003 15:12:52 -0700 (PDT)
From: Wayne Gowcher <wgowcher@yahoo.com>
Subject: Support of cmpxchg
To: linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <wgowcher@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2867
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wgowcher@yahoo.com
Precedence: bulk
X-list: linux-mips

I am trying to get some DRM ( direct rendering module
? ) code to work with XFree86 on a mips system and
have come across the function cmpxchg(). On x86
systems 486 and higher this is an assembly
instruction. Other architectures like sparc have some
inline assembly to preform the same task. Yet other
architectures like the parisc have generic c code to
implement the function. MIPS it seems has nothing.

Has anyone ever implemented this for mips2 and higher
architecture ?

If no, does anyone think it is possible to use ll / sc
to implement this function similar to the spinlock
case. Or should I just stick with the generic c
versions ?

Any thoughts / code / comments welcome

__________________________________
Do you Yahoo!?
Yahoo! SiteBuilder - Free, easy-to-use web site design software
http://sitebuilder.yahoo.com
