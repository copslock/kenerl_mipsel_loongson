Received:  by oss.sgi.com id <S553686AbQJWWcP>;
	Mon, 23 Oct 2000 15:32:15 -0700
Received: from ppp0.ocs.com.au ([203.34.97.3]:44039 "HELO mail.ocs.com.au")
	by oss.sgi.com with SMTP id <S553663AbQJWWcL>;
	Mon, 23 Oct 2000 15:32:11 -0700
Received: (qmail 7728 invoked from network); 23 Oct 2000 22:32:04 -0000
Received: from ocs3.ocs-net (192.168.255.3)
  by mail.ocs.com.au with SMTP; 23 Oct 2000 22:32:04 -0000
X-Mailer: exmh version 2.1.1 10/15/1999
From:   Keith Owens <kaos@melbourne.sgi.com>
To:     Jun Sun <jsun@mvista.com>
cc:     linux-mips@oss.sgi.com
Subject: Re: problems with insmod ... 
In-reply-to: Your message of "Mon, 23 Oct 2000 11:45:22 PDT."
             <39F48742.933941B8@mvista.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Tue, 24 Oct 2000 09:32:03 +1100
Message-ID: <7690.972340323@ocs3.ocs-net>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Mon, 23 Oct 2000 11:45:22 -0700, 
Jun Sun <jsun@mvista.com> wrote:
>I tried with 2.3.19, and now I am having problem with out of bound index
>in symbol table.  See the output below.
>
>---------
>sh-2.03# insmod hello.o
>hello.o: local symbol gcc2_compiled. with index 10 exceeds
>local_symtab_size 10
>hello.o: local symbol __gnu_compiled_c with index 11 exceeds
>local_symtab_size 10
>---------

It is a toolchain bug, I think it is in the assembler.  I have a dim
distant memory from about a month ago that somebody on linux-mips found
the problem.  Ask the toolchain experts.
