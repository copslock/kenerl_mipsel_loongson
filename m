Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9OF40X12542
	for linux-mips-outgoing; Wed, 24 Oct 2001 08:04:00 -0700
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9OF3vD12538
	for <linux-mips@oss.sgi.com>; Wed, 24 Oct 2001 08:03:57 -0700
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 80CBE125C9; Wed, 24 Oct 2001 08:03:56 -0700 (PDT)
Date: Wed, 24 Oct 2001 08:03:56 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: linux-mips@oss.sgi.com
Subject: I am looking for a mips machine
Message-ID: <20011024080356.A2440@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi,

I am looking for a mips machine to continue working on my mips port
of RedHat. My requirements are

1. It has the stable, up to date kernel support. That means I can do

# ./configure
# make bootstrap
# make check

for gcc 3.1 without a kernel oops.

2. It has decent CPU. I hate to wait a day for

# make bootstrap

3. Inexpensive.

4. Support serial console.

5. Little endian is preferred.

Does anyone have any recommendations?

Thanks.


H.J.
