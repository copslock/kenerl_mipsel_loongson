Received:  by oss.sgi.com id <S553866AbQLPLTo>;
	Sat, 16 Dec 2000 03:19:44 -0800
Received: from ppp0.ocs.com.au ([203.34.97.3]:48905 "HELO mail.ocs.com.au")
	by oss.sgi.com with SMTP id <S553863AbQLPLTS>;
	Sat, 16 Dec 2000 03:19:18 -0800
Received: (qmail 5581 invoked from network); 16 Dec 2000 11:19:11 -0000
Received: from ocs3.ocs-net (192.168.255.3)
  by mail.ocs.com.au with SMTP; 16 Dec 2000 11:19:11 -0000
X-Mailer: exmh version 2.1.1 10/15/1999
From:   Keith Owens <kaos@melbourne.sgi.com>
To:     Martin Michlmayr <tbm@cyrius.com>
cc:     linux-mips@oss.sgi.com
Subject: Re: Kernel Oops when booting on DECstation 
In-reply-to: Your message of "Sat, 16 Dec 2000 08:56:03 BST."
             <20001216085603.A514@sumpf.cyrius.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Sat, 16 Dec 2000 22:19:10 +1100
Message-ID: <15209.976965550@ocs3.ocs-net>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Sat, 16 Dec 2000 08:56:03 +0100, 
Martin Michlmayr <tbm@cyrius.com> wrote:
>When I boot a Linux kernel on a DECstation/125, I get the following oops:
>Oops in fault.c:do_page_fault, line 172:
>Call Trace: [<8005f564>] [<8005f228>] [<800f191c>] [<80048000>] [<8004e168>] [<]
>Code: 24630010  8e2501d4  8e230218 <8ca20004> 00000000  0043102b  10400431  241

Those two lines have been truncated at end of line instead of wrapping
onto the next line.  Capture the full text (without truncation) and run
it through ksymoops[*] to decode it.

[*]ftp://ftp.<country>.kernel.org/pub/linux/utils/kernel/ksymoops/v2.3
