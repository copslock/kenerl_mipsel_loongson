Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0ADO1X09323
	for linux-mips-outgoing; Thu, 10 Jan 2002 05:24:01 -0800
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0ADNvg09318
	for <linux-mips@oss.sgi.com>; Thu, 10 Jan 2002 05:23:58 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id NAA10185;
	Thu, 10 Jan 2002 13:23:51 +0100 (MET)
Date: Thu, 10 Jan 2002 13:23:50 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: balaji.ramalingam@philips.com
cc: linux-mips@oss.sgi.com
Subject: Re: linux on keyboardless system
In-Reply-To: <OF9F3303F0.879E3310-ON08256B3D.00068EEF@diamond.philips.com>
Message-ID: <Pine.GSO.3.96.1020110131854.9835A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, 9 Jan 2002 balaji.ramalingam@philips.com wrote:

> I'm tried booting linux 2.4.3 on my prototype system which does not have
> a keyboard and a monitor. I used the uart as my serial device and passed on
> the console=ttyS0(com1 in my pc) to the kernel. I can see the shell prompt after the kernel
> bootup but not able to enter anything after that.

 Assuming that you have handshaking and modem control set up correctly, do
you have the CREAD tty flag set for your console device after boot? 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
