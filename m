Received:  by oss.sgi.com id <S42229AbQIYSt1>;
	Mon, 25 Sep 2000 11:49:27 -0700
Received: from gateway-490.mvista.com ([63.192.220.206]:51450 "EHLO
        hermes.mvista.com") by oss.sgi.com with ESMTP id <S42201AbQIYSs7>;
	Mon, 25 Sep 2000 11:48:59 -0700
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id e8PIlwx18947;
	Mon, 25 Sep 2000 11:47:58 -0700
Message-ID: <39CF9DFC.F30B302B@mvista.com>
Date:   Mon, 25 Sep 2000 11:48:28 -0700
From:   Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.2.12-20b i586)
X-Accept-Language: en
MIME-Version: 1.0
To:     linux-mips@oss.sgi.com, linux-mips@fnet.fr
Subject: load_unaligned() and "uld" instruction
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


The USB sub-system uses "unaligned.h" file to access unaligned data. 
All the unaligned data access functions depend on "uld" and "usw"
instructions, which are not available on many CPUs.

I wonder if there is a version of unaligned access functions which do
not depend on those instructions.  If not, I can probably write one.

Any suggestions?

Jun
