Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fATIMpq22724
	for linux-mips-outgoing; Thu, 29 Nov 2001 10:22:51 -0800
Received: from server3.toshibatv.com ([207.152.29.75])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fATIMmo22721
	for <linux-mips@oss.sgi.com>; Thu, 29 Nov 2001 10:22:48 -0800
Received: by SERVER3 with Internet Mail Service (5.5.2653.19)
	id <VJ2W67C0>; Thu, 29 Nov 2001 11:22:29 -0600
Message-ID: <7DF7BFDC95ECD411B4010090278A44CA1B7476@ATVX>
From: "Siders, Keith" <keith_siders@toshibatv.com>
To: "Linux-Mips (E-mail)" <linux-mips@oss.sgi.com>
Subject: Memory usage profiling
Date: Thu, 29 Nov 2001 11:21:33 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I"ve been given the "honor" of pofiling our current linux-based system for
memory usage. I have a single process of primary concern which has a number
of pthreads running. I need to profile the memory usage of the pthreads.
What's the best (and/or quickest) way to do that?

Keith Siders
Software Engineer
 Toshiba America Consumer Products, Inc.
Advanced Television Technology Center
801 Royal Parkway, Suite 100
Nashville, Tennessee 37214
Phone: (615) 257-4050
Fax:   (615) 453-7880
