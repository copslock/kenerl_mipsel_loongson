Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5DBZ1X13264
	for linux-mips-outgoing; Wed, 13 Jun 2001 04:35:01 -0700
Received: from ocs4.ocs-net (firewall.ocs.com.au [203.34.97.9])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5DBYtP13246;
	Wed, 13 Jun 2001 04:34:56 -0700
Received: from ocs4.ocs-net (kaos@localhost)
	by ocs4.ocs-net (8.11.2/8.11.2) with ESMTP id f5DBYJD07965;
	Wed, 13 Jun 2001 21:34:20 +1000
X-Authentication-Warning: ocs4.ocs-net: kaos owned process doing -bs
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@melbourne.sgi.com>
To: Florian Lohoff <flo@rfc822.org>
cc: Raoul Borenius <borenius@shuttle.de>, Ralf Baechle <ralf@oss.sgi.com>,
   linux-mips@oss.sgi.com
Subject: Re: Kernel crash on boot with current cvs (todays) 
In-reply-to: Your message of "Wed, 13 Jun 2001 12:56:10 +0200."
             <20010613125610.A18235@paradigm.rfc822.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 13 Jun 2001 21:34:18 +1000
Message-ID: <7964.992432058@ocs4.ocs-net>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, 13 Jun 2001 12:56:10 +0200, 
Florian Lohoff <flo@rfc822.org> wrote:
>> Using ksymoops gave a lot of warnings this time. Don't know why, the
>> System.map should be the right one (it's out of
>> kernel-image-2.4.3-ip22-r4k.tgz).
>
>This is because the system map has been generated with newer binutils
>which always dump the addresses as 64Bit addresses.

Looks like I need to add a new option to ksymoops.  -T <bits>, truncate
all addresses to this bit size.  Added to my list for the next ksymoops
release.
