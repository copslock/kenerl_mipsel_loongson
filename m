Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8HImoY10184
	for linux-mips-outgoing; Mon, 17 Sep 2001 11:48:50 -0700
Received: from tnint06.telogy.com (tnint06.telogy.com [209.116.120.7] (may be forged))
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8HImVe10179
	for <linux-mips@oss.sgi.com>; Mon, 17 Sep 2001 11:48:32 -0700
Received: by tnint06.telogy.design.ti.com with Internet Mail Service (5.5.2653.19)
	id <TCQ4SXXG>; Mon, 17 Sep 2001 14:48:03 -0400
Received: from telogy.com (reddwarf.telogy.design.ti.com [158.218.105.148]) by tnint06.telogy.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2653.13)
	id TCQ4SXX1; Mon, 17 Sep 2001 14:48:00 -0400
From: Jeff Harrell <jharrell@telogy.com>
To: linux-mips@oss.sgi.com
Message-ID: <3BA66163.392CA619@telogy.com>
Date: Mon, 17 Sep 2001 14:47:31 -0600
Organization: Telogy
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-12 i686)
X-Accept-Language: en
MIME-Version: 1.0
Subject: Question concerning the serial console
Content-Type: multipart/alternative;
 boundary="------------BB5DD87EDD42889B966ECCB2"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--------------BB5DD87EDD42889B966ECCB2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

I have recently ported 2.4.2 version of the Linux kernel to a
development 
board that I am working on.  I have built a HHL2.0 version of the
filesystem 
for userland apps.  I am getting output on the serial console but when I
get 
to a login prompt it is not handling any keyboard input.   I have
included my 
/dev/console node, inittab and a snippet from the xxx_setup.c for the
board 
that I am running.  I thought this was all that was required.  Any help
in this 
area would be greatly appreciated. 

Jeff 


------------------------------------------------ 


/dev/console 
crw-r--r--    1 root     tty        5,   1 Sep 17 12:47 console 


---------8<------ /etc/initab --------8<------------- 
# /etc/inittab: init(8) configuration. 
# $Id: inittab,v 1.8 1998/05/10 10:37:50 miquels Exp $ 
  
# The default runlevel. 
id:2:initdefault: 
  
# Boot-time system configuration/initialization script. 
# This is run first except when booting in emergency (-b) mode. 
si::sysinit:/etc/init.d/rcS 
  
# What to do in single-user mode. 
~~:S:wait:/sbin/sulogin 
  
# /etc/init.d executes the S and K scripts upon change 
# of runlevel. 
# 
# Runlevel 0 is halt. 
# Runlevel 1 is single-user. 
# Runlevels 2-5 are multi-user. 
# Runlevel 6 is reboot. 
  
l0:0:wait:/etc/init.d/rc 0 
l1:1:wait:/etc/init.d/rc 1 
l2:2:wait:/etc/init.d/rc 2 
l3:3:wait:/etc/init.d/rc 3 
l4:4:wait:/etc/init.d/rc 4 
l5:5:wait:/etc/init.d/rc 5 
l6:6:wait:/etc/init.d/rc 6 
# Normally not reached, but fallthrough in case of emergency. 
z6:6:respawn:/sbin/sulogin 
  
# What to do when CTRL-ALT-DEL is pressed. 
ca:12345:ctrlaltdel:/sbin/shutdown -t1 -a -r now 
  
# Action on special keypress (ALT-UpArrow). 
kb::kbrequest:/bin/echo "Keyboard Request--edit /etc/inittab to let this
work." 
  
# What to do when the power fails/returns. 
pf::powerwait:/etc/init.d/powerfail start 
pn::powerfailnow:/etc/init.d/powerfail now 
po::powerokwait:/etc/init.d/powerfail stop 
  
# This line provides a nice out-of-box experience.  For regular use, you

# should replace it with the proper getty lines below. 
  
con:2345:respawn:/sbin/getty console 
  
# /sbin/getty invocations for the runlevels. 
# 
# The "id" field MUST be the same as the last 
# characters of the device (after "tty"). 
# 
# Format: 
#  <id>:<runlevels>:<action>:<process> 
#1:2345:respawn:/sbin/getty 38400 tty1 
#2:23:respawn:/sbin/getty 38400 tty2 
#3:23:respawn:/sbin/getty 38400 tty3 
#4:23:respawn:/sbin/getty 38400 tty4 
#5:23:respawn:/sbin/getty 38400 tty5 
#6:23:respawn:/sbin/getty 38400 tty6 
  
# Example how to put a getty on a serial line (for a terminal) 
# 
#T0:23:respawn:/sbin/getty -L ttyS0 9600 vt100 
#T1:23:respawn:/sbin/getty -L ttyS1 9600 vt100 
  
# Example how to put a getty on a modem line. 
# 
#T3:23:respawn:/sbin/mgetty -x0 -s 57600 ttyS3 


------8<---------------8<--------------- 


snippet from my xxx_setup.c code.... 


#ifdef CONFIG_SERIAL_CONSOLE 
 argptr = prom_getcmdline(); 
 if ((argptr = strstr(argptr, "console=ttyS0")) == NULL) { 
  int i = 0; 
  char *s = prom_getenv("modetty0"); 
  while(s[i] >= '0' && s[i] <= '9') 
   i++; 
  strcpy(serial_console, "ttyS0,"); 
  strncpy(serial_console + 6, s, i); 
  prom_printf("Config serial console: %s\n", serial_console); 
                //  console_setup(serial_console, NULL); 
                console_setup(serial_console); 
 } 
#endif 
  
  
  

-- 

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

\ Jeff Harrell  (jharrell@telogy.com)               \

\ Telogy Networks                                   \

\ Broadband Access Group                            \

\                                                   \

\ Work: (301) 515-6537                              \

\ Fax:  (301) 515-6637                              \

\~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 

--------------BB5DD87EDD42889B966ECCB2
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!doctype html public "-//w3c//dtd html 4.0 transitional//en">
<html>
I&nbsp;have recently ported 2.4.2 version of the Linux kernel to a development
<br>board that I am working on.&nbsp; I have built a HHL2.0 version of
the filesystem
<br>for userland apps.&nbsp; I am getting output on the serial console
but when I get
<br>to a login prompt it is not handling any keyboard input.&nbsp;&nbsp;
I have included my
<br>/dev/console node, inittab and a snippet from the xxx_setup.c for the
board
<br>that I am running.&nbsp; I thought this was all that was required.&nbsp;
Any help in this
<br>area would be greatly appreciated.
<p>Jeff
<p>------------------------------------------------
<p>/dev/console
<br>crw-r--r--&nbsp;&nbsp;&nbsp; 1 root&nbsp;&nbsp;&nbsp;&nbsp; tty&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
5,&nbsp;&nbsp; 1 Sep 17 12:47 console
<p>---------8&lt;------ /etc/initab --------8&lt;-------------
<br># /etc/inittab: init(8) configuration.
<br># $Id: inittab,v 1.8 1998/05/10 10:37:50 miquels Exp $
<br>&nbsp;
<br># The default runlevel.
<br>id:2:initdefault:
<br>&nbsp;
<br># Boot-time system configuration/initialization script.
<br># This is run first except when booting in emergency (-b) mode.
<br>si::sysinit:/etc/init.d/rcS
<br>&nbsp;
<br># What to do in single-user mode.
<br>~~:S:wait:/sbin/sulogin
<br>&nbsp;
<br># /etc/init.d executes the S and K scripts upon change
<br># of runlevel.
<br>#
<br># Runlevel 0 is halt.
<br># Runlevel 1 is single-user.
<br># Runlevels 2-5 are multi-user.
<br># Runlevel 6 is reboot.
<br>&nbsp;
<br>l0:0:wait:/etc/init.d/rc 0
<br>l1:1:wait:/etc/init.d/rc 1
<br>l2:2:wait:/etc/init.d/rc 2
<br>l3:3:wait:/etc/init.d/rc 3
<br>l4:4:wait:/etc/init.d/rc 4
<br>l5:5:wait:/etc/init.d/rc 5
<br>l6:6:wait:/etc/init.d/rc 6
<br># Normally not reached, but fallthrough in case of emergency.
<br>z6:6:respawn:/sbin/sulogin
<br>&nbsp;
<br># What to do when CTRL-ALT-DEL is pressed.
<br>ca:12345:ctrlaltdel:/sbin/shutdown -t1 -a -r now
<br>&nbsp;
<br># Action on special keypress (ALT-UpArrow).
<br>kb::kbrequest:/bin/echo "Keyboard Request--edit /etc/inittab to let
this work."
<br>&nbsp;
<br># What to do when the power fails/returns.
<br>pf::powerwait:/etc/init.d/powerfail start
<br>pn::powerfailnow:/etc/init.d/powerfail now
<br>po::powerokwait:/etc/init.d/powerfail stop
<br>&nbsp;
<br># This line provides a nice out-of-box experience.&nbsp; For regular
use, you
<br># should replace it with the proper getty lines below.
<br>&nbsp;
<br>con:2345:respawn:/sbin/getty console
<br>&nbsp;
<br># /sbin/getty invocations for the runlevels.
<br>#
<br># The "id" field MUST be the same as the last
<br># characters of the device (after "tty").
<br>#
<br># Format:
<br>#&nbsp; &lt;id>:&lt;runlevels>:&lt;action>:&lt;process>
<br>#1:2345:respawn:/sbin/getty 38400 tty1
<br>#2:23:respawn:/sbin/getty 38400 tty2
<br>#3:23:respawn:/sbin/getty 38400 tty3
<br>#4:23:respawn:/sbin/getty 38400 tty4
<br>#5:23:respawn:/sbin/getty 38400 tty5
<br>#6:23:respawn:/sbin/getty 38400 tty6
<br>&nbsp;
<br># Example how to put a getty on a serial line (for a terminal)
<br>#
<br>#T0:23:respawn:/sbin/getty -L ttyS0 9600 vt100
<br>#T1:23:respawn:/sbin/getty -L ttyS1 9600 vt100
<br>&nbsp;
<br># Example how to put a getty on a modem line.
<br>#
<br>#T3:23:respawn:/sbin/mgetty -x0 -s 57600 ttyS3
<p>------8&lt;---------------8&lt;---------------
<p>snippet from my xxx_setup.c code....
<p>#ifdef CONFIG_SERIAL_CONSOLE
<br>&nbsp;argptr = prom_getcmdline();
<br>&nbsp;if ((argptr = strstr(argptr, "console=ttyS0")) == NULL) {
<br>&nbsp; int i = 0;
<br>&nbsp; char *s = prom_getenv("modetty0");
<br>&nbsp; while(s[i] >= '0' &amp;&amp; s[i] &lt;= '9')
<br>&nbsp;&nbsp; i++;
<br>&nbsp; strcpy(serial_console, "ttyS0,");
<br>&nbsp; strncpy(serial_console + 6, s, i);
<br>&nbsp; prom_printf("Config serial console: %s\n", serial_console);
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
//&nbsp; console_setup(serial_console, NULL);
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
console_setup(serial_console);
<br>&nbsp;}
<br>#endif
<br>&nbsp;
<br>&nbsp;
<br>&nbsp;
<pre>--&nbsp;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
\ Jeff Harrell&nbsp; (jharrell@telogy.com)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \
\ Telogy Networks&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \
\ Broadband Access Group&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \
\&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \
\ Work: (301) 515-6537&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \
\ Fax:&nbsp; (301) 515-6637&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \
\~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~</pre>
&nbsp;</html>

--------------BB5DD87EDD42889B966ECCB2--
