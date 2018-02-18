Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Feb 2018 10:27:15 +0100 (CET)
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:12946 "EHLO
        ste-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992828AbeBRJ1IZluXF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 18 Feb 2018 10:27:08 +0100
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 9C8CA3F6E4;
        Sun, 18 Feb 2018 10:27:02 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from ste-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (ste-ftg-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 0zsBNJz_DupF; Sun, 18 Feb 2018 10:27:00 +0100 (CET)
Received: from localhost.localdomain (h-155-4-135-114.NA.cust.bahnhof.se [155.4.135.114])
        (Authenticated sender: mb547485)
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 0BDA73F4B9;
        Sun, 18 Feb 2018 10:26:47 +0100 (CET)
Date:   Sun, 18 Feb 2018 10:26:46 +0100
From:   Fredrik Noring <noring@nocrew.org>
To:     =?utf-8?Q?J=C3=BCrgen?= Urban <JuergenUrban@gmx.de>
Cc:     "Maciej W. Rozycki" <macro@mips.com>, linux-mips@linux-mips.org
Subject: [RFC] MIPS: R5900: Workaround where MSB must be 0 for the
 instruction cache
Message-ID: <20180218092645.GB2577@localhost.localdomain>
References: <alpine.DEB.2.00.1709201705070.16752@tp.orcam.me.uk>
 <20170927172107.GB2631@localhost.localdomain>
 <alpine.DEB.2.00.1709272208300.16752@tp.orcam.me.uk>
 <20170930065654.GA7714@localhost.localdomain>
 <alpine.DEB.2.00.1709301305400.12020@tp.orcam.me.uk>
 <20171029172016.GA2600@localhost.localdomain>
 <alpine.DEB.2.00.1711102209440.10088@tp.orcam.me.uk>
 <20171111160422.GA2332@localhost.localdomain>
 <20180129202715.GA4817@localhost.localdomain>
 <alpine.DEB.2.00.1801312259410.4191@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.DEB.2.00.1801312259410.4191@tp.orcam.me.uk>
User-Agent: Mutt/1.9.1 (2017-09-22)
Return-Path: <noring@nocrew.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62606
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: noring@nocrew.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Hi Jürgen,

Would you know if this R5900 bug is documented in Sony's Linux Toolkit
Restriction manual or in the TX79 manual?

Fredrik

diff --git a/arch/mips/include/asm/r4kcache.h b/arch/mips/include/asm/r4kcache.h
index 2c905dbe6464..4a4f552f6885 100644
--- a/arch/mips/include/asm/r4kcache.h
+++ b/arch/mips/include/asm/r4kcache.h
@@ -28,7 +28,12 @@
  *  - We need a properly sign extended address for 64-bit code.  To get away
  *    without ifdefs we let the compiler do it by a type cast.
  */
+#ifdef CONFIG_CPU_R5900
+/* CPU has a bug MSB must be 0 for instruction cache. */
+#define INDEX_BASE	0
+#else
 #define INDEX_BASE	CKSEG0
+#endif
 
 #define cache_op_s(op,addr)						\
 	__asm__ __volatile__(						\
