Received:  by oss.sgi.com id <S553870AbQLPPKQ>;
	Sat, 16 Dec 2000 07:10:16 -0800
Received: from ppp0.ocs.com.au ([203.34.97.3]:52747 "HELO mail.ocs.com.au")
	by oss.sgi.com with SMTP id <S553867AbQLPPKB>;
	Sat, 16 Dec 2000 07:10:01 -0800
Received: (qmail 8292 invoked from network); 16 Dec 2000 15:09:52 -0000
Received: from ocs3.ocs-net (192.168.255.3)
  by mail.ocs.com.au with SMTP; 16 Dec 2000 15:09:52 -0000
X-Mailer: exmh version 2.1.1 10/15/1999
From:   Keith Owens <kaos@melbourne.sgi.com>
To:     Martin Michlmayr <tbm@cyrius.com>
cc:     linux-mips@oss.sgi.com
Subject: Re: Kernel Oops when booting on DECstation 
In-reply-to: Your message of "Sat, 16 Dec 2000 16:00:51 BST."
             <20001216160051.A904@sumpf.cyrius.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Sun, 17 Dec 2000 02:09:51 +1100
Message-ID: <23987.976979391@ocs3.ocs-net>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Sat, 16 Dec 2000 16:00:51 +0100, 
Martin Michlmayr <tbm@cyrius.com> wrote:
>ksymoops 2.3.5 on i586 2.2.15.  Options used
>     -a mipsel
>Using defaults from ksymoops -t elf32-i386

The joys of cross system debugging.  You need to set ksymoops option
-t, it is defaulting to elf32-i386 which is no good for mips objects.
You almost certainly need to set environment variables KSYMOOPS_NM and
KSYMOOPS_OBJDUMP to point to versions of these programs that understand
mips.  If mips prints the code in big endian format then you need to
use ksymoops option -e.  man ksymoops and scan for 'cross'.
