Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3OFVvwJ025541
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 24 Apr 2002 08:31:57 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g3OFVvuI025540
	for linux-mips-outgoing; Wed, 24 Apr 2002 08:31:57 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from sgi.com (sgi-too.SGI.COM [204.94.211.39])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g3OFVswJ025537
	for <linux-mips@oss.sgi.com>; Wed, 24 Apr 2002 08:31:54 -0700
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id IAA03667
	for <linux-mips@oss.sgi.com>; Wed, 24 Apr 2002 08:31:37 -0700 (PDT)
	mail_from (michael_pruznick@mvista.com)
Received: from mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id IAA07792
	for <linux-mips@oss.sgi.com>; Wed, 24 Apr 2002 08:15:10 -0700
Message-ID: <3CC6CC21.45E7ABB1@mvista.com>
Date: Wed, 24 Apr 2002 09:15:45 -0600
From: Michael Pruznick <michael_pruznick@mvista.com>
Reply-To: michael_pruznick@mvista.com
Organization: MontaVista
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
Subject: ps2 keyboard -- no key down events
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I'm working on this mips board with a smsc 90e66 south bridge and
fdc37m812 super io.  I'm using the standard pc_keyb.c driver.  I only
see keyboard interrupts and KBD_STAT_OBF set in response to "key up"
events.  I never see them in response to "key down" events.  Thus, the
shell running on the vga console never gets my input (since it is the
"key down" events that pass the character typed to the shell).

At this point, I'm thinking that the standard driver needs some mods
to work with the super io's ps2 controller.  The smsc doc only covers
programming the plug and play registers and doesn't give any info about
programming the ps2 controller.

I've looked around the web, but haven't found anything useful.

Can anyone point me towards some resources that might help out?

-- 
Michael Pruznick, michael_pruznick@mvista.com, www.mvista.com
MontaVista Software, 1237 East Arques Ave, Sunnyvale, CA 94085
