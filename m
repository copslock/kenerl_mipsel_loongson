Received:  by oss.sgi.com id <S553813AbRAXVS6>;
	Wed, 24 Jan 2001 13:18:58 -0800
Received: from ppp0.ocs.com.au ([203.34.97.3]:39947 "HELO mail.ocs.com.au")
	by oss.sgi.com with SMTP id <S553809AbRAXVSf>;
	Wed, 24 Jan 2001 13:18:35 -0800
Received: (qmail 19571 invoked from network); 24 Jan 2001 21:18:29 -0000
Received: from ocs3.ocs-net (192.168.255.3)
  by mail.ocs.com.au with SMTP; 24 Jan 2001 21:18:29 -0000
X-Mailer: exmh version 2.1.1 10/15/1999
From:   Keith Owens <kaos@ocs.com.au>
To:     Florian Lohoff <flo@rfc822.org>
cc:     linux-mips@oss.sgi.com
Subject: Re: OOps - very obscure 
In-reply-to: Your message of "Wed, 24 Jan 2001 16:59:19 BST."
             <20010124165919.C15348@paradigm.rfc822.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Thu, 25 Jan 2001 08:18:29 +1100
Message-ID: <6789.980371109@ocs3.ocs-net>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, 24 Jan 2001 16:59:19 +0100, 
Florian Lohoff <flo@rfc822.org> wrote:
>Code: (Bad address in epc)
>Warning (Oops_code): trailing garbage ignored on Code: line
>  Text: 'Code: (Bad address in epc)'
>  Garbage: 'ress in epc)'
>Warning (Oops_code_values): Code looks like message, not hex digits.  No disassembly attempted.
>I guess the "Garbage" stuff has to be fixed in ksymoops

ksymoops understands "(Bad EIP value.*)", it does not know about "(Bad
address in epc)".  I will add it to ksymoops 2.4.1.
