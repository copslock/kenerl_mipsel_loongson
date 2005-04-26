Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Apr 2005 09:44:18 +0100 (BST)
Received: from h081217049130.dyn.cm.kabsi.at ([IPv6:::ffff:81.217.49.130]:54965
	"EHLO phobos.hvrlab.org") by linux-mips.org with ESMTP
	id <S8225294AbVDZIoA>; Tue, 26 Apr 2005 09:44:00 +0100
Received: from mini.intra (dhcp-1334-4.blizz.at [213.143.126.4])
	(authenticated bits=0)
	by phobos.hvrlab.org (8.13.4/8.13.4/Debian-1) with ESMTP id j3Q8hh99014179
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT);
	Tue, 26 Apr 2005 10:43:49 +0200
Subject: iptables/vmalloc issues on alchemy
From:	Herbert Valerio Riedel <hvr@hvrlab.org>
To:	Pete Popov <ppopov@embeddedalley.com>
Cc:	Josh Green <jgreen@users.sourceforge.net>,
	linux-mips@linux-mips.org
Content-Type: text/plain
Date:	Tue, 26 Apr 2005 10:43:29 +0200
Message-Id: <1114505009.11315.37.camel@mini.intra>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Return-Path: <hvr@hvrlab.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7795
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hvr@hvrlab.org
Precedence: bulk
X-list: linux-mips

hello!

I'm seeing similiar problems to the ones that Josh Green reported some
time ago on this list (but alas didn't seem to get any further
attention...)

The problem seems to be so far, that when modifying the iptables
structures by adding/flushing the rules, a state can be reached sooner
or later (indeterministic! smells like race) where the data structure
becomes invalid (although there are checks in the kernel which would
prevent that); the result is either ip_tables.c:ipt_do_tables() causing
an oops due to bad pointer dereferencing (or the kernel freezing w/o
further notice at all), or the iptables tool being unable to
retrieve/modify the rules from the kernel (and getting ENOMEM/EINVAL) or
simply segfaulting due to other inconsistencies with the data...

I was able to avoid corruption by replacing all vmalloc()/vfree() calls
by kmalloc()/kfree()'s respectively in ip_tables.c; another variant
which I was suggested to try helped as well: inserting flush_tlb_all()
calls after every vmalloc() in said source file;

I assumed so far, the issue must be alchemy specific, as I experienced
this on a DbAu1550 board; and Josh had it on a DbAu1100; As it's a
rather easy to trigger bug, I would have expected to see more bug
reports if it affected more than just the alchemy's on 2.6.x;
I tried it with a few kernel revisions from linux-mips' cvs (from 2.6.10
upto 2.6.12rc2); also tried different compilers (debian's cross-gcc's
3.4.4 and 3.3.3), even switched the alchemy to little endian
operation... all the same; everything else I use on that board has been
rather stable so far, iptables are the only part which show up this
vmalloc-issue so far...

as to reproducing the bug, it's rather easy for me:

a script repeatedly performing rule modifications should trigger the
issue rather easily (possibly called over a remote ssh/telnet session,
in order to create a bit of traffic as well...)

set -x
while :
do
  iptables -F || exit 1
  iptables -A INPUT -i lo -j ACCEPT || exit 1
  iptables -A INPUT -p udp -i eth0 --dport domain -j ACCEPT || exit 1
  iptables -A INPUT -p udp -i eth0 --dport 6666 -j ACCEPT || exit 1
  iptables -A INPUT -p tcp -i eth0 --dport ssh -j ACCEPT || exit 1
  iptables -A INPUT -p tcp -i eth0 --dport http -j ACCEPT || exit 1
  iptables -A INPUT -p tcp -i eth0 --dport https -j ACCEPT || exit 1
  iptables -A INPUT -p tcp -i eth0 --dport 3496 -j ACCEPT || exit 1
done

or alternatively (requiring state & multiport helpers)

while :
do
  iptables -F
  iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT  || exit 1
  iptables -A INPUT -i lo -j ACCEPT || exit 1
  iptables -A INPUT -p udp -i eth0 -m multiport --dports domain,6666 -j ACCEPT || exit 1
  iptables -A INPUT -p tcp -i eth0 -m multiport --dports ssh,http,https,3496 -j ACCEPT || exit 1
  iptables -A OUTPUT -m state --state ESTABLISHED,RELATED -j ACCEPT || exit 1
  iptables -A OUTPUT -o lo -j ACCEPT || exit 1
  iptables -A OUTPUT -p udp -o eth0 -m multiport --dports ntp -j ACCEPT || exit 1
  iptables -A OUTPUT -p tcp -o eth0 -m multiport --dports www,https,8444,8445,8446,8454,8455,8456,8464,8465,8466,9225 -j ACCEPT || exit 1
done

regards,
-- 
Herbert Valerio Riedel <hvr@hvrlab.org>
