Received:  by oss.sgi.com id <S553850AbRB1WVX>;
	Wed, 28 Feb 2001 14:21:23 -0800
Received: from gateway-1237.mvista.com ([12.44.186.158]:5880 "EHLO
        hermes.mvista.com") by oss.sgi.com with ESMTP id <S553788AbRB1WVU>;
	Wed, 28 Feb 2001 14:21:20 -0800
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f1SMGv009199;
	Wed, 28 Feb 2001 14:16:57 -0800
Message-ID: <3A9D793E.4063ED17@mvista.com>
Date:   Wed, 28 Feb 2001 14:18:38 -0800
From:   Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     Quinn Jensen <jensenq@Lineo.COM>
CC:     linux-mips@oss.sgi.com
Subject: Re: Patch allowing GDB to ignore misaligned data faults
References: <000a01c0a0cf$849efbe0$dde0490a@BANANA> <3A9D70C2.6010504@Lineo.COM>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Quinn Jensen wrote:
> 
> When using gdb on the kernel, I've found it helpful to allow
> misaligned exceptions to be emulated instead of being
> intercepted by gdb.  The following patch does this.  But is
> there a better way?  Perhaps a config.in option?
> 

This does not sound right:  this is already fixed long time ago by not
installing traps for exception 4&5.  What kernel are you using?

Jun
