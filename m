Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6NKJqo01495
	for linux-mips-outgoing; Mon, 23 Jul 2001 13:19:52 -0700
Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6NKJcX01490
	for <linux-mips@oss.sgi.com>; Mon, 23 Jul 2001 13:19:38 -0700
Received: from www.transvirtual.com (www.transvirtual.com [206.14.214.140]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id MAA01369
	for <linux-mips@oss.sgi.com>; Mon, 23 Jul 2001 12:03:14 -0700 (PDT)
	mail_from (jsimmons@transvirtual.com)
Received: from www.transvirtual.com (jsimmons@localhost [127.0.0.1])
        by localhost (8.12.0.Beta7/8.12.0.Beta7/Debian 8.12.0.Beta7-1) with ESMTP id f6NJ3Bc1030414;
	Mon, 23 Jul 2001 12:03:11 -0700
Received: from localhost (jsimmons@localhost)
        by www.transvirtual.com (8.12.0.Beta7/8.12.0.Beta7/Debian 8.12.0.Beta7-1) with ESMTP id f6NJ3A7d030410;
	Mon, 23 Jul 2001 12:03:11 -0700
X-Authentication-Warning: www.transvirtual.com: jsimmons owned process doing -bs
Date: Mon, 23 Jul 2001 12:03:10 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Andrew Thornton <andrew.thornton@insignia.com>
cc: Linux-MIPS <linux-mips@oss.sgi.com>
Subject: Re: ATI Victoria on Malta
In-Reply-To: <006b01c11356$227ae880$d11110ac@snow.isltd.insignia.com>
Message-ID: <Pine.LNX.4.10.10107231202110.29847-100000@transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


> >> There does seem to be some code for the ATI Rage XL hardware (as used on
> the
> >> card) in v2.4.6 of the kernel.
> >
> >I don't have this board but give the atyfb framebuffer a try.
> 
> This is what I tried. Sadly it locks up at various places and I don't have a
> logic analyser or any documentation.

Turn on debugging in atyfb.c and post the results.

/*
 * Debug flags.
 */
#undef DEBUG
