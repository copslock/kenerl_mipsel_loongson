Received:  by oss.sgi.com id <S42263AbQE3SXH>;
	Tue, 30 May 2000 11:23:07 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:29238 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S42266AbQE3SWv>; Tue, 30 May 2000 11:22:51 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id LAA01830; Tue, 30 May 2000 11:51:32 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id LAA40307
	for linux-list;
	Tue, 30 May 2000 11:33:53 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id LAA11342
	for <linux@engr.sgi.com>;
	Tue, 30 May 2000 11:33:41 -0700 (PDT)
	mail_from (csr6702@grace.rit.edu)
Received: from mailout3.nyroc.rr.com (mailout3-1.nyroc.rr.com [24.92.226.168]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id KAA09628
	for <linux@engr.sgi.com>; Tue, 30 May 2000 10:39:44 -0700 (PDT)
	mail_from (csr6702@grace.rit.edu)
Received: from hork.rochester.rr.com (d185d0f95.rochester.rr.com [24.93.15.149])
	by mailout3.nyroc.rr.com (8.9.3/8.9.3) with ESMTP id NAA20265;
	Tue, 30 May 2000 13:32:24 -0400 (EDT)
Received: from molotov (helo=localhost)
	by hork.rochester.rr.com with local-esmtp (Exim 3.12 #1 (Debian))
	id 12wpzS-0008TH-00; Tue, 30 May 2000 13:39:42 -0400
Date:   Tue, 30 May 2000 13:39:42 -0400 (EDT)
From:   Chris Ruvolo <csr6702@grace.rit.edu>
To:     linux-mips@fnet.fr, linux@cthulhu.engr.sgi.com,
        linux-mips@vger.rutgers.edu
Message-ID: <Pine.LNX.4.21.0005301242430.32360-100000@hork.rochester.rr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

Hello all.

Please cc all replies to me as I am not subscribed to the list.

I recently obtained a SGI Indy.  The hard disk is totally wiped out, with
no OS on it at all.  No IRIX, no sash, no Linux, no nothing.  The machine
has no floppy or CD-ROM drive, but it seems that the boot PROM has a way
of accessing a remote kernel using bootp and tftp.

I want to get linux on this system, but I'm not sure about some of the
details.  I don't have other machines with SCSI interfaces that I could
partition/write to this disk.  Where do I go from here?  I've been trying
to tftp a kernel.. but no luck.  How do i mount a root partition?  NFS?  
How do I partition this box with a SGI partition table if I don't have the
irix 'fx' tool?  Will I have to boot off of a bootp/tftp server
permanently?

Has anyone tried this before?  Had any luck?  Any advise you can give
would be appreciated.

I've been trying to bootp/tftp a kernel with no luck.  I am running a
bootp server on an i386 machine, and it sees the sgi's requests and issues
replies, but the indy ignores them enitrely.


In the following, lestrade is the indy, with IP 192.168.0.105.  hork is
the bootp/tftp server with IP 192.168.0.17.

Here is a transcript of the prom monitor:


>> boot -f bootp()/mips/vmlinux
No server for /mips/vmlinux.
Your netaddr environment variable may be set incorrectly, or
the net may be too busy for a connection to be made.
Unable to load bootp()/mips/vmlinux: could not contact remote server.


Here is output from my bootp server:

# bootpd -v
bootpd+dhcp 2.4.3
# bootpd -d4
bootpd: info(6):   bootptab mtime: Tue May 30 12:20:38 2000
bootpd: info(6):   reading "/etc/bootptab"
bootpd: info(6):   read 1 entries (1 hosts) from "/etc/bootptab"
bootpd: info(6):   recvd pkt from IP addr 192.168.0.105
bootpd: info(6):   bootptab mtime: Tue May 30 12:20:38 2000
bootpd: info(6):   request from IP addr 192.168.0.105
bootpd: info(6):   found 192.168.0.105 (lestrade)
bootpd: info(6):   requested path="mips"  file="vmlinux"
bootpd: info(6):   bootfile="/mips/vmlinux"
bootpd: info(6):   vendor magic field is 0.0.0.0
bootpd: info(6):   sending reply (with no options)
[repeat 3x]


my bootptab file:

# /etc/bootptab: database for bootp server (/usr/sbin/bootpd)
# Blank lines and lines beginning with '#' are ignored.
lestrade: hd=mips\
        :td=/usr/local/share/tftpboot:\
        :rp=/usr/local/share/tftpboot:\
        :ht=ethernet:\
        :ha=0x080069078c4f:\
        :sm=255.255.255.0:\
        :ip=192.168.0.105:\
        :hn:\
        :to=auto:



If you look at this excerpt from tcpdump, it looks like its working
properly.  I don't see why its being ignored by the sgi.

12:21:35.835809 arp who-has 192.168.0.105 tell 192.168.0.105
12:21:35.837489 192.168.0.105.68 > 255.255.255.255.67: xid:0x812b 
	C:192.168.0.105 file "mips/vmlinux
12:21:35.843089 arp who-has 192.168.0.105 tell 192.168.0.17
12:21:35.843524 arp reply 192.168.0.105 is-at 8:0:69:7:8c:4f
12:21:35.843549 192.168.0.17.67 > 192.168.0.105.68: xid:0x812b 
	C:192.168.0.105 Y:192.168.0.105 S:192.168.0.17 sname
	"hork.rochester.rr.com file "/mips/vmlinux (DF)



If anyone can offer any suggestions or explanation, I would certainly
appreciate it.

Thanks in advance,
Chris
