Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBEMo6011215
	for linux-mips-outgoing; Fri, 14 Dec 2001 14:50:06 -0800
Received: from mail.ivivity.com (user-vc8ftn3.biz.mindspring.com [216.135.246.227])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBEMo2o11211
	for <linux-mips@oss.sgi.com>; Fri, 14 Dec 2001 14:50:02 -0800
Received: by ATLOPS with Internet Mail Service (5.5.2448.0)
	id <QMJC3GGG>; Fri, 14 Dec 2001 16:49:53 -0500
Message-ID: <25369470B6F0D41194820002B328BDD21423F1@ATLOPS>
From: Dinesh Nagpure <dinesh_nagpure@ivivity.com>
To: "'Justin Carlson'" <justincarlson@cmu.edu>,
   Dinesh Nagpure
	 <dinesh_nagpure@ivivity.com>
Cc: linux-mips@oss.sgi.com
Subject: RE: 2.4.16 on mips-malta, networking fails...
Date: Fri, 14 Dec 2001 16:49:52 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2448.0)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Isn't passing ip= command line boot option sufficient for this?
I mean I sure will have ifconfig and route in the root but for now all I
want is to make things work.

Dinesh

-----Original Message-----
From: Justin Carlson [mailto:justincarlson@cmu.edu]
Sent: Friday, December 14, 2001 3:50 PM
To: Dinesh Nagpure
Cc: linux-mips@oss.sgi.com
Subject: RE: 2.4.16 on mips-malta, networking fails...


On Fri, 2001-12-14 at 15:25, Dinesh Nagpure wrote:

> Apparently the device is being detected.
> I am using ramdisk root which i created using busybox v0.60.1 and dont
have
> ifconfig or route built into it.
> 

How are you setting the IP information for the NIC, then?  Are you
compiling a kernel with IP autoconfiguration and using a DHCP server?  

If you're not configuring the NIC, then the OS doesn't consider it to be
a valid source/target of IP information, so when you try to ping from
the machine, Linux is telling you "I don't have any valid place to put
an ICMP packet to get to the place you want it to go".  

-Justin
