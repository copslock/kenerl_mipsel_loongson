Received:  by oss.sgi.com id <S42218AbQGKW1E>;
	Tue, 11 Jul 2000 15:27:04 -0700
Received: from firewall.spacetec.no ([192.51.5.5]:10736 "EHLO
        pallas.spacetec.no") by oss.sgi.com with ESMTP id <S42209AbQGKW0u>;
	Tue, 11 Jul 2000 15:26:50 -0700
Received: (from tor@localhost)
	by pallas.spacetec.no (8.9.1a/8.9.1) id QAA08466;
	Tue, 11 Jul 2000 16:19:18 +0200
Message-Id: <200007111419.QAA08466@pallas.spacetec.no>
From:   tor@spacetec.no (Tor Arntsen)
Date:   Tue, 11 Jul 2000 16:19:18 +0200
In-Reply-To: Ralf Baechle <ralf@oss.sgi.com>
       "Re: Kernel boot tips." (Jul 10, 23:53)
X-Mailer: Mail User's Shell (7.2.6 beta(4) 03/19/98)
To:     Ralf Baechle <ralf@oss.sgi.com>
Subject: Re: Kernel boot tips.
Cc:     linux-mips@oss.sgi.com, linux-mips@vger.rutgers.edu,
        linux-mips@fnet.fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Jul 10, 23:53, Ralf Baechle wrote:
[...]
>It's a while that I last worked on it but as I remember --vh-to-unix was
>actually working while the other direction was work in progress.

It is indeed working, I was merely using it incorrectly (I had specified 
the device as I do with the SGI dvhtool instead of using -d).

>Maybe some nroff fan also wants to provide a manpage?

I can do it if nobody else beats me to it.

-Tor
