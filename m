Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 May 2006 01:25:39 +0200 (CEST)
Received: from godel.catalyst.net.nz ([202.78.240.40]:39379 "EHLO
	mail1.catalyst.net.nz") by ftp.linux-mips.org with ESMTP
	id S8133880AbWEIXZa (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 10 May 2006 01:25:30 +0200
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=pkunk.wgtn.cat-it.co.nz)
	by mail1.catalyst.net.nz with esmtps (SSL 3.0:RSA_ARCFOUR_MD5:16)
	(Exim 4.50)
	id 1FdbZz-0004r8-79
	for linux-mips@linux-mips.org; Wed, 10 May 2006 11:25:23 +1200
Subject: "Badness in local_bh_enable at kernel/softirq.c:140" - sgiseeq and
	conntrack?
From:	Sam Cannell <sam@catalyst.net.nz>
To:	linux-mips@linux-mips.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-tIl8GAIL7RIslTNcG5/k"
Date:	Wed, 10 May 2006 11:25:22 +1200
Message-Id: <1147217122.20432.14.camel@pkunk.wgtn.cat-it.co.nz>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Return-Path: <sam@catalyst.net.nz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11376
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sam@catalyst.net.nz
Precedence: bulk
X-list: linux-mips


--=-tIl8GAIL7RIslTNcG5/k
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Since putting a stateful firewall on my Indy, I'm seeing the following
error in dmesg fairly often - I believe whenever a tcp connection is
closed.  Other than filling /var/log/messages, it doesn't seem to be
causing any problems - network connections work fine.

Is this a known problem? Anything I can or should do about it?

[4294795.111000] Badness in local_bh_enable at kernel/softirq.c:140
[4294795.111000] Call Trace:
[4294795.111000]  [<8802cfdc>] local_bh_enable+0x78/0xa0
[4294795.111000]  [<c007a70c>] destroy_conntrack+0xdc/0x178
[ip_conntrack]
[4294795.111000]  [<c007a6a4>] destroy_conntrack+0x74/0x178
[ip_conntrack]
[4294795.111000]  [<8817bcbc>] __kfree_skb+0xe4/0x170
[4294795.111000]  [<8813ef1c>] sgiseeq_start_xmit+0x2bc/0x388
[4294795.111000]  [<c0000b80>] ip_nat_out+0x104/0x130 [iptable_nat]
[4294795.111000]  [<c0000ae8>] ip_nat_out+0x6c/0x130 [iptable_nat]
[4294795.111000]  [<88190038>] qdisc_restart+0x70/0x22c
[4294795.111000]  [<881a2074>] ip_finish_output+0x0/0x2e8
[4294795.111000]  [<88182870>] dev_queue_xmit+0x250/0x2f8
[4294795.111000]  [<88182854>] dev_queue_xmit+0x234/0x2f8
[4294795.111000]  [<88189748>] neigh_resolve_output+0x1d0/0x2f0
[4294795.111000]  [<881a2074>] ip_finish_output+0x0/0x2e8
[4294795.111000]  [<881a2510>] ip_output+0x1b4/0x3cc
[4294795.111000]  [<881a0900>] dst_output+0x0/0x10
[4294795.111000]  [<881a2074>] ip_finish_output+0x0/0x2e8
[4294795.111000]  [<881a41d0>] ip_push_pending_frames+0x4ec/0x54c
[4294795.111000]  [<881c5654>] icmp_push_reply+0x58/0x140
[4294795.111000]  [<881c5530>] icmp_glue_bits+0x0/0xcc
[4294795.111000]  [<881a0900>] dst_output+0x0/0x10
[4294795.111000]  [<881c58dc>] icmp_reply+0x1a0/0x260
[4294795.111000]  [<c0079954>] ip_confirm+0x4c/0x60 [ip_conntrack]
[4294795.111000]  [<881c6210>] icmp_echo+0x60/0x6c
[4294795.111000]  [<c00009c4>] ip_nat_in+0x38/0xf0 [iptable_nat]
[4294795.111000]  [<8819cabc>] ip_local_deliver_finish+0x0/0x2b4
[4294795.111000]  [<8819d0d4>] ip_rcv_finish+0x0/0x378
[4294795.111000]  [<8819cabc>] ip_local_deliver_finish+0x0/0x2b4
[4294795.111000]  [<881c6668>] icmp_rcv+0x138/0x220
[4294795.111000]  [<8819cf74>] ip_local_deliver+0x204/0x364
[4294795.111000]  [<8819cabc>] ip_local_deliver_finish+0x0/0x2b4
[4294795.111000]  [<8819d7fc>] ip_rcv+0x3b0/0x6e4
[4294795.111000]  [<8802cde0>] __do_softirq+0x90/0x158
[4294795.111000]  [<8819d0d4>] ip_rcv_finish+0x0/0x378
[4294795.111000]  [<88182f14>] netif_receive_skb+0x1b8/0x250
[4294795.111000]  [<88183088>] process_backlog+0xdc/0x20c
[4294795.111000]  [<88183284>] net_rx_action+0xcc/0x214
[4294795.111000]  [<8802cde0>] __do_softirq+0x90/0x158
[4294795.111000]  [<88258ae0>] pidhash_init+0x130/0x1a4
[4294795.111000]  [<8802cf38>] do_softirq+0x90/0xbc
[4294795.111000]  [<88258ae0>] pidhash_init+0x130/0x1a4
[4294795.111000]  [<880065d4>] do_IRQ+0x24/0x34
[4294795.111000]  [<88003640>] indyIRQ+0x120/0x180
[4294795.111000]  [<8805bec4>] do_wp_page+0x280/0x524
[4294795.111000]  [<88258ae0>] pidhash_init+0x130/0x1a4
[4294795.111000]  [<88258b14>] pidhash_init+0x164/0x1a4
[4294795.111000]  [<88258ae0>] pidhash_init+0x130/0x1a4
[4294795.111000]  [<88042574>] ktime_get+0x18/0x3c
[4294795.111000]  [<8800eacc>] do_page_fault+0x9c/0x3d0
[4294795.111000]  [<8805e328>] find_vma+0x58/0x98
[4294795.111000]  [<882581e0>] printk_time_setup+0x8/0x20
[4294795.111000]  [<88031b34>] run_timer_softirq+0x34/0x240
[4294795.111000]  [<8802cde0>] __do_softirq+0x90/0x158
[4294795.111000]  [<8800f264>] tlb_do_page_fault_0+0x104/0x10c
[4294795.111000]  [<88003628>] indyIRQ+0x108/0x180
[4294795.111000]=20


--=-tIl8GAIL7RIslTNcG5/k
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBEYSTizjWM3BBT1QARAqugAJ43Av08oLkToa9c8jbUqaqRrIv/OwCdEoGP
KhbA/FCXCvMTue8hlklzv6g=
=0yGr
-----END PGP SIGNATURE-----

--=-tIl8GAIL7RIslTNcG5/k--
