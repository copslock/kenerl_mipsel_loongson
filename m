Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6M1HdI26139
	for linux-mips-outgoing; Sat, 21 Jul 2001 18:17:39 -0700
Received: from mail.ocs.com.au (ppp0.ocs.com.au [203.34.97.3])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6M1HaV26133
	for <linux-mips@oss.sgi.com>; Sat, 21 Jul 2001 18:17:37 -0700
Received: (qmail 3184 invoked from network); 22 Jul 2001 01:17:31 -0000
Received: from ocs3.ocs-net (192.168.255.3)
  by mail.ocs.com.au with SMTP; 22 Jul 2001 01:17:31 -0000
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Steve Papacharalambous <stevep@lineo.com>
cc: linux-mips@oss.sgi.com
Subject: Re: Interrupts in modules 
In-reply-to: Your message of "Sat, 21 Jul 2001 23:02:53 +0100."
             <3B59FC0D.6CAD443C@lineo.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 22 Jul 2001 11:17:29 +1000
Message-ID: <1052.995764649@ocs3.ocs-net>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sat, 21 Jul 2001 23:02:53 +0100, 
Steve Papacharalambous <stevep@lineo.com> wrote:
>Are there any limitations or precautions needed with interrupt handlers
>in loadable modules?

There is a potential race condition when removing the module.  rmmod
will remove a module when its use count is zero.  If the interrupt
handler is invoked after the use count is tested but before the module
cleanup routine is entered then the code can be removed while the
interrupt handler is running.  The 2.5 module load/unload system will
remove this race.

In 2.4, your best option is to set a can_unload() function in the
module.  Unregister the interrupt handler in can_unload(), wait until
the interrupt count goes to zero (might be running on another cpu) then
return 0.  See drivers/char/ftape/compressor/zftape-compress.c for an
example.

Alternatively keep a use count for opens on the device.  This assumes
that the device does not generate interrupts while it is not open, not
always true.
