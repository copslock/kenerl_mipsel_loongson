Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 22 Aug 2004 13:14:50 +0100 (BST)
Received: from p508B7531.dip.t-dialin.net ([IPv6:::ffff:80.139.117.49]:60710
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225212AbUHVMOq>; Sun, 22 Aug 2004 13:14:46 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id i7MCEipC029714;
	Sun, 22 Aug 2004 14:14:44 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id i7MCEaCD029713;
	Sun, 22 Aug 2004 14:14:36 +0200
Date: Sun, 22 Aug 2004 14:14:36 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Macleod <macleod@mail2000.com.tw>
Cc: linux-mips@linux-mips.org
Subject: Re: System call select on R4600
Message-ID: <20040822121436.GA29321@linux-mips.org>
References: <1093146850.1583.macleod@mail2000.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1093146850.1583.macleod@mail2000.com.tw>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5712
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Aug 22, 2004 at 11:54:10AM +0800, Macleod wrote:

>  My problem is "select" system call always return -1
>  and errno is -4142, but sys_select has never been called.
>  Think, it has some problem on handling system call. 
>  Because if I change SYS(sys_select, 5) to 4 arguments,
>  sys_select will be executed. 
>  Thanks!

This is a bug which was fixed a while ago.  I assume your application
is picking up a bad definition from an old kernel header package or so.
Still doing syscalls directly is a fragily; better avoid and use your
libc's select(3).

  Ralf
