Received:  by oss.sgi.com id <S554045AbQKHVIl>;
	Wed, 8 Nov 2000 13:08:41 -0800
Received: from orzan.fi.udc.es ([193.144.60.19]:14722 "EHLO orzan.fi.udc.es")
	by oss.sgi.com with ESMTP id <S553660AbQKHVIV>;
	Wed, 8 Nov 2000 13:08:21 -0800
Received: from serpe.mitica (mail@vexeta.dc.fi.udc.es [193.144.51.32])
	by orzan.fi.udc.es (8.9.3/8.9.1) with ESMTP id WAA18458;
	Wed, 8 Nov 2000 22:08:02 +0100 (MET)
Received: from quintela by serpe.mitica with local (Exim 3.16 #1 (Debian))
	id 13taUA-0000IL-00; Wed, 08 Nov 2000 20:02:14 +0100
To:     Klaus Naumann <spock@mgnet.de>, linux-mips@oss.sgi.com
Subject: TCP dump trace
X-Url:  http://carpanta.dc.fi.udc.es/~quintela
From:   "Juan J. Quintela" <quintela@fi.udc.es>
Date:   08 Nov 2000 20:02:14 +0100
Message-ID: <yttg0l2uw21.fsf@serpe.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


Hi
        I am trying to boot an I2.  The Indigo 2 needs an ecoff binary
        for booting (i.e. an ELF image is not good).

        I have set up tftp and dhcp.  Both of them are working ok (at
        least they are able to boot my Multia without any problem).

        server machine:
               serpe.mitica: Linux x86 test10
                             debian woody
               Yes, I have done the:
                    echo 1 > /proc/sys/net/ipv4/ip_no_pmtu_disc
        client machine:
               indigo 2: trying to boot sash & kernel in ecoff format
               (same error).

Entries in /var/log/daemon.log

Nov  8 19:55:57 serpe dhcpd-2.2.x: BOOTREQUEST from 08:00:69:07:1e:7f via eth0 (non-rfc1048)
Nov  8 19:55:57 serpe dhcpd-2.2.x: BOOTREPLY for 192.168.10.13 to meiga (08:00:69:07:1e:7f) via eth0
Nov  8 19:55:58 serpe in.tftpd[1135]: connect from meiga.mitica
Nov  8 19:55:58 serpe tftpd[1136]: tftpd: trying to get file: i2.ecoff
Nov  8 19:55:58 serpe tftpd[1136]: tftpd: serving file from /home/tftpboot


Yes, I wanted to boot the file i2.ecoff in meiga, everything looks ok
here.

Now the tcpdump -vvv -i eth0 output

19:55:57.852630 arp who-has meiga.mitica tell meiga.mitica
19:55:57.853168 meiga.mitica.bootpc > 255.255.255.255.bootps: xid:0xdee8 secs:5 C:meiga.mitica [|bootp] (ttl 255, id 49)
19:55:57.854112 serpe.mitica.bootps > meiga.mitica.bootpc: xid:0xdee8 secs:5 C:meiga.mitica Y:meiga.mitica S:serpe.mitica [|bootp] [tos 0x10] (ttl 16, id 0)
19:55:57.854888 arp who-has meiga.mitica tell meiga.mitica
19:55:57.934563 meiga.mitica.7913 > serpe.mitica.tftp: 21 RRQ "i2.ecoff" (ttl 255, id 50)
19:55:58.076108 serpe.mitica.32776 > meiga.mitica.7913: udp 516 (ttl 64, id 41004)
19:55:58.077099 meiga.mitica.7913 > serpe.mitica.32776: udp 6 (ttl 255, id 51)
19:55:58.081840 serpe.mitica.32776 > meiga.mitica.7913: udp 516 (ttl 64, id 41260)
19:56:03.069430 arp who-has meiga.mitica tell serpe.mitica
19:56:03.069883 arp reply meiga.mitica is-at 8:0:69:7:1e:7f
19:56:03.079855 serpe.mitica.32776 > meiga.mitica.7913: udp 516 (ttl 64, id 41516)
19:56:08.079263 serpe.mitica.32776 > meiga.mitica.7913: udp 516 (ttl 64, id 41772)
19:56:13.078798 serpe.mitica.32776 > meiga.mitica.7913: udp 516 (ttl 64, id 42028)
19:56:18.078397 serpe.mitica.32776 > meiga.mitica.7913: udp 516 (ttl 64, id 42284)
19:56:27.704048 meiga.mitica.7913 > serpe.mitica.32776: udp 6 (ttl 255, id 52)
19:56:27.704112 serpe.mitica > meiga.mitica: icmp: serpe.mitica udp port 32776 unreachable (DF) [tos 0xc0] (ttl 255, id 0)
19:56:57.706480 meiga.mitica.7913 > serpe.mitica.32776: udp 6 (ttl 255, id 53)
19:56:57.706564 serpe.mitica > meiga.mitica: icmp: serpe.mitica udp port 32776 unreachable (DF) [tos 0xc0] (ttl 255, id 0)
19:57:02.704267 arp who-has meiga.mitica tell serpe.mitica
19:57:02.704708 arp reply meiga.mitica is-at 8:0:69:7:1e:7f
19:57:27.709047 meiga.mitica.7913 > serpe.mitica.32776: udp 6 (ttl 255, id 54)
19:57:27.709140 serpe.mitica > meiga.mitica: icmp: serpe.mitica udp port 32776 unreachable (DF) [tos 0xc0] (ttl 255, id 0)
19:57:57.711458 meiga.mitica.7913 > serpe.mitica.32776: udp 6 (ttl 255, id 55)
19:57:57.711543 serpe.mitica > meiga.mitica: icmp: serpe.mitica udp port 32776 unreachable (DF) [tos 0xc0] (ttl 255, id 0)
19:58:02.709064 arp who-has meiga.mitica tell serpe.mitica
19:58:02.709327 arp reply meiga.mitica is-at 8:0:69:7:1e:7f
19:58:27.808524 meiga.mitica.7913 > serpe.mitica.32776: udp 6 (ttl 255, id 56)
19:58:27.808598 serpe.mitica > meiga.mitica: icmp: serpe.mitica udp port 32776 unreachable (DF) [tos 0xc0] (ttl 255, id 0)


Notice that the sender (serpe) sends 3 packets to the i2 (meiga),
there is no ack, and after some time, meiga answer to the previous
port, and serpe tells meiga that the port is unreachable.

Any suggestion???

Later, Juan.        

-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
