Received:  by oss.sgi.com id <S553871AbQJ3RuG>;
	Mon, 30 Oct 2000 09:50:06 -0800
Received: from gateway-490.mvista.com ([63.192.220.206]:59893 "EHLO
        hermes.mvista.com") by oss.sgi.com with ESMTP id <S553818AbQJ3Rtq>;
	Mon, 30 Oct 2000 09:49:46 -0800
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id e9UHlu331707;
	Mon, 30 Oct 2000 09:47:56 -0800
Message-ID: <39FDB50A.4919D84E@mvista.com>
Date:   Mon, 30 Oct 2000 09:51:06 -0800
From:   Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To:     Florian Lohoff <flo@rfc822.org>
CC:     linux-mips@oss.sgi.com
Subject: Re: userspace spinlocks
References: <20001030151736.C2687@paradigm.rfc822.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Florian Lohoff wrote:
> 
> OTOH - Where are they normally implemented ? libc ? macro ? 

As far I know, they ether use atomic instructions such as ll/sc or use
kernel trap to emulate atomic operations.  I am not sure if other means
are possible because userland cannot disable interrupts or prevent
context switch.

> Could
> there be a runtime linking thing with a cpu detection wether we
> have ll/sc or not ?
>

This is a wonderful idea.  It should incorporate into future MIPS CPU
support structure.
 
Jun
