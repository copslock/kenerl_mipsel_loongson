Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Nov 2004 15:58:29 +0000 (GMT)
Received: from the-doors.enix.org ([IPv6:::ffff:62.210.169.120]:44723 "EHLO
	the-doors.enix.org") by linux-mips.org with ESMTP
	id <S8225205AbUKBP6Z>; Tue, 2 Nov 2004 15:58:25 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by the-doors.enix.org (Postfix) with ESMTP id E855B1EFB0
	for <linux-mips@linux-mips.org>; Tue,  2 Nov 2004 16:58:12 +0100 (CET)
Message-ID: <4187AF03.5030606@enix.org>
Date: Tue, 02 Nov 2004 17:00:03 +0100
From: Thomas Petazzoni <thomas.petazzoni@enix.org>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: Custom kernel crashes
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig8D29ECD0C95DD6BD4372544E"
Return-Path: <thomas.petazzoni@enix.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6244
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas.petazzoni@enix.org
Precedence: bulk
X-list: linux-mips

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8D29ECD0C95DD6BD4372544E
Content-Type: multipart/mixed;
 boundary="------------070705060406000509090507"

This is a multi-part message in MIME format.
--------------070705060406000509090507
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

I've modified the Linux MIPS CVS kernel to support my board. 
Modification include platform initialization, serial driver and ethernet 
driver.

When I leave the system alone for a while, it crashes with the error 
seen in the attached file. It crashes with a Bus error, but I don't know 
where the bus error occurs. epc and ra respectively points to do_be() 
and handle_dbe_int(), but I don't get any backtrace, because stack 
address 0xfe040000 is already the end of the end stack ;(

How can I know to what process 0xfe040000 stack address correspond ? How 
can I have more information on what happened ?

I suspect it's a bug in my serial driver, because of the strange 
characters displayed before "us error", but I'm not sure. I just need 
advices to be able to debug this problem.

Thanks for your help,

Thomas
-- 
PETAZZONI Thomas - thomas.petazzoni@enix.org
http://thomas.enix.org - Jabber: kos_tom@sourcecode.de
KOS: http://kos.enix.org/ - Lolut: http://lolut.utbm.info
Fingerprint : 0BE1 4CF3 CEA4 AC9D CC6E  1624 F653 CB30 98D3 F7A7

--------------070705060406000509090507
Content-Type: text/plain;
 name="linux-crash"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="linux-crash"

# QXºX±us error, epc == 8020c878, ra == 80206708
Oops in arch/mips/kernel/traps.c::do_be, line 333[#1]:
Stack (0xfe040000) (0x0) Stack:
----------------Call Trace (0xfe040000) (0x1):
Infos: 0xfe040000 - 1

Cpu 0
$ 0   : 00000000 00000000 bb001b00 00000000
$ 4   : fe040030 fe07fe20 00000000 ffffffff
$ 8   : 9000ff00 1000001f 9000ff00 00000000
$12   : 00000000 00000000 00000000 00000000
$16   : fe07fe20 fe040030 00000000 00000000
$20   : 00000000 00000000 00000000 00000000
$24   : 00000000 4187a897
$28   : fe040000 fe040000 00000000 80206708
Hi    : 00000000
Lo    : 00000000
epc   : 8020c878 do_be+0x1c/0x13c     Not tainted
ra    : 80206708 handle_dbe_int+0x20/0x38
Status: 9000ff02    KERNEL EXL
Cause : 0000841c
PrId  : 00003430
Modules linked in:
CPU 0 Unable to handle kernel paging request at virtual address 00000074, epc == 80214520, ra == 8021688c
Oops in arch/mips/mm/fault.c::do_page_fault, line 166[#2]:
Stack (0xfe0020d0) (0xd0) Stack:  00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
        00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
        00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
        00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
        00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
        ...
----------------Call Trace (0xfe0020d0) (0x0):
Infos: 0xfe0020d0 - 0
 [<8021688c>] nopage_tlbl+0xf0/0x104
 [<8021688c>] nopage_tlbl+0xf0/0x104
 [<80214520>] do_page_fault+0x40/0x360
 [<8021688c>] nopage_tlbl+0xf0/0x104
 [<8021688c>] nopage_tlbl+0xf0/0x104
 [<80214520>] do_page_fault+0x40/0x360
 [<8021688c>] nopage_tlbl+0xf0/0x104
 [<8021688c>] nopage_tlbl+0xf0/0x104
 [<80214520>] do_page_fault+0x40/0x360
 [<8021688c>] nopage_tlbl+0xf0/0x104
 [<8021688c>] nopage_tlbl+0xf0/0x104
 [<80214520>] do_page_fault+0x40/0x360
 [<8021688c>] nopage_tlbl+0xf0/0x104
 [<8021688c>] nopage_tlbl+0xf0/0x104
 [<80214520>] do_page_fault+0x40/0x360
 [<8021688c>] nopage_tlbl+0xf0/0x104
 [<8021688c>] nopage_tlbl+0xf0/0x104
 [<80214520>] do_page_fault+0x40/0x360
 [<8021688c>] nopage_tlbl+0xf0/0x104
 [<8021688c>] nopage_tlbl+0xf0/0x104
 [<80214520>] do_page_fault+0x40/0x360
 [<8021688c>] nopage_tlbl+0xf0/0x104
 [<8021688c>] nopage_tlbl+0xf0/0x104
 [<80214520>] do_page_fault+0x40/0x360
 [<8021688c>] nopage_tlbl+0xf0/0x104
 [<8021688c>] nopage_tlbl+0xf0/0x104
 [<80214520>] do_page_fault+0x40/0x360
 [<8021688c>] nopage_tlbl+0xf0/0x104
 [<8021688c>] nopage_tlbl+0xf0/0x104
 [<80214520>] do_page_fault+0x40/0x360
 [<8021688c>] nopage_tlbl+0xf0/0x104
 [<8021688c>] nopage_tlbl+0xf0/0x104
 [<80214520>] do_page_fault+0x40/0x360
 [<8021688c>] nopage_tlbl+0xf0/0x104
 [<8021688c>] nopage_tlbl+0xf0/0x104
 [<80214520>] do_page_fault+0x40/0x360
 [<8021688c>] nopage_tlbl+0xf0/0x104
 [<8021688c>] nopage_tlbl+0xf0/0x104
 [<80214520>] do_page_fault+0x40/0x360
 [<8021688c>] nopage_tlbl+0xf0/0x104
 [<8021688c>] nopage_tlbl+0xf0/0x104
 [<80214520>] do_page_fault+0x40/0x360
 [<8021688c>] nopage_tlbl+0xf0/0x104
 [<8021688c>] nopage_tlbl+0xf0/0x104
 [<80214520>] do_page_fault+0x40/0x360
 [<8021688c>] nopage_tlbl+0xf0/0x104
 [<8021688c>] nopage_tlbl+0xf0/0x104
 [<80214520>] do_page_fault+0x40/0x360
 [<8021688c>] nopage_tlbl+0xf0/0x104
 [<8021688c>] nopage_tlbl+0xf0/0x104
 [<80214520>] do_page_fault+0x40/0x360
 [<8021688c>] nopage_tlbl+0xf0/0x104
 [<8021688c>] nopage_tlbl+0xf0/0x104
 [<80214520>] do_page_fault+0x40/0x360
 [<8021688c>] nopage_tlbl+0xf0/0x104
 [<8021688c>] nopage_tlbl+0xf0/0x104
 [<80214520>] do_page_fault+0x40/0x360
 [<8021688c>] nopage_tlbl+0xf0/0x104
 [<8021688c>] nopage_tlbl+0xf0/0x104
 [<80214520>] do_page_fault+0x40/0x360
 [<8021688c>] nopage_tlbl+0xf0/0x104
 [<8021688c>] nopage_tlbl+0xf0/0x104
 [<80214520>] do_page_fault+0x40/0x360

Cpu 0
$ 0   : 00000000 9000ff00 00030001 00000000
$ 4   : fe002198 00000000 00000074 fe03e000
$ 8   : 9000ff00 1000001e 00000003 803eb10c
$12   : 00000000 00000000 fffffffe ffffffff
$16   : 00000000 80376ef8 fe03ff50 00000004
$20   : 00000000 00000000 00000000 00000000
$24   : 00000010 00000003
$28   : fe002000 fe0020d0 00000000 8021688c
Hi    : 00000240
Lo    : 000001f8
epc   : 80214520 do_page_fault+0x40/0x360     Not tainted
ra    : 8021688c nopage_tlbl+0xf0/0x104
Status: 9000ff02    KERNEL EXL
Cause : 00008408
BadVA : 00000000
PrId  : 00003430
Modules linked in:
Data bus error, epc == 802ce6d8, ra == 802cf58c
Oops in arch/mips/kernel/traps.c::do_be, line 333[#3]:
Stack (0xfe001e70) (0xe70) Stack:  00000400 fe001efc 9000ff00 ffffed6a 9000ff00 0000000a 80229464 00000000
        00000400 fe001f1c 9000ff00 00000000 0000002c 00000000 00000000 00000000
        802cf774 80229198 00000020 fe0020b8 80376eb1 803a343c 80376ea8 80229198
        0000002c 00000000 00000000 80229120 fe002020 803778e0 fe002020 00000000
        0000002c 00000000 00000000 80229120 00000000 c0000000 fe002020 803778e0
        ...
----------------Call Trace (0xfe001e70) (0x0):
Infos: 0xfe001e70 - 0
 [<80229464>] release_console_sem+0x88/0x158
 [<802cf774>] vscnprintf+0x14/0x30
 [<80229198>] vprintk+0x6c/0x218
 [<80229198>] vprintk+0x6c/0x218
 [<80229120>] printk+0x1c/0x28
 [<80229120>] printk+0x1c/0x28
 [<8020c6e4>] show_registers+0x58/0x7c
 [<8020c6bc>] show_registers+0x30/0x7c
 [<80206708>] handle_dbe_int+0x20/0x38
 [<8020c7bc>] __die+0xb4/0xcc
 [<8021464c>] do_page_fault+0x16c/0x360
 [<80214520>] do_page_fault+0x40/0x360
 [<8021688c>] nopage_tlbl+0xf0/0x104

Cpu 0
$ 0   : 00000000 9000ff00 ffffffff fe04016a
$ 4   : fe04016a fffffffe 80376eb1 fe001f1c
$ 8   : ffffffff 0000000a 00000003 803eb10c
$12   : 00000000 00000000 fffffffe ffffffff
$16   : 803eb104 fe04016a 803eb4fb 00000000
$20   : fe001f1c ffffffff 803eb0fc 00000400
$24   : 00000010 00000003
$28   : fe002000 fe001e70 00000000 802cf58c
Hi    : 00000240
Lo    : 000001f8
epc   : 802ce6d8 strnlen+0x10/0x40     Not tainted
ra    : 802cf58c vsnprintf+0x46c/0x640
Status: 9000ff02    KERNEL EXL
Cause : 0000841c
PrId  : 00003430
Modules linked in:


--------------070705060406000509090507--

--------------enig8D29ECD0C95DD6BD4372544E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (MingW32)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBh68H9lPLMJjT96cRAhkkAJ0bzgDtevU/lurLPiIjAybpmRIAxACfbL9o
WDVPmJmjNcX489EvYzCStYw=
=9/vm
-----END PGP SIGNATURE-----

--------------enig8D29ECD0C95DD6BD4372544E--
