Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 28 Dec 2003 19:56:07 +0000 (GMT)
Received: from honk1.physik.uni-konstanz.de ([IPv6:::ffff:134.34.140.224]:2199
	"EHLO honk1.physik.uni-konstanz.de") by linux-mips.org with ESMTP
	id <S8225238AbTL1T4E>; Sun, 28 Dec 2003 19:56:04 +0000
Received: from localhost (localhost [127.0.0.1])
	by honk1.physik.uni-konstanz.de (Postfix) with ESMTP id E08B72BC3C
	for <linux-mips@linux-mips.org>; Sun, 28 Dec 2003 20:56:02 +0100 (CET)
Received: from honk1.physik.uni-konstanz.de ([127.0.0.1])
 by localhost (honk [127.0.0.1:10024]) (amavisd-new) with ESMTP id 30299-02
 for <linux-mips@linux-mips.org>; Sun, 28 Dec 2003 20:55:41 +0100 (CET)
Received: from bogon.sigxcpu.org (p213.54.170.161.tisdip.tiscali.de [213.54.170.161])
	by honk1.physik.uni-konstanz.de (Postfix) with ESMTP id 7E5FE2BC39
	for <linux-mips@linux-mips.org>; Sun, 28 Dec 2003 20:55:41 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
	id 14AFC41D9; Sun, 28 Dec 2003 20:54:34 +0100 (CET)
Date: Sun, 28 Dec 2003 20:54:34 +0100
From: Guido Guenther <agx@sigxcpu.org>
To: linux-mips@linux-mips.org
Subject: 2.6 64bit kernels
Message-ID: <20031228195433.GH1298@bogon.ms20.nix>
Mail-Followup-To: Guido Guenther <agx@sigxcpu.org>,
	linux-mips@linux-mips.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
X-Virus-Scanned: by amavisd-new-20021227-p2 (Debian)
Return-Path: <agx@sigxcpu.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3837
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: agx@sigxcpu.org
Precedence: bulk
X-list: linux-mips

Hi,
could anybody explain to me how one builds 2.6 (current CVS) 64bit
kernel resulting in a 32bit ELF executable with a current (gcc >= 3.3,
bintuils >= 2.14.90.0.5) toolchain.
Major showstopper is that -Wa,-mabi=o64 doesn't work anymore, but
-Wa,-mabi=32 -Wa,-mgp64 doesn't either since the assembler doesn't
accept it.
Thanks for any help,
 -- Guido
