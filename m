Received:  by oss.sgi.com id <S42208AbQFVOhP>;
	Thu, 22 Jun 2000 07:37:15 -0700
Received: from mta07-svc.ntlworld.com ([62.253.162.47]:10370 "EHLO
        mta07-svc.ntlworld.com") by oss.sgi.com with ESMTP
	id <S42191AbQFVOg6>; Thu, 22 Jun 2000 07:36:58 -0700
Received: from icserver.ichilton.co.uk ([62.252.240.253])
          by mta02-svc.server.ntlworld.com
          (InterMail vM.4.01.02.27 201-229-119-110) with ESMTP
          id <20000622153514.LEQU10065.mta02-svc.server.ntlworld.com@icserver.ichilton.co.uk>
          for <linux-mips@oss.sgi.com>; Thu, 22 Jun 2000 15:35:14 +0000
Received: from ian (ian.ichilton.local [192.168.0.8])
	by icserver.ichilton.co.uk (8.10.2/8.10.1) with SMTP id e5MEXjv14082
	for <linux-mips@oss.sgi.com>; Thu, 22 Jun 2000 15:33:45 +0100
From:   "Ian Chilton" <mailinglist@ichilton.co.uk>
To:     "Linux-MIPS Mailing List" <linux-mips@oss.sgi.com>
Subject: Bootp Problems
Date:   Thu, 22 Jun 2000 15:33:44 +0100
Message-ID: <NAENLMKGGBDKLPONCDDOEENNCNAA.mailinglist@ichilton.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4132.2800
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hello,

I have been using bootp/tftp/nfs to boot my Indy fine, but I need to do
something else on the linux machine that is acting as the server (which was
my linux workstation), so I decided to move the bootp/tftp/nfs stuff to my
main network server which is running Linux completly compiled from source.

So, I compiled/installed the following:

* bootp-2.4.3
* netkit-tftp-0.16
* tcp_wrappers_7.6
* portmap_5beta
* nfs-server-2.2beta47

Now, I have tested the NFS from another linux box, and from the indy, and it
seems to work fine.

I have setup my bootp/tftp the same as before, and that is as follows:
BTW network addresses:
ICServer  ->  192.168.0.1   ->  Linux Server (the new bootp/tftp/nfs server)
ICLinux   ->  192.168.0.11  ->  Linux W/S (the old bootp/tftp/nfs server)
ICIndy    ->  192.168.0.12  ->  SGI Indy


/etc/inetd.conf:
tftp    dgram   udp     wait    root    /usr/sbin/tcpd /usr/sbin/in.tftpd
/export/simple
bootps  dgram   udp     wait    root    /usr/sbin/bootpd /etc/bootptab


/etc/bootptab:
icindy:hd=/export/simple:\
        :rp=/export/simple:\
        :ht=ethernet:\
        :ha=080069082CD1:\
        :ip=192.168.0.12:\
        :bf=vmlinux:\
        :sm=255.255.255.0:\
        :to=7200:

/etc/exports:
/export/simple 192.168.0.12(no_root_swash,rw)


I then did: kill -HUP <pid of inetd) and loaded portmap, rpc.mountd and
rpc.nfsd

When I tried to boot my Indy, with the line:
boot bootp:vmlinux nfsroot=192.168.0.1:/export/simple

It worked :)

Then, I realised, the old bootp server was still on, so I shut this down.
Then, using the same command, it failed in the command monitor.
I realised that the 'make install' had put the bootpd binaries in /usr/etc
instead of /usr/sbin, so I moved these, restarted inetd, and this leads to
my problem:

I type the above boot command, it gets the kernel, starts booting linux, and
does the following:

[SNIP OK Stuff]
eth0: SGI Seeq8003 08:00:69:08:2c:d1
Sending BOOTP requests.................. timed out!
IP-Config: Auto-configuration of network failed.
Partition check:
sda: sda1 sda2 sda3 sda4 sda5 sda6 sda7
sdb: sdb1 sdb2 sdb3
Looking up port of RPC 100003/2 on 192.168.0.1
RPC: sendmsg returned error 128
RPC: sendmsg returned error 128
RPC: sendmsg returned error 128
RPC: sendmsg returned error 128
portmap: server not responding, timed out
Root-NFS: Unable to get nfsd port number from server, using default
Looking up port of RPC 100003/2 on 192.168.0.1
RPC: sendmsg returned error 128
RPC: sendmsg returned error 128
RPC: sendmsg returned error 128
RPC: sendmsg returned error 128
portmap: server not responding, timed out
Root-NFS: Unable to get nfsd port number from server, using default
RPC: sendmsg returned error 128
RPC: sendmsg returned error 128
RPC: sendmsg returned error 128
RPC: sendmsg returned error 128
mount: server 192.168.0.1 not responding, timed out
Root-NFS: Server returned error -5 while mounting /export/simple
VFS: Unable to mount root fs via NFS, trying floppy
VFS: Cannot open root device 02:00
Kernel Panic: VFS: Unable to mount root device on 02:00


I did try the bootp binary from ICLinux, wich still works when i turn it on,
but this didn't work either  :(


Any ideas anyone?


Thanks in Advance!


Bye for Now,

Ian


                     \|||/
                     (o o)
 /----------------ooO-(_)-Ooo----------------\
 |  Ian Chilton                              |
 |  IRC Nick : GadgetMan                     |
 |  E-Mail   : ian@ichilton.co.uk            |
 \-------------------------------------------/
