Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6KKvkr27272
	for linux-mips-outgoing; Fri, 20 Jul 2001 13:57:46 -0700
Received: from post.webmailer.de (natpost.webmailer.de [192.67.198.65])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6KKviV27268
	for <linux-mips@oss.sgi.com>; Fri, 20 Jul 2001 13:57:44 -0700
Received: from scotty.mgnet.de (pD902463B.dip.t-dialin.net [217.2.70.59])
	by post.webmailer.de (8.9.3/8.8.7) with SMTP id WAA20911
	for <linux-mips@oss.sgi.com>; Fri, 20 Jul 2001 22:57:41 +0200 (MET DST)
Received: (qmail 11311 invoked from network); 20 Jul 2001 20:57:40 -0000
Received: from spock.mgnet.de (192.168.1.4)
  by scotty.mgnet.de with SMTP; 20 Jul 2001 20:57:40 -0000
Date: Fri, 20 Jul 2001 22:57:33 +0200 (CEST)
From: Klaus Naumann <spock@mgnet.de>
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
cc: linux-mips@oss.sgi.com
Subject: Re: I2 R10K status?
In-Reply-To: <20010720220155.D16278@rembrandt.csv.ica.uni-stuttgart.de>
Message-ID: <Pine.LNX.4.21.0107202255320.8888-100000@spock.mgnet.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, 20 Jul 2001, Thiemo Seufer wrote:

> kernel space. The serial console drops characters on high
> throughput.

This is not a IP28 specific problem. Esp. on Backspace and such things
the current serial console just f*cks up. Also a lot of data throughput
will make things worse.

[snip]

> Console: ttyS0 (Zilog8530), 9600 baud

Try using 38400, it helps a bit I think ...

> Memory: 488192k/917500k available (1709k kernel code, 429308k reserved, 132k data, 88k init)
> Dentry-cache hash table entries: 131072 (order: 9, 2097152 bytes)
> Inode-cache hash table entries: 65536 (order: 8, 1048576 bytes)
> Buffer-cache hash table entries: 65536 (order: 7, 524288 bytes)
> Page-cache hash table entries: 262144 (order: 9, 2097152 bytes)

[snap]

		CU, Klaus

-- 
Full Name   : Klaus Naumann     | (http://www.mgnet.de/) (Germany)
Nickname    : Spock             | Org.: Mad Guys Network
Phone / FAX : ++49/177/7862964  | E-Mail: (spock@mgnet.de)
PGP Key     : www.mgnet.de/keys/key_spock.txt
