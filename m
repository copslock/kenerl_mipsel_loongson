Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jan 2006 19:24:35 +0000 (GMT)
Received: from mms1.broadcom.com ([216.31.210.17]:523 "EHLO mms1.broadcom.com")
	by ftp.linux-mips.org with ESMTP id S8133470AbWAQTYR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 17 Jan 2006 19:24:17 +0000
Received: from 10.10.64.154 by mms1.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.2.0)); Tue, 17 Jan 2006 11:27:43 -0800
X-Server-Uuid: F962EFE0-448C-40EE-8100-87DF498ED0EA
Received: by mail-irva-10.broadcom.com (Postfix, from userid 47) id
 E74F167423; Tue, 17 Jan 2006 11:27:42 -0800 (PST)
Received: from mail-irva-8.broadcom.com (mail-irva-8 [10.10.64.221]) by
 mail-irva-10.broadcom.com (Postfix) with ESMTP id ADDEA67422; Tue, 17
 Jan 2006 11:27:42 -0800 (PST)
Received: from mail-sj1-12.sj.broadcom.com (mail-sj1-12.sj.broadcom.com
 [10.16.128.215]) by mail-irva-8.broadcom.com (MOS 3.5.6-GR) with ESMTP
 id CSK26292; Tue, 17 Jan 2006 11:27:42 -0800 (PST)
Received: from NT-SJCA-0750.brcm.ad.broadcom.com (nt-sjca-0750
 [10.16.192.220]) by mail-sj1-12.sj.broadcom.com (Postfix) with ESMTP id
 35B0120502; Tue, 17 Jan 2006 11:27:42 -0800 (PST)
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: Broadcom Bigsur build
Date:	Tue, 17 Jan 2006 11:27:41 -0800
Message-ID: <7E000E7F06B05C49BDBB769ADAF44D07693A66@NT-SJCA-0750.brcm.ad.broadcom.com>
Thread-Topic: Broadcom Bigsur build
Thread-Index: AcYbm5OAZXrU9hrFQKamiYkFZVq5BgAADmAA
From:	"Mark E Mason" <mark.e.mason@broadcom.com>
To:	"Michael J. Hammel" <mips@graphics-muse.org>,
	linux-mips@linux-mips.org
X-TMWD-Spam-Summary: SEV=1.1; DFV=A2006011707; IFV=2.0.6,4.0-7;
 RPD=4.00.0004;
 RPDID=303030312E30413031303230352E34334344343430342E303032342D412D;
 ENG=IBF; TS=20060117192745; CAT=NONE; CON=NONE;
X-MMS-Spam-Filter-ID: A2006011707_4.00.0004_2.0.6,4.0-7
X-WSS-ID: 6FD39AA510G1743578-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-Path: <mark.e.mason@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9948
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mark.e.mason@broadcom.com
Precedence: bulk
X-list: linux-mips

Hello Michael,

Support for bigsur was merged into linux-mips.org some time ago.
There's even a defconfig file for it.

One known issue with running linux though - you need to have the latest
version of CFE installed on the board (1.2.5).

Hope this helps,
Mark 

-----Original Message-----
From: linux-mips-bounce@linux-mips.org
[mailto:linux-mips-bounce@linux-mips.org] On Behalf Of Michael J. Hammel
Sent: Tuesday, January 17, 2006 11:22 AM
To: linux-mips@linux-mips.org
Subject: Broadcom Bigsur build

Does anyone have a sample config file for use with 2.6.14.6 that boots a
BigSur board?  I've tried this kernel using the mips patch (via Cross
Linux From Scratch) but the boot locks up right after printing the board
type:

CFE> boot -elf 172.22.251.154:vmlinux-2.6.14.6
Loader:elf Filesys:tftp Dev:eth0 File:172.22.251.154:vmlinux-2.6.14.6
Options:()Loading: 0xffffffff80100000/3596456 0xffffffff8046e0a8/307112
Entry at 0x8043400Closing network.
Starting program at 0x80434000
[RUN!]
Broadcom SiByte BCM1480 S0 (pass1) @ 600 MHz (SB-1A rev 0) Board type:
SiByte BCM91x80A/B (BigSur)

--
Michael J. Hammel <mips@graphics-muse.org>
