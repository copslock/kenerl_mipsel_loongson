Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g67KceRw000910
	for <linux-mips-outgoing@oss.sgi.com>; Sun, 7 Jul 2002 13:38:40 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g67Kcdf8000909
	for linux-mips-outgoing; Sun, 7 Jul 2002 13:38:39 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from pimout4-int.prodigy.net (pimout4-ext.prodigy.net [207.115.63.103])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g67KcZRw000900
	for <linux-mips@oss.sgi.com>; Sun, 7 Jul 2002 13:38:36 -0700
Received: from Muruga.localdomain (adsl-63-201-59-18.dsl.snfc21.pacbell.net [63.201.59.18])
	by pimout4-int.prodigy.net (8.11.0/8.11.0) with ESMTP id g67KgpO193098;
	Sun, 7 Jul 2002 16:42:51 -0400
Received: from localhost (muthu@localhost)
	by Muruga.localdomain (8.11.2/8.11.2) with ESMTP id g67KaiY26329;
	Sun, 7 Jul 2002 13:36:44 -0700
X-Authentication-Warning: Muruga.localdomain: muthu owned process doing -bs
Date: Sun, 7 Jul 2002 13:36:44 -0700 (PDT)
From: Muthukumar Ratty <muthu5@sbcglobal.net>
X-X-Sender: <muthu@Muruga.localdomain>
To: <linux-mips@oss.sgi.com>
cc: <kevink@mips.com>
Subject: Re: MIPS Atlas board
In-Reply-To: <02a401c225f2$1ef39b30$10eca8c0@grendel>
Message-ID: <Pine.LNX.4.33.0207071333390.26311-100000@Muruga.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Thanks kevin, I will use the PCI slot then.

>
> If you're using the on-board multi-I/O wonder chip
> (serial, ethernet, etc) there are some serious problems
> with it that limit both the serial line and ethernet
> performance.  It's good for downloading, and
> that's about it.  Most of us at MIPS put an AMD
> PCnet card in the PCI slot to make the system
> usable for NFS, FTP, etc.
>
>             Regards,
>
>             Kevin K.
>
