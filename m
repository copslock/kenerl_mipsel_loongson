Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f2J2bTn21729
	for linux-mips-outgoing; Sun, 18 Mar 2001 18:37:29 -0800
Received: from ibbserver.ibb.uu.nl (IDENT:mail@ibbserver.ibb.uu.nl [131.211.124.6])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f2J2bRM21726
	for <linux-mips@oss.sgi.com>; Sun, 18 Mar 2001 18:37:27 -0800
Received: from leander.ibb.uu.nl (ibb0100.ibb.uu.nl [131.211.124.100])
	by ibbserver.ibb.uu.nl (Postfix) with ESMTP
	id 2BB0E124B3; Mon, 19 Mar 2001 03:37:25 +0100 (CET)
Message-Id: <5.0.2.1.2.20010319031124.00af61a0@pop.med.uu.nl>
X-Sender: leander@131.211.124.6
X-Mailer: QUALCOMM Windows Eudora Version 5.0.2
Date: Mon, 19 Mar 2001 03:36:54 +0100
To: debian-mips@lists.debian.org, linux-mips@oss.sgi.com
From: Leander Koornneef <leander@ibb.uu.nl>
Subject: Trouble booting my indy
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="=====================_2493078==_.ALT"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

--=====================_2493078==_.ALT
Content-Type: text/plain; charset="us-ascii"; format=flowed

Hi there,

I acquired an indy recently. I spent some time reading emails in these 
lists and some documentation available on the internet.
So now, finally came the time to really try and install debian-mips on this 
machine.
I booted my Mandrake linux box and setup everything according to 
http://staf.digibel.org/topic.php?lang=eng&top=indy
Now, I fired up the indy and gave the command:
         'boot -f bootp()vmlinux-2.4.0-test6-pre8.ecoff init=/bin/bash 
nfsroot=192.168.0.1:/indy'

I got the following:
         'Setting $netaddr to 192.168.0.2 ( from server)'

Which is nice :-)
Then, nothing happens for a minute or two after which I get the mesage:
         'Unable to load bootp()vmlinux-2.4.0-test6-pre8.ecoff 
''bootp()vmlinux-2.4.0-test6-pre8.ecoff'' is not a valid file to boot'

As far as I can tell, the tftp daemon is running and /indy is exported
In the logs it says:
         Mar 19 02:39:06 leander dhcpd: data: lease_time: lease ends at 0 
when it is now 984965946
         Mar 19 02:39:06 leander dhcpd: BOOTREQUEST from 08:00:69:09:64:09 
via eth0
         Mar 19 02:39:06 leander dhcpd: BOOTREPLY for 192.168.0.2 to indy 
(08:00:69:09:64:09) via eth0
And that's it :-(
I read something about problems with tftpd running on linux >= 2.3, but my 
boot server is running 2.2.18.
I hope someone can help me finally boot my indy....
By the way, it's an R5000pc (150MHz)

Many thanks in advance,

Leander Koornneef

--=====================_2493078==_.ALT
Content-Type: text/html; charset="us-ascii"

<html>
Hi there, <br>
<br>
I acquired an indy recently. I spent some time reading emails in these
lists and some documentation available on the internet.<br>
So now, finally came the time to really try and install debian-mips on
this machine.<br>
I booted my Mandrake linux box and setup everything according to
<a href="http://staf.digibel.org/topic.php?lang=eng&amp;top=indy" eudora="autourl">http://staf.digibel.org/topic.php?lang=eng&amp;top=indy</a><br>
Now, I fired up the indy and gave the command:<br>
<x-tab>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</x-tab>'boot -f
bootp()vmlinux-2.4.0-test6-pre8.ecoff init=/bin/bash
nfsroot=192.168.0.1:/indy'<br>
<br>
I got the following:<br>
<x-tab>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</x-tab>'Setting
$netaddr to 192.168.0.2 ( from server)'<br>
<br>
Which is nice :-)<br>
Then, nothing happens for a minute or two after which I get the
mesage:<br>
<x-tab>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</x-tab>'Unable to
load bootp()vmlinux-2.4.0-test6-pre8.ecoff
''bootp()vmlinux-2.4.0-test6-pre8.ecoff'' is not a valid file to
boot'<br>
<br>
As far as I can tell, the tftp daemon is running and /indy is
exported<br>
In the logs it says:<br>
<x-tab>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</x-tab><font face="Courier New, Courier">Mar
19 02:39:06 leander dhcpd: data: lease_time: lease ends at 0 when it is
now 984965946<br>
<x-tab>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</x-tab>Mar 19
02:39:06 leander dhcpd: BOOTREQUEST from 08:00:69:09:64:09 via eth0<br>
<x-tab>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</x-tab>Mar 19
02:39:06 leander dhcpd: BOOTREPLY for 192.168.0.2 to indy
(08:00:69:09:64:09) via eth0<br>
</font>And that's it :-(<br>
I read something about problems with tftpd running on linux &gt;= 2.3,
but my boot server is running 2.2.18.<br>
I hope someone can help me finally boot my indy....<br>
By the way, it's an R5000pc (150MHz)<br>
<br>
Many thanks in advance,<br>
<br>
Leander Koornneef<br>
</html>

--=====================_2493078==_.ALT--
