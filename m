Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Jan 2005 08:53:21 +0000 (GMT)
Received: from host181-209-dsl.dols.net.pk ([IPv6:::ffff:202.147.181.209]:26015
	"EHLO 1aurora.enabtech") by linux-mips.org with ESMTP
	id <S8224788AbVAJIxQ>; Mon, 10 Jan 2005 08:53:16 +0000
Received: by 1aurora.enabtech with Internet Mail Service (5.5.2448.0)
	id <C459AN2C>; Mon, 10 Jan 2005 13:43:16 +0500
Message-ID: <1B701004057AF74FAFF851560087B16106469F@1aurora.enabtech>
From: Mudeem Iqbal <mudeem@Quartics.com>
To: 'Atsushi Nemoto' <anemo@mba.ocn.ne.jp>
Cc: "'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Subject: RE: mipes-linux-ld: final link failed: Bad value
Date: Mon, 10 Jan 2005 13:43:15 +0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2448.0)
Content-Type: text/plain
Return-Path: <mudeem@Quartics.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6851
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mudeem@Quartics.com
Precedence: bulk
X-list: linux-mips

Hi,

Yes using binutils-2.15.92.0.2 solved the problem. Thanx alot. Now I am
getting another problem related to vmlinux.lds. I'll put that up as a
sepparate post. Thanx once again

Mudeem

-----Original Message-----
From: Atsushi Nemoto [mailto:anemo@mba.ocn.ne.jp]
Sent: Friday, January 07, 2005 12:24 PM
To: Mudeem Iqbal
Cc: linux-mips@linux-mips.org
Subject: Re: mipes-linux-ld: final link failed: Bad value


>>>>> On Thu, 6 Jan 2005 18:47:11 +0500 , Mudeem Iqbal <mudeem@Quartics.com>
said:
mudeem> I have built a toolchain using the following combination

mudeem> binutils-2.15
mudeem> gcc-3.4.3

As I reported on 06 Nov 2004 ("failed to merge string constant?"),
binutils-2.15 + gcc-3.4.x (at least gcc 3.4.2) will produce broken
output.  binutils-2.15.92.0.2 or later will be OK with gcc 3.4.

---
Atsushi Nemoto
