Received:  by oss.sgi.com id <S553795AbQK3I3Z>;
	Thu, 30 Nov 2000 00:29:25 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:21252 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S553792AbQK3I3D>; Thu, 30 Nov 2000 00:29:03 -0800
Received: from sgisgp.singapore.sgi.com (sgisgp.singapore.sgi.com [134.14.84.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via SMTP id AAA05675
	for <linux-mips@oss.sgi.com>; Thu, 30 Nov 2000 00:37:02 -0800 (PST)
	mail_from (calvine@sgi.com)
Received: from sgp-apsa001e--n.singapore.sgi.com by sgisgp.singapore.sgi.com via ESMTP (950413.SGI.8.6.12/930416.SGI)
	 id QAA13603; Thu, 30 Nov 2000 16:38:36 +0800
Received: by sgp-apsa001e--n.singapore.sgi.com with Internet Mail Service (5.5.2650.21)
	id <XQ01WLZ9>; Thu, 30 Nov 2000 16:32:14 +0800
Message-ID: <43FECA7CDC4CD411A4A3009027999112267CAB@sgp-apsa001e--n.singapore.sgi.com>
From:   Calvine Chew <calvine@sgi.com>
To:     "'Klaus Naumann'" <spock@mgnet.de>
Cc:     "'linux-mips@oss.sgi.com'" <linux-mips@oss.sgi.com>
Subject: RE: I'm stuck...
Date:   Thu, 30 Nov 2000 16:32:06 +0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hi Klaus...

> -----Original Message-----
> From: Klaus Naumann [mailto:spock@mgnet.de]
> Sent: Thursday, November 30, 2000 3:52 PM
> To: Calvine Chew
> Cc: 'linux-mips@oss.sgi.com'
> Subject: Re: I'm stuck...
> 
> On Thu, 30 Nov 2000, Calvine Chew wrote:
> 
> > Hi folks.
> 
> Hi there,
> 
>  
> > I'm trying to get Linux up on an Indy. I'm using an old 
> laptop to act as the
> > tftp/bootp/nfs server. I've installed
> > SuSE 6.4 on it and I am not sure if I've configured the 
> server properly. I
>   ^^^^-- This is your first mistake ... :)))
>   .oO(I hope Andreas doesn't read that)
>
I would have installed RedHat 6.2 (like a trueblue SGI-man :-) but
the boot kernel hits the PC Card Services hang on installation.
SuSE 6.4 doesn't, hooked up my ethernet/modem and scsi cards beautifully.
 
> > try tftp'ing and bootp'ing from the server
> > side, and both seem to respond to requests, however, when I 
> try from the
> > Indy client, the Indy just shoots back
> > a "server not found for vmlinux" when I do "boot -f 
> bootp():vmlinux".
> > 
> > How do I ensure that things on the server side are indeed configured
> > properly? Are there proper tests I can do?
> > For example, if I run "bootpd -s -d4" then run "bootptest", 
> bootpd reports
> > back a large number of things like
> > sending the linux kernel I exported via NFS, and something 
> about a magic
> > number, then bootptest quits. tftp
> > at the server side allows me to download files from the NFS 
> directory.
> > 
> > I already have numerous copies of readmes teaching me how 
> to install Linux
> > on MIPS, but somehow all of them
> > vary in many ways, especially the config parts. Is there 
> some install readme
> > for super-idiots like myself who need
> > to be told word for word what to do?
> 
> I have written a HOWTO for Linux on the Indigo2 - it's now 
> more and more
> a HOWTO for installing Linux on any SGI box ;)
> You can have a look at http://oss.sgi.com/mips/i2-howto.html
> I hope this helps a bit. ALso please don't miss the Pitfalls 
> section - 
> maybe you're hitting one of the described.
> 
When I try bootp from the Indy, my Linux bootp server doesn't
even respond. tcpdump doesn't report anything. The only things
I can confirm are working are that I can use tftp to grab files
off the exported nfsroot and I can use a program called bootptest
to send bootp requests to the bootp server. However, both are done
from the server end.

In fact if I were to configure bootptab to accept requests from the
server itself, bootptest reports this (apologies for the verbosity!!):

% bootptest
bootptest: version 2.4.3
Sending to 192.168.0.1 (request) htype:0 hlen:0 xld:706 C:192.168.0.1
vend-rfc1395
Revcd from 192.168.0.1 (reply) htype:0 hlen:0 xld:706 C:192.168.0.1
Y:192.168.0.1 S:192.168.0.1 sname:"calvine" file: "/linux/mipseb/vmlinux"
vend-rfc1395 SM:255.255.255.0 TZ:7200 ROOT:"/linux/mipseb"
%

bootpd itself (I'm running it on standalone mode) reports this:

%bootpd -s -d4
bootp: info(6): bootptab mtime: Wed Jan 11 17:054:20 1995   (excuse the
clock :-)
bootp: info(6): reading "/etc/bootptab"
bootp: info(6): read 1 entries (1 hosts) from "/etc/bootptab"
bootp: info(6): recvd pkt from IP addr 192.168.0.1
bootp: info(6): bootptab mtime: Wed Jan 11 17:054:20 1995
bootp: info(6): request from IP addr 192.168.0.1
bootp: info(6): found 192.168.0.1 (calvine.suse.sgi.com)
bootp: info(6): bootfile="/linux/mipseb/vmlinux"
bootp: info(6): vendor magic field is 99.130.83.99
bootp: info(6): sending reply (with RFC1048 options)

and my bootptab looks like this:

**** bootptab begin ****
calvine.suse.sgi.com:hd=/linux/mipseb:rp=/linux/mipseb:ht=ethernet:ha:blahbl
ah:ip=192.168.0.1:bf=vmlinux:sm=255.255.255.0:to=7200:
**** bootptab end ******

Everything seems to be in ship shape (is it?)... I'm thinking if it's a
hardware
issue. For example, this Indy of mine had a bad Dallas chip, so I swapped a
working chip from another dead Indy and placed it into the one I'm using.
Could also be a crosscable issue (it's Linux to Indy connection now), since
there just isn't any traffic going on.

Damn, this is getting really annoying. We really should be porting Irix to
IA,
instead of Linux to MIPS.

I realise that my issues are becoming more Linux than MIPS/Linux,
but honestly I can't be sure. I don't exactly have alot of resources to
do trial&error testing. I have a few years' Linux experience but never
bootp/remote booting. This mailing list was my last respite!


--
Calvine Chew, Technical Consultant
Technology & Industry Consulting Group (Asia South), SGI.
***************************************************************
Inter spem curamque, timores inter et iras, omnem crede diem tibi
diluxisse supremum: grata superveniet quae sperabitur hora.
http://www.cyberjunkie.com/arcana
***************************************************************
