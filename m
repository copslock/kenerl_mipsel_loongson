Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0AJ5rT19291
	for linux-mips-outgoing; Thu, 10 Jan 2002 11:05:53 -0800
Received: from gw-us4.philips.com (gw-us4.philips.com [63.114.235.90])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0AJ5kg19288
	for <linux-mips@oss.sgi.com>; Thu, 10 Jan 2002 11:05:46 -0800
Received: from smtpscan-us1.philips.com (localhost.philips.com [127.0.0.1])
          by gw-us4.philips.com with ESMTP id MAA29387;
          Thu, 10 Jan 2002 12:05:33 -0600 (CST)
          (envelope-from balaji.ramalingam@philips.com)
From: balaji.ramalingam@philips.com
Received: from smtpscan-us1.philips.com(167.81.233.25) by gw-us4.philips.com via mwrap (4.0a)
	id xma029385; Thu, 10 Jan 02 12:05:34 -0600
Received: from smtprelay-us1.philips.com (localhost [127.0.0.1]) 
	by smtpscan-us1.philips.com (8.9.3/8.8.5-1.2.2m-19990317) with ESMTP id MAA11005; Thu, 10 Jan 2002 12:05:33 -0600 (CST)
Received: from arj001soh.diamond.philips.com (amsoh01.diamond.philips.com [161.88.79.212]) 
	by smtprelay-us1.philips.com (8.9.3/8.8.5-1.2.2m-19990317) with ESMTP id MAA01456; Thu, 10 Jan 2002 12:05:32 -0600 (CST)
Subject: RE: linux on keyboardless system
To: Marc Karasek <marc_karasek@ivivity.com>
Cc: linux-mips@oss.sgi.com
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OF98C8CB8F.B2085FEA-ON88256B3D.00633301@diamond.philips.com>
Date: Thu, 10 Jan 2002 10:06:25 -0800
X-MIMETrack: Serialize by Router on arj001soh/H/SERVER/PHILIPS(Release 5.0.5 |September
 22, 2000) at 10/01/2002 12:09:17
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk




Thanks for you reply Marc
I 'm not using busybox
I tried both init (with /etc/inittab , /etc/fstab ...) and also replacing init with /bin/sh.
In both the cases I was able to get the shell prompt.
But not able to enter anything after that.

regards,
Balaji



                                                                                                               
                    Marc Karasek                                                                               
                    <marc_karasek@iv           To:  Balaji Ramalingam/SVL/SC/PHILIPS@AMEC                      
                    ivity.com>                  linux-mips@oss.sgi.com                                         
                                               cc:                                                             
                    01/10/02 05:30             Subject:  RE: linux on keyboardless system                      
                    AM                                                                                         
                                               Classification:                                                 
                                                                                                               
                                                                                                               




What are you using for init?  Is it busybox by chance.  If so there was a
bug in a past version that would cause this.  It had to do with not setting
CREAD properly I believe.

-----Original Message-----
From: balaji.ramalingam@philips.com
[mailto:balaji.ramalingam@philips.com]
Sent: Wednesday, January 09, 2002 8:17 PM
To: linux-mips@oss.sgi.com
Subject: linux on keyboardless system


Hello,

I'm tried booting linux 2.4.3 on my prototype system which does not have
a keyboard and a monitor. I used the uart as my serial device and passed on
the console=ttyS0(com1 in my pc) to the kernel. I can see the shell prompt
after the kernel
bootup but not able to enter anything after that.

So how can I use my pc keyboard to send characters to my uart?
I think I'm missing something here.
Can anyone give me some hint?
Thankyou in advance...


regards,
Balaji
