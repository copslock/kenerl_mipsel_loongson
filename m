Received:  by oss.sgi.com id <S553846AbRBISvr>;
	Fri, 9 Feb 2001 10:51:47 -0800
Received: from gateway-1237.mvista.com ([12.44.186.158]:4860 "EHLO
        hermes.mvista.com") by oss.sgi.com with ESMTP id <S553842AbRBISve>;
	Fri, 9 Feb 2001 10:51:34 -0800
Received: from mvista.com (IDENT:ppopov@zeus.mvista.com [10.0.0.112])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f19Ils811662
	for <linux-mips@oss.sgi.com>; Fri, 9 Feb 2001 10:47:54 -0800
Message-ID: <3A843C2D.525643E7@mvista.com>
Date:   Fri, 09 Feb 2001 10:51:25 -0800
From:   Pete Popov <ppopov@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.17 i586)
X-Accept-Language: bg, en
MIME-Version: 1.0
To:     "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: irq.c
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


There's a dozen copies of "irq.c", and a few more files that do the same
thing but are named differently. The irq.c in arch/mips/kernel doesn't
seem to be used by any system.  The PowerPC also has lots of variants
also, but I believe they have a single irq.c file that all systems use. 
So I guess my question is, is anyone using arch/mips/kernel/irq.c, and
does everyone plan on moving to that file (which seems like the right
thing to do).  

Pete
