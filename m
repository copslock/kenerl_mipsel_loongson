Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4NEcCB09362
	for linux-mips-outgoing; Wed, 23 May 2001 07:38:12 -0700
Received: from iris1.csv.ica.uni-stuttgart.de (iris1.csv.ica.uni-stuttgart.de [129.69.118.2])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f4NEcAF09359
	for <linux-mips@oss.sgi.com>; Wed, 23 May 2001 07:38:11 -0700
Received: from rembrandt.csv.ica.uni-stuttgart.de (rembrandt.csv.ica.uni-stuttgart.de [129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de (8.9.3/8.9.3) with ESMTP id QAA58094
	for <linux-mips@oss.sgi.com>; Wed, 23 May 2001 16:38:09 +0200 (MDT)
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.22 #1 (Debian))
	id 152Zm5-000351-00
	for <linux-mips@oss.sgi.com>; Wed, 23 May 2001 16:38:09 +0200
Date: Wed, 23 May 2001 16:38:09 +0200
To: linux-mips <linux-mips@oss.sgi.com>
Subject: Re: n64
Message-ID: <20010523163809.B11643@rembrandt.csv.ica.uni-stuttgart.de>
References: <3B0ABCD8.6080906@csh.rit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <3B0ABCD8.6080906@csh.rit.edu>; from werkt@csh.rit.edu on Tue, May 22, 2001 at 03:24:08PM -0400
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

George Gensure wrote:
>I remember seeing something about having an n64 run a port of linux, 
>since it ran (correct me if i'm wrong) an R4400 mips... has anything 
>been done on that?

I currently do, based on the existing source under arch/mips64 with
Indigo2 R10000 Impact as target. No, it isn't working yet.

A recent kernel and it's bootlog can be found at
http://www.csv.ica.uni-stuttgart.de/homes/ths/linux-mips/


Thiemo
