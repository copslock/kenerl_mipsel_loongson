Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5B3q5115957
	for linux-mips-outgoing; Sun, 10 Jun 2001 20:52:05 -0700
Received: from ocs4.ocs-net (firewall.ocs.com.au [203.34.97.9])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5B3q2V15954
	for <linux-mips@oss.sgi.com>; Sun, 10 Jun 2001 20:52:03 -0700
Received: from ocs4.ocs-net (kaos@localhost)
	by ocs4.ocs-net (8.11.2/8.11.2) with ESMTP id f5B3r4e10207;
	Mon, 11 Jun 2001 13:53:04 +1000
X-Authentication-Warning: ocs4.ocs-net: kaos owned process doing -bs
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Florian Lohoff <flo@rfc822.org>
cc: linux-mips@oss.sgi.com
Subject: Re: Kernel crash on boot with current cvs (todays) 
In-reply-to: Your message of "Mon, 11 Jun 2001 00:03:59 +0200."
             <20010611000359.A25631@paradigm.rfc822.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 11 Jun 2001 13:53:04 +1000
Message-ID: <10206.992231584@ocs4.ocs-net>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, 11 Jun 2001 00:03:59 +0200, 
Florian Lohoff <flo@rfc822.org> wrote:
>i just tried to boot an Indy of mine with the current cvs (from this
>morning) and it crashes 
>
>ksymoops 2.4.1 on i686 2.2.18ext3.  Options used
>Using defaults from ksymoops -t elf32-little -a unknown
>Error (Oops_bfd_perror): scan_arch for specified architecture Success

I cannot help with the oops but your ksymoops run has problems.  When
doing cross system oops debugging, you need to specify the target
machine and architecture with the -t and -a flags.  Otherwise ksymoops 
defaults to the current machine.  Adding -t and -a will fix the above
error and decode the code: line.
