Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f81KWcP19630
	for linux-mips-outgoing; Sat, 1 Sep 2001 13:32:38 -0700
Received: from mail.ocs.com.au (ppp0.ocs.com.au [203.34.97.3])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f81KWZd19627
	for <linux-mips@oss.sgi.com>; Sat, 1 Sep 2001 13:32:36 -0700
Received: (qmail 6035 invoked from network); 1 Sep 2001 20:32:33 -0000
Received: from ocs3.ocs-net (192.168.255.3)
  by mail.ocs.com.au with SMTP; 1 Sep 2001 20:32:33 -0000
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: George Gensure <werkt@csh.rit.edu>
cc: linux-mips <linux-mips@oss.sgi.com>
Subject: Re: xdm bus errors 
In-reply-to: Your message of "Sat, 01 Sep 2001 15:58:47 -0400."
             <3B913DF7.6040007@csh.rit.edu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 02 Sep 2001 06:32:32 +1000
Message-ID: <22645.999376352@ocs3.ocs-net>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sat, 01 Sep 2001 15:58:47 -0400, 
George Gensure <werkt@csh.rit.edu> wrote:
>I got this lovely bit of alphanumericism whilst trying to run xdm. 
> Anyone have any idea how to fix this bus error?

The first thing to do is run it through ksymoops to decode the numbers
to symbols.

ftp://ftp.kernel.org/pub/linux/utils/kernel/ksymoops/v2.4
