Received:  by oss.sgi.com id <S553799AbQLSCCc>;
	Mon, 18 Dec 2000 18:02:32 -0800
Received: from gateway-1237.mvista.com ([12.44.186.158]:58104 "EHLO
        hermes.mvista.com") by oss.sgi.com with ESMTP id <S553720AbQLSCCP>;
	Mon, 18 Dec 2000 18:02:15 -0800
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id eBJ20Mx09566;
	Mon, 18 Dec 2000 18:00:22 -0800
Message-ID: <3A3EC1FF.9B86E2AC@mvista.com>
Date:   Mon, 18 Dec 2000 18:03:43 -0800
From:   Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     linux-mips@oss.sgi.com
Subject: MIPS_ATOMIC_SET in sys_sysmips()
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


It looks like sometime after test5 the MIPS_ATOMIC_SET case in sys_sysmips()
function in the CVS tree is changed.  The new code now uses ll/sc instructions
and handles syscall trace, etc.. 

This change does not make sense to me.  The userland typically uses
MIPS_ATOMIC_SET when ll/sc instructions are not available.  But the new code
itself uses ll/sc, which pretty much forfeit the purpose.  Or do I miss
something else?

What do we offer to machines without ll/sc?

BTW, what is the wrong with previous code?  I understand it may be broken in
SMP case, but I think that is fixable.  Comments?


Jun
