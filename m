Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8HGFb707708
	for linux-mips-outgoing; Mon, 17 Sep 2001 09:15:37 -0700
Received: from fenris.scrooge.dk (213.237.12.36.adsl.ynoe.worldonline.dk [213.237.12.36])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8HGFZe07705
	for <linux-mips@oss.sgi.com>; Mon, 17 Sep 2001 09:15:35 -0700
Received: from athlon-800 (athlon-pc [10.0.0.2])
	by fenris.scrooge.dk (8.11.5/8.8.7) with ESMTP id f8HGGSm21525;
	Mon, 17 Sep 2001 18:16:28 +0200
From: "Soeren Laursen" <soeren.laursen@scrooge.dk>
To: <linux-mips@oss.sgi.com>, George Gensure <werkt@csh.rit.edu>
Date: Mon, 17 Sep 2001 18:16:34 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: openssh probs
Reply-to: soeren.laursen@scrooge.dk
Message-ID: <3BA63E02.20088.2100546@localhost>
In-reply-to: <Pine.SOL.4.31.0109171207130.15518-100000@fury.csh.rit.edu>
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> Has anyone had any success running openssh on an Indy r5000? Currently
> running 2.4.8 #4, and the error I get when running ssh is "Disconnecting:
> Corrupted MAC on input."
Yep, upgraded to openssh 2.x and the vanished.

I guess it was an implementation error because I got it as well on 
i386 running openssh 1.x.

It depended on the client software as well. Other systems running 
openssh could connect. Client from www.ssh.com could not 
connect.

Best regards,

Soeren,
