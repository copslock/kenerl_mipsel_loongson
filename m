Received: from pneumatic-tube.sgi.com (pneumatic-tube.sgi.com [204.94.214.22])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id RAA09545
	for <pstadt@stud.fh-heilbronn.de>; Thu, 8 Jul 1999 17:38:47 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id IAA4961172; Thu, 8 Jul 1999 08:29:32 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id IAA73628
	for linux-list;
	Thu, 8 Jul 1999 08:22:32 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from beyond.clubfed.sgi.com (beyond.clubfed.sgi.com [169.238.1.2])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id IAA53924
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 8 Jul 1999 08:22:30 -0700 (PDT)
	mail_from (npearl@clubfed.sgi.com)
Received: from tenampa.clubfed.sgi.com by beyond.clubfed.sgi.com via ESMTP (980427.SGI.8.8.8/940406.SGI)
	for <@beyond.clubfed.sgi.com:linux@cthulhu.engr.sgi.com> id LAA90616; Thu, 8 Jul 1999 11:22:29 -0400 (EDT)
Received: from clubfed.sgi.com (localhost [127.0.0.1]) by tenampa.clubfed.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id LAA24954 for <linux@cthulhu.engr>; Thu, 8 Jul 1999 11:22:28 -0400 (EDT)
Message-ID: <3784C234.F6500BC6@clubfed.sgi.com>
Date: Thu, 08 Jul 1999 11:22:28 -0400
From: Nate Pearlstein <npearl@clubfed.sgi.com>
Organization: SGI South Eastern Field Technical Support
X-Mailer: Mozilla 4.61C-SGI [en] (X11; U; IRIX 6.5 IP32)
X-Accept-Language: en
MIME-Version: 1.0
To: linux@cthulhu.engr.sgi.com
Subject: challenge s install woes.
Content-Type: multipart/mixed;
 boundary="------------08A53E2319A4FFDD5E74667C"
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

This is a multi-part message in MIME format.
--------------08A53E2319A4FFDD5E74667C
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hello,

The latest document on www.linux.sgi.com,
http://www.linux.sgi.com/mips/manhattan , that gives instructions for
installing harhat 5.1 on SGI Indy, in my case a chall s has that little
section at the end called:

Running Linux on Challenge S.

I was able to run the linux install process, though using IRISconsole to
talk to serial port 1 on the back of the challenge s is really bizarre. 
The screen redraws are odd and it usually requires 2 character inputs to
really do something.  that is having to press space bar twice or figure
out how many tabs to press to get back to the button you want and then
press space, but I digress.

Anyway, it says Don't forget to change setup-1.9.1-2.noarch.rpm to add
some securetty's so that you can log in over the network.  My problem is
that I don't know hoe to edit a *.rpm file.  I can't figure out how to
extract a rpm spec file.  I would like to just leave out the securettys
file all together for now.

After reading the rpm man page I can see how to create an rpm file and I
know how to extract the files that get installed from an rpm but I don't
want to accidentally forget something that may be only mentioned in a
spec file.

Right now I have a machine that is pingable and telnetd responds to
telnet but of course I can't get in.


I tried to boot using the installfs as the root file system but it
immediately launches the install program, I'm trying to use the nfsroot
to get at my /dev/sdb1 so that I can remove the /etc/securettys file.



Any suggestions?  Thanks


Thanks

Later
-- 
===============================================================
		50% of all statistics are inaccurate.
===============================================================
Nate Pearlstein - npearl@sgi.com - Field Technical Analyst
--------------08A53E2319A4FFDD5E74667C
Content-Type: text/x-vcard; charset=us-ascii;
 name="npearl.vcf"
Content-Description: Card for Nate Pearlstein
Content-Disposition: attachment;
 filename="npearl.vcf"
Content-Transfer-Encoding: 7bit

begin:vcard 
n:Pearlstein;Nate
tel;pager:1-888-740-4081
tel;cell:301-641-5717
tel;fax:301-595-2637
tel;work:301-595-2629
x-mozilla-html:FALSE
org:SGI South Eastern Field Technical Support
adr:;;12200-G Plum Orchard Dr.;Silver Spring;MD;20709;USA
version:2.1
email;internet:npearl@sgi.com
title:Field Technical Analyst
x-mozilla-cpt:;14656
fn:Nate Pearlstein
end:vcard

--------------08A53E2319A4FFDD5E74667C--
