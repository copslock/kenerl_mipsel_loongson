Received:  by oss.sgi.com id <S553937AbRCGDhU>;
	Tue, 6 Mar 2001 19:37:20 -0800
Received: from ns.snowman.net ([63.80.4.34]:15877 "EHLO ns.snowman.net")
	by oss.sgi.com with ESMTP id <S553934AbRCGDgu>;
	Tue, 6 Mar 2001 19:36:50 -0800
Received: from localhost (nick@localhost)
	by ns.snowman.net (8.9.3/8.9.3/Debian 8.9.3-21) with ESMTP id WAA25833
	for <linux-mips@oss.sgi.com>; Tue, 6 Mar 2001 22:36:45 -0500
Date:   Tue, 6 Mar 2001 22:36:45 -0500 (EST)
From:   <nick@snowman.net>
X-Sender: nick@ns
cc:     linux-mips@oss.sgi.com
Subject: Problem makeing an O2 run bootp
In-Reply-To: <20010306135856.E1184@bacchus.dhis.org>
Message-ID: <Pine.LNX.4.21.0103062231010.23542-100000@ns>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To:     unlisted-recipients:; (no To-header on input)
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

I've got an o2 that I'm trying to make netboot, and it seems to work,
however the o2 never acks the tftp packets.  The tcpdump is attached.  If
anyone has suggestions/ideas I'd love to hear them.  I booted the o2 and
ran "bootp():" from the arc prompt.
	Thanks
		Nick
22:31:26.697102 arp who-has 10.1.1.3 tell 10.1.1.3
22:31:26.697348 10.1.1.3.bootpc > 255.255.255.255.bootps: xid:0xbbb2
secs:5 C:10.1.1.3 [|bootp]
22:31:26.698900 10.1.1.1.bootps > 10.1.1.3.bootpc: xid:0xbbb2 secs:5
C:10.1.1.3 Y:10.1.1.3 S:10.1.1.1 [|bootp] [tos 0x10]
22:31:26.699191 arp who-has 10.1.1.3 tell 10.1.1.3
22:31:26.710600 10.1.1.3.15283 > 10.1.1.1.tftp: 22 RRQ "vmlinuxo2"
22:31:26.741123 10.1.1.1.35447 > 10.1.1.3.15283: udp 516 (DF)
22:31:31.734006 arp who-has 10.1.1.3 tell 10.1.1.1
22:31:31.734156 arp reply 10.1.1.3 is-at 8:0:69:5:b8:cb
22:31:31.734291 10.1.1.1.35447 > 10.1.1.3.15283: udp 516 (DF)
22:31:36.734065 10.1.1.1.35447 > 10.1.1.3.15283: udp 516 (DF)
22:31:41.734046 10.1.1.1.35447 > 10.1.1.3.15283: udp 516 (DF)
22:31:46.734050 10.1.1.1.35447 > 10.1.1.3.15283: udp 516 (DF)
22:31:56.072778 10.1.1.3.15284 > 10.1.1.1.tftp: 22 RRQ "vmlinuxo2"
22:31:56.102821 10.1.1.1.35447 > 10.1.1.3.15284: udp 516 (DF)
22:32:01.094154 10.1.1.1.35447 > 10.1.1.3.15284: udp 516 (DF)
22:32:06.094045 10.1.1.1.35447 > 10.1.1.3.15284: udp 516 (DF)
22:32:11.094043 10.1.1.1.35447 > 10.1.1.3.15284: udp 516 (DF)
22:32:16.094071 10.1.1.1.35447 > 10.1.1.3.15284: udp 516 (DF)
22:32:21.094002 arp who-has 10.1.1.3 tell 10.1.1.1
22:32:21.094142 arp reply 10.1.1.3 is-at 8:0:69:5:b8:cb
22:32:26.000316 10.1.1.3.15285 > 10.1.1.1.tftp: 22 RRQ "vmlinuxo2"
22:32:26.030369 10.1.1.1.35447 > 10.1.1.3.15285: udp 516 (DF)
22:32:31.024092 10.1.1.1.35447 > 10.1.1.3.15285: udp 516 (DF)
22:32:36.024044 10.1.1.1.35447 > 10.1.1.3.15285: udp 516 (DF)
22:32:41.024045 10.1.1.1.35447 > 10.1.1.3.15285: udp 516 (DF)
22:32:46.024055 10.1.1.1.35447 > 10.1.1.3.15285: udp 516 (DF)
22:32:51.023999 arp who-has 10.1.1.3 tell 10.1.1.1
22:32:51.024138 arp reply 10.1.1.3 is-at 8:0:69:5:b8:cb
22:32:55.927938 10.1.1.3.15286 > 10.1.1.1.tftp: 22 RRQ "vmlinuxo2"
22:32:55.957167 10.1.1.1.35447 > 10.1.1.3.15286: udp 516 (DF)
22:33:00.954096 10.1.1.1.35447 > 10.1.1.3.15286: udp 516 (DF)
22:33:05.954047 10.1.1.1.35447 > 10.1.1.3.15286: udp 516 (DF)
22:33:10.954056 10.1.1.1.35447 > 10.1.1.3.15286: udp 516 (DF)
22:33:15.954051 10.1.1.1.35447 > 10.1.1.3.15286: udp 516 (DF)
22:33:20.954008 arp who-has 10.1.1.3 tell 10.1.1.1
22:33:20.954142 arp reply 10.1.1.3 is-at 8:0:69:5:b8:cb
