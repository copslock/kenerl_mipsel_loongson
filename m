Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Jul 2004 02:52:50 +0100 (BST)
Received: from adsl-131.111.187.info.com.ph ([IPv6:::ffff:203.131.111.187]:4360
	"EHLO GVRPD03.APTIPHILS.COM") by linux-mips.org with ESMTP
	id <S8224943AbUGWBwq>; Fri, 23 Jul 2004 02:52:46 +0100
Subject: TX4938 NAND flash bootup
To: linux-mips@linux-mips.org
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OF5043C4E7.C0E3B027-ON48256EDA.000A2B3F@APTIPHILS.COM>
From: jack.villarosa@adtxsystems.com
Date: Fri, 23 Jul 2004 09:56:29 +0800
X-MIMETrack: Serialize by Router on GVRPD03/RPD/APTiPHILS(Release 5.0.4 |June 29, 2000) at
 2004/07/23 09:56:32 AM
MIME-Version: 1.0
Content-type: text/plain; charset=iso-2022-jp
Return-Path: <jack.villarosa@adtxsystems.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5542
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jack.villarosa@adtxsystems.com
Precedence: bulk
X-list: linux-mips

Hi everyone!

Has anyone tried to boot a rbhma4500 board (tx4938 uprocessor) before? I
tried to read the reference board's manuals but couldn't find anything
linux-related. What i have already tried was to:
     1. Write NAND IPL control information (FORMAT: srec) to sram
     2. Write vmlinux.srec to sram
     3. Use NAND Writer to burn the data to NAND Flash.
     4. Changed board settings to boot starting from NAND IPL.
With these steps, neither an error nor success messages appeard. The board
just hung. Im having a hard time looking for sources on the net; thus, this
mail.

Thank you very much!

-=-=-=-=-=-=-=-ジャック=-=-=-=-=-=-=-=-
||  John Alexis S. Villarosa            Jack        ||
-  Dev 1                       Microcode          -
||  ADTX Systems, Incorporated, HQ            ||
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
