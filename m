Received:  by oss.sgi.com id <S553792AbQLHDNW>;
	Thu, 7 Dec 2000 19:13:22 -0800
Received: from hybrid-024-221-181-223.ca.sprintbbd.net ([24.221.181.223]:60660
        "EHLO hermes.mvista.com") by oss.sgi.com with ESMTP
	id <S553758AbQLHDM5>; Thu, 7 Dec 2000 19:12:57 -0800
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id eB84ArS29663;
	Thu, 7 Dec 2000 20:10:53 -0800
Message-ID: <3A3051C1.DCFC749B@mvista.com>
Date:   Thu, 07 Dec 2000 19:13:05 -0800
From:   Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To:     linux-mips@oss.sgi.com
Subject: Should /dev/kmem support above 0x80000000 area?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


Currently one cannot read memory area above 0x80000000 throught /dev/kmem.  In
fact, an earlier bug would put the process into an infinite loop if you try to
do that.  That seems to be fixed now.

It seems to be very useful if we do allow that access.  What do you think?

Ralf, if we do want to enable it - which is pretty simple to do -, should I
give you the patch or shuld I submit it to somebody else who is maintaining
/dev/kmem?

Jun
