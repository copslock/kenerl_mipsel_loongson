Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Feb 2005 09:00:20 +0000 (GMT)
Received: from mail.soc-soft.com ([IPv6:::ffff:202.56.254.199]:20744 "EHLO
	IGateway.soc-soft.com") by linux-mips.org with ESMTP
	id <S8225209AbVBVJAE> convert rfc822-to-8bit; Tue, 22 Feb 2005 09:00:04 +0000
Received: from mail.soc-soft.com ([192.168.4.25]) by IGateway with trend_isnt_name_B; Tue, 22 Feb 2005 14:31:16 +0530
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: HIGHMEM Query
Date:	Tue, 22 Feb 2005 14:31:16 +0530
Message-ID: <4BF47D56A0DD2346A1B8D622C5C5902C571A8D@soc-mail.soc-soft.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: HIGHMEM Query
Thread-Index: AcUVMY9Rfs9oZxXiRQ2woJI9KLLRqwDiuvlA
From:	<Rishabh@soc-soft.com>
To:	<ralf@linux-mips.org>
Cc:	<linux-mips@linux-mips.org>
Return-Path: <Rishabh@soc-soft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7306
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Rishabh@soc-soft.com
Precedence: bulk
X-list: linux-mips


hi ralf,

Thanks for the valuable input, I checked the TLB Entry and found

Value in EntryLo0/1 seems absurd. Can you suggest me some way about how
to approach this problem?
________________________________________________________________________
___
xdr_partial_copy_from_skb: kaddr: ffffd000, ppage: 83f751a0, *ppage:
8117ff90
Data bus error, epc == 80161a90, ra == 80161924
ENTRYHI: 0xFFFFC000, ENTRYLO0:0x00000001, ENTRYLO1:0x001FFF5F
INDEX: 0x00000009
Oops in traps.c::do_be, line 465:
$0 : 00000000 10008400 ffffd000 00000000 ffffd000 83f730a0 00000978
00000000
$8 : 622f2123 732f6e69 0a230a68 74532023 20747261 ffffffff 00000010
756e694c
$16: 83f730a0 ffffd000 00000998 000020a4 0000006c 00000000 ffffd000
811e3cc0
$24: 00000018 801e95ff                   811e2000 811e3bc0 00000000
80161924
Hi : 00000000
Lo : 00000001
epc  : 80161a90    Not tainted
Status: 10008403
Cause : 0000001c
Process ksoftirqd_CPU0 (pid: 3, stackpage=811e2000)
Stack:    0000003c 0000003e 80036a40 80036ae4 00000998 00000998 811e3cc0
 00000a04 8010813c 80036ae4 0000004c 80155f58 10008401 ffffc000 0000000a
 0000003c 0000004e 80155f58 80037048 10008401 00000000 83f751a0 0000006c
 00000998 811e3cc0 83f751a0 00001000 80212ff0 83fcc0b4 811e3cc0 80155f58
 80155fa0 83fcd080 80212ff0 ffffd000 00001000 00000000 83f751a0 ffffd000
 00001000 ...
Call Trace:   [<80036a40>] [<80036ae4>] [<8010813c>] [<80036ae4>]
[<80155f58>]
 [<80155f58>] [<80037048>] [<80155f58>] [<80155fa0>] [<80160794>]
[<8011d68c>]
 [<801560a8>] [<80185c7f>] [<80156288>] [<8015627c>] [<80140748>]
[<80140738>]
 [<80156164>] [<80140d0c>] [<80140d00>] [<80036e50>] [<80181ff8>]
[<80106420>]
 [<8011d898>] [<80140b04>] [<80114414>] [<8011d68c>] [<8011ec50>]
[<8011d8bc>]
 [<8011d3a0>] [<8011d37c>] [<8011d68c>] [<8011db0c>] [<8011d318>]
[<80114414>]
 [<8011d8bc>] [<8011d628>] [<8011d604>] [<8011d8bc>] [<8010b9c4>] ...


Code: 8cac0010  8caf0014  ac880000 <ac890004> 8ca80018  8ca9001c
24a50020  2484

0020  ac8affe8
________________________________________________________________________
___

-----Original Message-----
From: Ralf Baechle [mailto:ralf@linux-mips.org]
Sent: Friday, February 18, 2005 2:07 AM
To: Rishabh Kumar Goel
Cc: linux-mips@linux-mips.org; mel@skynet.ie; jbglaw@lug-owl.de
Subject: Re: HIGHMEM Query

On Thu, Feb 17, 2005 at 10:40:22AM +0530, Rishabh@soc-soft.com wrote:

First, fix your mailer setup, it's littering emails with extra carriage
returns.

> I have been working on HIGHMEM fixation for 2.4.20 linux MVL kernel
for
> MIPS architecture.
> I am getting DATA BUS ERROR(ADDR: 0xffffd000) exception when loading
> (copying the data received from ethernet to the kernel space in
FIXADDR
> SPACE) "/sbin/init" from TARGET ROOT DIR (through NFS). I figured out
> that this is because there is no corresponding page table entry for
the
> same.

That does not make sense.  If you don't have a pagetable entry the CPU
will
take a TLB reload exception.  If the entry is invalid, the kernel will
die with an oops.  A bus error has different causes.

  Ralf

The information contained in this e-mail message and in any annexure is
confidential to the  recipient and may contain privileged information. If you are not
the intended recipient, please notify the sender and delete the message along with
any annexure. You should not disclose, copy or otherwise use the information contained
in the message or any annexure. Any views expressed in this e-mail are those of the
individual sender except where the sender specifically states them to be the views of
SoCrates Software India Pvt Ltd., Bangalore.
