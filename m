Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6KLXJU29439
	for linux-mips-outgoing; Fri, 20 Jul 2001 14:33:19 -0700
Received: from iris1.csv.ica.uni-stuttgart.de (iris1.csv.ica.uni-stuttgart.de [129.69.118.2])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6KLXIV29434
	for <linux-mips@oss.sgi.com>; Fri, 20 Jul 2001 14:33:18 -0700
Received: from rembrandt.csv.ica.uni-stuttgart.de (rembrandt.csv.ica.uni-stuttgart.de [129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de (8.9.3/8.9.3) with ESMTP id XAA05569
	for <linux-mips@oss.sgi.com>; Fri, 20 Jul 2001 23:33:16 +0200 (MDT)
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.22 #1 (Debian))
	id 15Nhtc-0007lb-00
	for <linux-mips@oss.sgi.com>; Fri, 20 Jul 2001 23:33:16 +0200
Date: Fri, 20 Jul 2001 23:33:16 +0200
To: linux-mips@oss.sgi.com
Subject: Re: I2 R10K status?
Message-ID: <20010720233316.E16278@rembrandt.csv.ica.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0107202255320.8888-100000@spock.mgnet.de>
User-Agent: Mutt/1.3.18i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Klaus Naumann wrote:
[snip]
> > Console: ttyS0 (Zilog8530), 9600 baud
> 
> Try using 38400, it helps a bit I think ...

Thanks, I'll try it out.

> > Memory: 488192k/917500k available (1709k kernel code, 429308k reserved, 132k data, 88k init)
> > Dentry-cache hash table entries: 131072 (order: 9, 2097152 bytes)
> > Inode-cache hash table entries: 65536 (order: 8, 1048576 bytes)
> > Buffer-cache hash table entries: 65536 (order: 7, 524288 bytes)
> > Page-cache hash table entries: 262144 (order: 9, 2097152 bytes)

I forgot, there's something wrong here: My machine has 512MB RAM,
I don't know how these numbers were computed.


Thiemo
