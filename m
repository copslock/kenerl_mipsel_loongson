Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0AKx5723105
	for linux-mips-outgoing; Thu, 10 Jan 2002 12:59:05 -0800
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0AKx2g23102
	for <linux-mips@oss.sgi.com>; Thu, 10 Jan 2002 12:59:02 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id UAA23409;
	Thu, 10 Jan 2002 20:59:09 +0100 (MET)
Date: Thu, 10 Jan 2002 20:59:08 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: balaji.ramalingam@philips.com
cc: linux-mips@oss.sgi.com
Subject: Re: linux on keyboardless system
In-Reply-To: <OFBD5F28E2.DAF35BE4-ON88256B3D.0062F4B1@diamond.philips.com>
Message-ID: <Pine.GSO.3.96.1020110205604.23254A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, 10 Jan 2002 balaji.ramalingam@philips.com wrote:

> Yes I have the CREAD flag set in my uart drivers. (in the function
> rs_init() in serial.c). 

 Check handshaking and modem lines then -- if CLOCAL and CRTSCTS of your
terminal system reflect your connection setup. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
