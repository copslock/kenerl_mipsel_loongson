Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBFMsTZ27246
	for linux-mips-outgoing; Sat, 15 Dec 2001 14:54:29 -0800
Received: from post.webmailer.de (natpost.webmailer.de [192.67.198.65])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBFMsPo27243
	for <linux-mips@oss.sgi.com>; Sat, 15 Dec 2001 14:54:25 -0800
Received: from excalibur.cologne.de (pD951103A.dip.t-dialin.net [217.81.16.58])
	by post.webmailer.de (8.9.3/8.8.7) with ESMTP id WAA23236;
	Sat, 15 Dec 2001 22:54:21 +0100 (MET)
Received: from karsten by excalibur.cologne.de with local (Exim 3.12 #1 (Debian))
	id 16FMsQ-0000jp-00; Sat, 15 Dec 2001 23:01:50 +0100
Date: Sat, 15 Dec 2001 23:01:50 +0100
From: Karsten Merker <karsten@excalibur.cologne.de>
To: debian-mips@lists.debian.org, linux-mips@oss.sgi.com
Subject: DELO problems
Message-ID: <20011215230150.B2636@excalibur.cologne.de>
Mail-Followup-To: Karsten Merker <karsten@excalibur.cologne.de>,
	debian-mips@lists.debian.org, linux-mips@oss.sgi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-No-Archive: yes
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hallo everyone,

I cannot get delo to boot any recently built kernel - delo loads 
/etc/delo.conf, finds the correct kernel image and loads it,
printing "Loading /boot/vmlinux ....... ok", but when the kernel
itself should be startet (and print "This DECstation is a ...."),
I get the firmware prompt again.

Booting older kernel images works without problems, also booting a current
ECOFF-kernel by tftp shows no problems. Installed is delo-0.7-7 (Debian
package). Can anybody confirm this behaviour?

I have tried building the kernels on different machines, but this does
not make a difference.

Greetings,
Karsten
-- 
#include <standard_disclaimer>
Nach Paragraph 28 Abs. 3 Bundesdatenschutzgesetz widerspreche ich der Nutzung
oder Uebermittlung meiner Daten fuer Werbezwecke oder fuer die Markt- oder
Meinungsforschung.
