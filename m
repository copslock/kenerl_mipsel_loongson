Received:  by oss.sgi.com id <S553911AbQKDDNp>;
	Fri, 3 Nov 2000 19:13:45 -0800
Received: from ppp0.ocs.com.au ([203.34.97.3]:46349 "HELO mail.ocs.com.au")
	by oss.sgi.com with SMTP id <S553904AbQKDDNm>;
	Fri, 3 Nov 2000 19:13:42 -0800
Received: (qmail 16060 invoked from network); 4 Nov 2000 03:13:38 -0000
Received: from ocs3.ocs-net (192.168.255.3)
  by mail.ocs.com.au with SMTP; 4 Nov 2000 03:13:38 -0000
X-Mailer: exmh version 2.1.1 10/15/1999
From:   Keith Owens <kaos@melbourne.sgi.com>
To:     linux-mips@oss.sgi.com, linux-mips@fnet.fr
Subject: Re: Kernel compiler 
In-reply-to: Your message of "Sat, 04 Nov 2000 03:53:26 BST."
             <20001104035326.A29005@bacchus.dhis.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Sat, 04 Nov 2000 14:13:37 +1100
Message-ID: <5652.973307617@ocs3.ocs-net>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Sat, 4 Nov 2000 03:53:26 +0100, 
Ralf Baechle <ralf@oss.sgi.com> wrote:
>The reports regarding egcs 2.96 and newer misscompiling the kernel only
>affect x86 or are other architecture affected as well?  I don't have any
>pending compiler >= 2.96 related bug reports.

At a guess (and it is only a guess), the problems will affect all
architectures.  AFAICT they are in the common optimization phase, the
kernel uses constructs that were undefined or poorly defined but worked
in gcc 2.95, 2.96 handles them differently.
