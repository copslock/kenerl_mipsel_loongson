Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8QFs9O23986
	for linux-mips-outgoing; Wed, 26 Sep 2001 08:54:09 -0700
Received: from mail.ivivity.com (user-vc8ftn3.biz.mindspring.com [216.135.246.227])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8QFrsD23965
	for <linux-mips@oss.sgi.com>; Wed, 26 Sep 2001 08:53:55 -0700
Received: by ATLOPS with Internet Mail Service (5.5.2448.0)
	id <QMJCNNX5>; Wed, 26 Sep 2001 11:53:40 -0400
Message-ID: <25369470B6F0D41194820002B328BDD2195AA2@ATLOPS>
From: Marc Karasek <marc_karasek@ivivity.com>
To: "'Karsten Merker'" <karsten@excalibur.cologne.de>,
   Jun Sun
	 <jsun@mvista.com>
Cc: linux-mips@oss.sgi.com
Subject: RE: busybox does not like 2.4.8, or the other way around?
Date: Wed, 26 Sep 2001 11:53:39 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2448.0)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C146A3.691F0F02"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C146A3.691F0F02
Content-Type: text/plain;
	charset="iso-8859-1"

Yes, there was a bug in busybox that caused this.  I helped track it down a
few months ago and it should be fixed in the latest one.  I have attached an
email about the bug.  What version(s) of busybox are you using?



-----Original Message-----
From: Karsten Merker [mailto:karsten@excalibur.cologne.de]
Sent: Friday, September 21, 2001 1:30 AM
To: Jun Sun
Cc: linux-mips@oss.sgi.com
Subject: Re: busybox does not like 2.4.8, or the other way around?


On Thu, Sep 20, 2001 at 06:21:49PM -0700, Jun Sun wrote:

> I have a small busybox userland that works fine with 2.4.2 kernel, but
failed
> with the latest 2.4.8 kernel.  The symptom is that it is stuck at the
> following prompt:

[busybox waiting for keypress]

> A simple test shows the console is still working, i.e., pressing a key
*does*
> generate an interrupt and ISR *does* read the correct char value.
> 
> I really cannot think of anything else that might make busybox stuck here.

> Any clue?  Anybody else is using busybox with more recent kernels?

I have a smilar problem on my DECstation. Using 2.4.8 with the Debian
boot-floppies (based on busybox), the machine hangs when waiting for
the first keypress after the splash screen.
When booting 2.4.8 with my "normal" installation into single user mode,
I get a shell prompt, but cannot enter anything. I first thought of
a problem with the DECstation keyboard driver, but the same happens
on serial console. I have tested various kernel version with regard
to this - the last one working for me is 2.4.5.
When booting my "normal" installation with 2.4.8 into multiuser mode,
the machine crashes somewhere in the init scripts.

Is your box little or big endian?

Greetings,
Karsten
-- 
#include <standard_disclaimer>
Nach Paragraph 28 Abs. 3 Bundesdatenschutzgesetz widerspreche ich der
Nutzung
oder Uebermittlung meiner Daten fuer Werbezwecke oder fuer die Markt- oder
Meinungsforschung.


------_=_NextPart_000_01C146A3.691F0F02
Content-Type: message/rfc822
Content-Description: Re: Bug in serial.c

Message-ID: <20010421173401.DAB9.GAUTIER@email.enst.fr>
From: Fabrice Gautier <gautier@email.enst.fr>
To: Marc Karasek <marc_karasek@ivivity.com>
Cc: kanoj@sgi.com
Subject: Re: Bug in serial.c
Date: Sat, 21 Apr 2001 11:54:03 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2448.0)
Content-Type: text/plain;
	charset="iso-8859-1"

Hi Marc and Kanoj

This is definitely a busybox bug for me. Busybox (0.50pre) init didn't
set CREAD in c_cflag:

--- init.c.orig	Sat Apr 21 17:46:57 2001
+++ init.c	Sat Apr 21 17:46:31 2001
@@ -276,7 +276,7 @@
 
 	/* Make it be sane */
 	tty.c_cflag &= CBAUD|CBAUDEX|CSIZE|CSTOPB|PARENB|PARODD;
-	tty.c_cflag |= HUPCL|CLOCAL;
+	tty.c_cflag |= CREAD|HUPCL|CLOCAL;
 
 	/* input modes */
 	tty.c_iflag = ICRNL | IXON | IXOFF;


Guess this is the same problem for other inits. 
The sample init code Richard B. Johnson posted on lkml does have CREAD,
that's why he didn't noticed anything.

Thanks,

On Fri, 20 Apr 2001 23:01:50 -0400
Marc Karasek <marc_karasek@ivivity.com> wrote:

> I got in touch with Kanoj (his email was the last one in the comments of
> serial.c) 
> 
> He recommended I make the below change to serial.c.  It worked for me and
I
> got my serial console port back :-)  
> 
> 
>  Okay. In change_speed(), comment out the two lines 
> 
>           if ((cflag & CREAD) == 0) 
>                   info->ignore_status_mask |= UART_LSR_DR; 
>     
>   This might get you back up. If you can track back to how the serial 
>   port needs to be opened, or some extra ioctls need to be made, let 
>   me know. 
> 
>   Kanoj 
> 
> 
> -----Original Message-----
> From: Fabrice Gautier
> To: marc_karasek@ivivity.com
> Cc: linux-kernel@vger.kernel.org
> Sent: 4/20/01 12:31 PM
> Subject: Re: Bug in serial.c
> 
> Same thing for me.
> 
> I'm using busybox as init/getty/shell.
> 
> Everything works fine with 2.4.2.
> With 2.4.3 console output is fine but not input.
> 
> Thanks
> 
> -- 
> Fabrice Gautier <gautier@email.enstfr>

-- 
Fabrice Gautier <gautier@email.enstfr>

------_=_NextPart_000_01C146A3.691F0F02--
