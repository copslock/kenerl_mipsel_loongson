Received:  by oss.sgi.com id <S553808AbQJZUaM>;
	Thu, 26 Oct 2000 13:30:12 -0700
Received: from gatekeep.ti.com ([192.94.94.61]:6040 "EHLO gatekeep.ti.com")
	by oss.sgi.com with ESMTP id <S553805AbQJZUaD>;
	Thu, 26 Oct 2000 13:30:03 -0700
Received: from dlep6.itg.ti.com ([157.170.188.9])
	by gatekeep.ti.com (8.11.1/8.11.1) with ESMTP id e9QKTvn14202;
	Thu, 26 Oct 2000 15:29:57 -0500 (CDT)
Received: from dlep6.itg.ti.com (localhost [127.0.0.1])
	by dlep6.itg.ti.com (8.9.3/8.9.3) with ESMTP id PAA01673;
	Thu, 26 Oct 2000 15:29:57 -0500 (CDT)
Received: from dlep3.itg.ti.com (dlep3-maint.itg.ti.com [157.170.133.16])
	by dlep6.itg.ti.com (8.9.3/8.9.3) with ESMTP id PAA01635;
	Thu, 26 Oct 2000 15:29:55 -0500 (CDT)
Received: from ti.com (IDENT:bbrown@bbrowndt.sc.ti.com [158.218.100.180])
	by dlep3.itg.ti.com (8.9.3/8.9.3) with ESMTP id PAA19879;
	Thu, 26 Oct 2000 15:29:50 -0500 (CDT)
Message-ID: <39F89556.582FD0B@ti.com>
Date:   Thu, 26 Oct 2000 14:34:30 -0600
From:   Brady Brown <bbrown@ti.com>
Organization: Texas Instruments
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.0-test9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     Nicu Popovici <octavp@isratech.ro>
CC:     linux-mips@oss.sgi.com
Subject: Re: Atlas Board!
References: <39F828B2.A662A568@isratech.ro>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Nicu Popovici wrote:

> Hello ,
>
> I want to ask few questions about an Atlas board. Who has such a board
> maybe will give me some tips to have an working Linux on that machine.
>
> 1. What type of RAM do I need ?
> 2. I want to cross - compile the CVS linux kernel for Mips but I failed
> on a i686. Could anyone tell me if I try to compile the kernel on Atlas
> board I will  succeed.
>

We have linux running on several Atlas boards here. We are Cross-Compiling
the kernel successfully on an Intel machine. The cross tools we are
currently using are:
binutils-mipsel-linux-2.8.1-1
egcs-c++-mipsel-linux-1.0.3a-2
egcs-g77-mipsel-linux-1.0.3a-2
egcs-mipsel-linux-1.0.3a-2
egcs-libstdc++-mipsel-linux-2.8.0-2
egcs-objc-mipsel-linux-1.0.3a-2

These are available at
ftp://oss.sgi.com/pub/linux/mips/crossdev/i386-linux/mipsel-linux/
Note: the binutils version 2.9.5-1 gave us some problems when we tried it
so we are still using 2.8.1-1
--
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Brady Brown (bbrown@ti.com)       Work:(801)619-6103
Texas Instruments: Broadband Access Group
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
