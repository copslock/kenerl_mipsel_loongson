Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3NMw2u16675
	for linux-mips-outgoing; Mon, 23 Apr 2001 15:58:02 -0700
Received: from mail.ocs.com.au (ppp0.ocs.com.au [203.34.97.3])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f3NMvxM16667
	for <linux-mips@oss.sgi.com>; Mon, 23 Apr 2001 15:58:00 -0700
Received: (qmail 23775 invoked from network); 23 Apr 2001 22:57:57 -0000
Received: from ocs3.ocs-net (192.168.255.3)
  by mail.ocs.com.au with SMTP; 23 Apr 2001 22:57:57 -0000
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@melbourne.sgi.com>
To: Ian Soanes <ians@lineo.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: Insmod messages and modules space 
In-reply-to: Your message of "Tue, 10 Apr 2001 09:55:16 BST."
             <3AD2CA74.DCC850EF@lineo.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 24 Apr 2001 08:57:55 +1000
Message-ID: <12715.988066675@ocs3.ocs-net>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 10 Apr 2001 09:55:16 +0100, 
Ian Soanes <ians@lineo.com> wrote:
>> On Mon, Apr 09, 2001 at 08:10:16PM +0200, Shay Deloya wrote:
>> > 2. I keep getting in insmod of busybox pkg , "relocation overflow" message
>> > especially on printk symbols
>
>Compiling with -mlong-calls worked for me when I had the same problem
>(modutils 2.4.5).

Compiling what with -mlong-calls, modutils or the kernel modules?  I
guess it must be the modules, in which case adding
  MODFLAGS += -mlong-calls
in arch/$(ARCH)/Makefile is the best fix.
