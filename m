Received:  by oss.sgi.com id <S553895AbQKDCop>;
	Fri, 3 Nov 2000 18:44:45 -0800
Received: from ppp0.ocs.com.au ([203.34.97.3]:38413 "HELO mail.ocs.com.au")
	by oss.sgi.com with SMTP id <S553893AbQKDCoc>;
	Fri, 3 Nov 2000 18:44:32 -0800
Received: (qmail 15851 invoked from network); 4 Nov 2000 02:44:22 -0000
Received: from ocs3.ocs-net (192.168.255.3)
  by mail.ocs.com.au with SMTP; 4 Nov 2000 02:44:22 -0000
X-Mailer: exmh version 2.1.1 10/15/1999
From:   Keith Owens <kaos@melbourne.sgi.com>
To:     linux-mips@oss.sgi.com, linux-mips@fnet.fr
Subject: Re: Kernel compiler 
In-reply-to: Your message of "Fri, 03 Nov 2000 22:19:26 BST."
             <20001103221926.A26082@bacchus.dhis.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Sat, 04 Nov 2000 13:44:22 +1100
Message-ID: <5029.973305862@ocs3.ocs-net>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, 3 Nov 2000 22:19:26 +0100, 
Ralf Baechle <ralf@oss.sgi.com> wrote:
>Due to compiler bugs with named initializers the use of egcs 1.1.2 has
>ben deprecated for Linux; Linux 2.4.0-test10 will refuse to compile with
>older compilers.

Correction.  gcc 2.7 has been deprecated, the recommended version is
gcc 2.91.66 (also known as egcs 1.1.2) or better.  Unfortunately RedHat
created an unofficial 2.96 which is known to miscompile the kernel, so
you cannot just use the "latest" gcc.  It is believed that gcc versions
2.91.66 through 2.95 inclusive are safe, as long as you use
-fno-strict-aliasing.
