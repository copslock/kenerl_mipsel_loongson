Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0AJ3Eq19219
	for linux-mips-outgoing; Thu, 10 Jan 2002 11:03:14 -0800
Received: from gw-us4.philips.com (gw-us4.philips.com [63.114.235.90])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0AJ38g19206
	for <linux-mips@oss.sgi.com>; Thu, 10 Jan 2002 11:03:08 -0800
Received: from smtpscan-us1.philips.com (localhost.philips.com [127.0.0.1])
          by gw-us4.philips.com with ESMTP id MAA28227;
          Thu, 10 Jan 2002 12:02:31 -0600 (CST)
          (envelope-from balaji.ramalingam@philips.com)
From: balaji.ramalingam@philips.com
Received: from smtpscan-us1.philips.com(167.81.233.25) by gw-us4.philips.com via mwrap (4.0a)
	id xma028224; Thu, 10 Jan 02 12:02:31 -0600
Received: from smtprelay-us1.philips.com (localhost [127.0.0.1]) 
	by smtpscan-us1.philips.com (8.9.3/8.8.5-1.2.2m-19990317) with ESMTP id MAA09913; Thu, 10 Jan 2002 12:02:30 -0600 (CST)
Received: from arj001soh.diamond.philips.com (amsoh01.diamond.philips.com [161.88.79.212]) 
	by smtprelay-us1.philips.com (8.9.3/8.8.5-1.2.2m-19990317) with ESMTP id MAA00661; Thu, 10 Jan 2002 12:02:29 -0600 (CST)
Subject: Re: linux on keyboardless system
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: linux-mips@oss.sgi.com
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OFBD5F28E2.DAF35BE4-ON88256B3D.0062F4B1@diamond.philips.com>
Date: Thu, 10 Jan 2002 10:03:22 -0800
X-MIMETrack: Serialize by Router on arj001soh/H/SERVER/PHILIPS(Release 5.0.5 |September
 22, 2000) at 10/01/2002 12:06:14
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Thanks for the reply.
Yes I have the CREAD flag set in my uart drivers. (in the function rs_init() in serial.c).



                                                                                                            
                    "Maciej W.                                                                              
                    Rozycki"                To:  Balaji Ramalingam/SVL/SC/PHILIPS@AMEC                      
                    <macro@ds2.pg           cc:  linux-mips@oss.sgi.com                                     
                    .gda.pl>                Subject:  Re: linux on keyboardless system                      
                                                                                                            
                    01/10/02                Classification:                                                 
                    04:23 AM                                                                                
                                                                                                            
                                                                                                            




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
