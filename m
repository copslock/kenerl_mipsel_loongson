Received:  by oss.sgi.com id <S553829AbQKSBhm>;
	Sat, 18 Nov 2000 17:37:42 -0800
Received: from hermes.epita.fr ([194.98.116.10]:6152 "EHLO hermes.epita.fr")
	by oss.sgi.com with ESMTP id <S553814AbQKSBhf>;
	Sat, 18 Nov 2000 17:37:35 -0800
Received: from purple42.epx.epita.fr (purple42.epx.epita.fr [10.225.7.1])
	by hermes.epita.fr id CAA16930
	Sun, 19 Nov 2000 02:36:23 GMT
Received: by purple42.epx.epita.fr (Postfix, from userid 501)
	id 08F483F3B; Sun, 19 Nov 2000 02:42:59 +0100 (CET)
Date:   Sun, 19 Nov 2000 02:42:59 +0100
From:   Thomas Poindessous <poinde_t@epita.fr>
To:     Linux Mips at SGI <linux-mips@oss.sgi.com>, port-max@netbsd.org
Subject: Decstation 5000/200, status led ?
Message-ID: <20001119024259.A1244@purple42.epx.epita.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hi,
I have got a digital decstation 5000/200, with a video card, a scsi card, 4
memory cards and no hard drive.

I tried to boot it :
* with/without video card
* with/without scsi card
* with/without keybord/mouse plugged
* with/without memory card

I have a null-cable to my pc, I use minicom and kermit.
Each time, I got nothing on my term.
And the status leds are set like this:
x000 xx00      (x: light off, 0: light on)

Is there anyone who have the hardware reference manual for 5000/200 ?
I need to know if the problem is from the hardware and which hardware.

Thank for your help.

my kermit conf:
set carrier-watch off
set line /dev/ttyS1
set speed 9600
set modem hayes
set prompt Kermit@\v(host)>
set flow xon/xoff

my minicom conf:
pu baudrate         9600
pu minit            
pu mreset           
pu mdialpre         
pu mdialsuf         
pu mdialpre2        
pu mdialsuf2        
pu mdialpre3        
pu mdialsuf3        
pu mconnect         
pu backspace        DEL
pu rtscts           Yes
pu xonxoff          Yes

-- 
Thomas Poindessous
EpX asso GNU/Linux de l'Epita
epx@epita.fr && http://www.epita.fr/~epx
