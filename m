Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f57HDai28381
	for linux-mips-outgoing; Thu, 7 Jun 2001 10:13:36 -0700
Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f57HDZh28378
	for <linux-mips@oss.sgi.com>; Thu, 7 Jun 2001 10:13:36 -0700
Received: from www.cgsoftware.com ([208.155.65.221]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id KAA05661
	for <linux-mips@oss.sgi.com>; Thu, 7 Jun 2001 10:13:10 -0700 (PDT)
	mail_from (dan@www.cgsoftware.com)
Received: from localhost (dan@localhost)
	by www.cgsoftware.com (8.9.3/8.9.3) with ESMTP id MAA14317;
	Thu, 7 Jun 2001 12:56:14 -0400
Date: Thu, 7 Jun 2001 12:56:14 -0400 (EDT)
From: Daniel Berlin <dan@www.cgsoftware.com>
To: "H . J . Lu" <hjl@lucon.org>
cc: GDB <gdb@sourceware.cygnus.com>, <binutils@lucon.org>,
   <linux-mips@oss.sgi.com>
Subject: Re: stabs or ecoff for Linux/mips
In-Reply-To: <20010607093149.B13198@lucon.org>
Message-ID: <Pine.LNX.4.33.0106071255220.14244-100000@www.cgsoftware.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

STABS definitely.

On Thu, 7 Jun 2001, H . J . Lu wrote:

> What is the better debug format for Linux/mips in the terms of gdb
> and binutils, stabs or ecoff? I know the future is dwarf2. But I need
> something stable now. Since Linux/x86 uses stabs, I lean toward to
> stabs. Any comments?
>
>
> H.J.
>
