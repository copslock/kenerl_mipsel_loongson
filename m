Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Mar 2003 17:43:00 +0000 (GMT)
Received: from mta9-0.mail.adelphia.net ([IPv6:::ffff:64.8.50.199]:17634 "EHLO
	mta9.adelphia.net") by linux-mips.org with ESMTP
	id <S8225203AbTCRRm7>; Tue, 18 Mar 2003 17:42:59 +0000
Received: from there ([24.51.55.15]) by mta6.adelphia.net
          (InterMail vM.5.01.05.27 201-253-122-126-127-20021220) with SMTP
          id <20030318172414.MLZJ7686.mta6.adelphia.net@there>
          for <linux-mips@linux-mips.org>; Tue, 18 Mar 2003 12:24:14 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
From: Neurophyre <listbox@evernex.com>
To: linux-mips@linux-mips.org
Subject: 2.4.20 SCSI problems on NASRaQ
Date: Tue, 18 Mar 2003 12:24:10 -0500
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20030318172414.MLZJ7686.mta6.adelphia.net@there>
Return-Path: <listbox@evernex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1765
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: listbox@evernex.com
Precedence: bulk
X-list: linux-mips

Hello all.  I'm trying to get Debian 3.0r1 working usefully on a
MIPS-based Seagate (Cobalt) NASRaQ.  The system uses the same processor
as the Qube 2 and has an integrated 53c860 SCSI controller, which would
appear to be supported by no fewer than three kernel drivers!

I'm compiling the kernel source available at
ftp://ftp.linux-mips.org/pub/linux/mips/kernel/test/linux-2.4.20.tar.gz
WITH Paul Martin's tulip and PCIfun patches applied.  I should mention
that the stock 2.4.20 source with the debian kernel-patch-2.4-cobalt
package applied to it presented numerous problems and I had to give up.

The problem is that upon boot (or module installation), I get similar
messages from all three SCSI drivers.

Examples:

sym.0.8.0: IO region 0x10102000[0..127] is in use
or
ncr53c8xx: IO region 0x10102000[0..127] is in use

On boot, the boot process just goes on, but no 'scsi0 blah blah'
printout occurs, and nothing is printed about a tape drive I have
attached to the machine for testing.

When installing as a module (only tested with sym53c8xx driver) the
module installation fails and a message like above is printed to the
serial console.

Doing a 'cat /proc/scsi/scsi' yields

Attached devices: none

no matter what.

Does anyone have any suggestions?  We'd really like to modernize the
NASRaQ and still be able to use its SCSI port.
