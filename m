Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f2RIMXi05279
	for linux-mips-outgoing; Tue, 27 Mar 2001 10:22:33 -0800
Received: from appliedmicro.ns.ca (dragon.appliedmicro.ns.ca [24.222.12.66])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f2RIMWM05275
	for <linux-mips@oss.sgi.com>; Tue, 27 Mar 2001 10:22:32 -0800
Received: by dragon.appliedmicro.ns.ca id <7308>; Tue, 27 Mar 2001 14:14:32 -0400
Date: Tue, 27 Mar 2001 14:21:16 -0400
To: Florian Lohoff <flo@rfc822.org>
Cc: linux-mips@oss.sgi.com
Subject: Re: loop stuff
Message-Id: <01Mar27.141432ast.7308@dragon.appliedmicro.ns.ca>
References: <20010327200219.B32706@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20010327200219.B32706@paradigm.rfc822.org>; from flo@rfc822.org on Tue, Mar 27, 2001 at 02:02:19PM -0400
From: fifield@amirix.com (Jamie Fifield)
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I think Jens' latest loop patches made it into 2.4.3-pre3 (or pre4).

Anyway, they're working fine for me on my IA32 workstation.

jamie:~$ uname -a
Linux jamie 2.4.3-pre8 #1 Mon Mar 26 11:37:58 AST 2001 i686 unknown


On Tue, Mar 27, 2001 at 02:02:19PM -0400, Florian Lohoff wrote:
> Hi,
> does anyone know if the 2.4.2 kernel does support loop devices - I mean
> in the sense of - "It works" - I do have problems with processes like
> mke2fs getting hung while accessing the loop without any error message.
> 
> I am not running 2.4.x on any other platform so i cant verify ...
> 
> Flo
> -- 
> Florian Lohoff                  flo@rfc822.org             +49-5201-669912
>      Why is it called "common sense" when nobody seems to have any?
> 

-- 
Jamie Fifield

Software Designer		Jamie.Fifield@amirix.com
AMIRIX Systems Inc.		http://www.amirix.com/
Embedded Debian Project		http://www.emdebian.org/
77 Chain Lake Drive		902-450-1700 x247 (Phone)
Halifax, N.S. B3S 1E1		902-450-1704 (FAX)
