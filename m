Received:  by oss.sgi.com id <S553909AbRAPSzS>;
	Tue, 16 Jan 2001 10:55:18 -0800
Received: from noose.gt.owl.de ([62.52.19.4]:7183 "HELO noose.gt.owl.de")
	by oss.sgi.com with SMTP id <S553907AbRAPSzN>;
	Tue, 16 Jan 2001 10:55:13 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 91B6B811; Tue, 16 Jan 2001 19:54:31 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 8B0C1F597; Tue, 16 Jan 2001 19:55:09 +0100 (CET)
Date:   Tue, 16 Jan 2001 19:55:09 +0100
From:   Florian Lohoff <flo@rfc822.org>
To:     linux-mips@oss.sgi.com
Subject: sgiserial - hang on shutdown
Message-ID: <20010116195509.C12610@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hi,
does anyone else see this phenomenon ?

Everytime i try to shutdown on serial console the machine hangs at some
stage and i have to manually press the reset button. As a result no
automatic reboot is possible and all filesystems get shut down unclean.

resume:~# halt
Broadcast message from root (console) Tue Jan 16 18:42:22 2001...
The system is going down for system halt NOW !!
INIT: Switching to runlevel: 0
INIT: Sending processes the TERM signal
INIT: SeStopping INET services: inetd
Stopping portmap services: portmap
Saving random seed...
Unmounting remote filesystems.
Disabling IPv4 packet forwarding.
Ino more processes left in this runlevel

At this point - no more output - even after 30 minutes etc - System
seems to be halted. As one can see there is multiple types of output
intermixed. I guess its something with the serial console vs serial
tty stuff which gets mixed and due to that interrupts getting lost which
leeds me to a question. What is this for spread all over the sgiserial.c

if (ioc_icontrol)
	junk = ioc_icontrol->istat0;

or even reading ioc_icontrol->istat0 unconditionally. I guess its for
acknowledging interrupts. This is also done in zs_cons_put_char which
is would definitly be wrong as the serial console shouldnt generate
interrupts nor change any of the states which could confuse the interrupt
driven tty driver. I guess the right thing to do would be to simply let
an interrupt happen.

Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
