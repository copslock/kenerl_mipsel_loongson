Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6VLBvg11815
	for linux-mips-outgoing; Tue, 31 Jul 2001 14:11:57 -0700
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6VLBvV11812
	for <linux-mips@oss.sgi.com>; Tue, 31 Jul 2001 14:11:57 -0700
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f6VLHBE01520;
	Tue, 31 Jul 2001 14:17:11 -0700
Message-ID: <3B671DFC.3999437D@mvista.com>
Date: Tue, 31 Jul 2001 14:07:08 -0700
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: James Simmons <jsimmons@transvirtual.com>
CC: linux-mips@oss.sgi.com, linux-mips-kernel@lists.sourceforge.net
Subject: Re: sys_mips problems
References: <Pine.LNX.4.10.10107311357530.28897-100000@transvirtual.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

James Simmons wrote:
> 
> Since I was having problems with everything sefaulting due to the sys_mips
> bug I tried the patch floating around. It fixed the segfault problem but
> instead I get this error. Anyone knows why?
> 
> : error while loading shared libraries: libc.so.6: cannot stat shared
> object: Error 14

Which patch did you use?  Does your CPU have ll/sc instructions?

Jun
