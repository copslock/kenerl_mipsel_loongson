Received:  by oss.sgi.com id <S42275AbQFBPOG>;
	Fri, 2 Jun 2000 08:14:06 -0700
Received: from mail.exfo.com ([206.191.88.36]:46859 "EHLO mail.exfo.com")
	by oss.sgi.com with ESMTP id <S42240AbQFBPNx>;
	Fri, 2 Jun 2000 08:13:53 -0700
Received: from exfo.com ([172.16.46.216]) by mail.exfo.com
          (Netscape Messaging Server 3.62)  with ESMTP id 755
          for <linux-mips@oss.sgi.com>; Fri, 2 Jun 2000 11:13:17 -0400
Message-ID: <3937CFE8.C1248EC0@exfo.com>
Date:   Fri, 02 Jun 2000 11:16:56 -0400
From:   "Philippe Chauvat" <philippe.chauvat@exfo.com>
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: fr,en
MIME-Version: 1.0
To:     Linux Mips <linux-mips@oss.sgi.com>
Subject: [HELP!: Boot Hardrat Pb]
Content-Type: multipart/mixed;
 boundary="------------69C24E707A31C1F0746D2134"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

This is a multi-part message in MIME format.
--------------69C24E707A31C1F0746D2134
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hello,

Hey ! I've successed with BOOTP and DHCP
First of all, I've installed the last version of isc DHCP/BOOTP and I've
corrected a mistake in my inetd.conf file. So I progress... :-)

When my IrixBox boot on my LinuxBox with bootp, something wrong
happened:
Kernel Panic due to a /tftpboot/pancake mounting problem (pancake is the
hostname of IrixBox)

I'ld precise that in my inetd.conf, tftp is written like the following
line:
tftp ..... /usr/sbin/tftp in.tftp /my/local/mount/point

So what's about this message  (and why) ? What does this directory
contain ?

Thanks for your help.
Philippe

--------------69C24E707A31C1F0746D2134
Content-Type: text/x-vcard; charset=us-ascii;
 name="pchauvat.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Card for Philippe Chauvat
Content-Disposition: attachment;
 filename="pchauvat.vcf"

begin:vcard 
n:Chauvat;Philippe
tel;work:+1 (418) 683 0913 #3663
x-mozilla-html:FALSE
url:www.exfo.com
org:Exfo O.E. inc.
adr:;;465 Avenue Godin;Vanier;Quebec;G1M 3G7;Canada
version:2.1
email;internet:philippe.chauvat@exfo.com
title:Manager, Web Tools Deployment
fn:Philippe Chauvat
end:vcard

--------------69C24E707A31C1F0746D2134--
