Received:  by oss.sgi.com id <S553894AbQK3SpA>;
	Thu, 30 Nov 2000 10:45:00 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:56190 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S553888AbQK3Som>;
	Thu, 30 Nov 2000 10:44:42 -0800
Received: from thor ([207.246.91.243]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via SMTP id KAA24164
	for <linux-mips@oss.sgi.com>; Thu, 30 Nov 2000 10:44:36 -0800 (PST)
	mail_from (jsk@tetracon-eng.net)
Received: from localhost (localhost [127.0.0.1]) by thor (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id NAA10351; Thu, 30 Nov 2000 13:41:25 -0500
Date:   Thu, 30 Nov 2000 13:41:25 -0500
From:   "J. Scott Kasten" <jsk@tetracon-eng.net>
To:     Calvine Chew <calvine@sgi.com>
cc:     "'Klaus Naumann'" <spock@mgnet.de>,
        "'linux-mips@oss.sgi.com'" <linux-mips@oss.sgi.com>
Subject: RE: I'm stuck...
In-Reply-To: <43FECA7CDC4CD411A4A3009027999112267CAB@sgp-apsa001e--n.singapore.sgi.com>
Message-ID: <Pine.SGI.4.10.10011301337040.10324-100000@thor.tetracon-eng.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


I'm using the ISC DHCP server under RH.  I've configured it to offer bootp
to the specific hardware address of the SGI box.  here's an excerpt:


subnet 192.168.254.0 netmask 255.255.255.0 {
        server-name "minerva";
        next-server 192.168.254.1;
        option domain-name-servers 192.168.254.1;
        option routers 192.168.254.1;
        option root-path "/mnt/archives/SimpleLinux-0.1_Indy";

        host SGI {
                hardware ethernet 08:00:69:09:13:9A;
                fixed-address 192.168.254.240;
                filename "vmlinux";
        }
 }

The 192.168.254.1 host is also the tftp and nfs server.  If I recall
correctly, the tftp and nfs server must be the same host.

Good luck.


> > > I'm trying to get Linux up on an Indy. I'm using an old 
> > laptop to act as the
> > > tftp/bootp/nfs server. I've installed
> > > SuSE 6.4 on it and I am not sure if I've configured the 
> > server properly. I
> >   ^^^^-- This is your first mistake ... :)))
> >   .oO(I hope Andreas doesn't read that)
> >
> I would have installed RedHat 6.2 (like a trueblue SGI-man :-) but
> the boot kernel hits the PC Card Services hang on installation.
> SuSE 6.4 doesn't, hooked up my ethernet/modem and scsi cards beautifully.
>  
> > > try tftp'ing and bootp'ing from the server
> > > side, and both seem to respond to requests, however, when I 
> > try from the
> > > Indy client, the Indy just shoots back
> > > a "server not found for vmlinux" when I do "boot -f 
> > bootp():vmlinux".
> > > 
