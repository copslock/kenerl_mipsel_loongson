Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Mar 2009 08:35:02 +0000 (GMT)
Received: from n4a.bullet.mail.ac4.yahoo.com ([76.13.13.67]:31624 "HELO
	n4a.bullet.mail.ac4.yahoo.com") by ftp.linux-mips.org with SMTP
	id S32702472AbZCWIe5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 23 Mar 2009 08:34:57 +0000
Received: from [76.13.13.26] by n4.bullet.mail.ac4.yahoo.com with NNFMP; 23 Mar 2009 08:34:50 -0000
Received: from [76.13.10.172] by t3.bullet.mail.ac4.yahoo.com with NNFMP; 23 Mar 2009 08:34:50 -0000
Received: from [127.0.0.1] by omp113.mail.ac4.yahoo.com with NNFMP; 23 Mar 2009 08:34:50 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 907527.26132.bm@omp113.mail.ac4.yahoo.com
Received: (qmail 62733 invoked by uid 60001); 23 Mar 2009 08:34:50 -0000
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1237797290; bh=bJyxL+LoWXJy2PPK9MbSBhxzjlFS7KtMOuwPSsYOClU=; h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type; b=aqHWpeZ93mm3UGawX9pgxWw+pH45O5Rv/13Ss4U0eXXDbUeoGOGvkE8UCA8pC2IIlrzuGanj+YnEE/nS2gJYkwACm46ypnUAhvYJCUXVb9cV7MgJDn/JDU68VLnNhHqsf1mEznHStR2hB+DwX4VgYF9v/VivSA2WJsx2WzUA6XY=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type;
  b=RqdmjeaA1RlGmPd8+Rgy2LX/K7NHMCRi/VVUWYShTcRlqVgMYQp4D9kO4eTCyetB9BKBgDXanu/C0jN8Lq/LaZKm+MTE3PpRn1G/stUqHMC7mZGNgRMsrPrwvsKWVw/ZXNL8joWTdMxdNIdUi7R9ug0VJyNLAjOY/1lM/97oNOg=;
Message-ID: <773141.58551.qm@web59808.mail.ac4.yahoo.com>
X-YMail-OSG: qoAlq3QVM1n2UtGisCmb1k6GASg5PwcTR27npFXJGoB8iXQwZ4zV1yVDkjcuCXZvenrRtGE8Y0EscteOtt6bXk99TFxaL8DxFmIFg0YFjyN_nITjJJG8AsTDgyM_Jn8KGj2_F34EbsPTWY7jVle47OR09kHDP6zU6Z2ypSKOVRd.DAaaeRRn2I2i2iHdLr4IQClGgbXtal8z
Received: from [91.196.252.17] by web59808.mail.ac4.yahoo.com via HTTP; Mon, 23 Mar 2009 01:34:50 PDT
X-Mailer: YahooMailWebService/0.7.289.1
Date:	Mon, 23 Mar 2009 01:34:50 -0700 (PDT)
From:	Andrew Randrianasulu <randrik_a@yahoo.com>
Reply-To: randrik_a@yahoo.com
Subject: ip22 vdma question
To:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <randrik_a@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22126
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: randrik_a@yahoo.com
Precedence: bulk
X-list: linux-mips


After looking at vdma.pdf on linux-mips ftp site, i have (dumb) question:

This DMA hardware was designed for User-Mode DMA, as well normal-style kernel-mode DMA. For user-mode  DMA hardware (located in MemoryController) should (or simply can) translate virt->phys adresses, according to some registers, updated on every context switch. But traditional DMA, with physical addresses, should be more easy for setup? Code in Linux kernel tree has comment about MC interrupts (they should be handled in driver, not in core code) - so, if one want to add (V)DMA support to fb [currently - newport, may be others in the future] driver , and then potentially to X driver as well (with some drm-like kernel module, for handling interrupts and DMA itself) he must look at HAL2  (audio ) sources as comment suggest, and try to figure out how to write such code? 

One more question: my SGI O2 has many hardware units, usually working together: Rendering/Drawing Engine for graphics output, MemoryTransferEngine for moving blocks of memory around, including video memory (O2 is UMA system), VICE coprocessor, with two DMA channels and two execution units. (all this under native OS, of course .. i know some details thanks to NetBSD project and work done here at linux-mips.org). How (conceptually) add such wide functionality in Linux kernel? I guess, recently-merged GEM (GraphicsExecutionManager, iirc) can help here, for keeping track of currently used memory 'tiles' for graphics and rest of memory. (front buffer/optional back buffer/optional Z buffer/optional texture storage/optional offscreen render buffer, all can be tiled or not. Working blocks of memory for VICE. Blocks, currently in-move, or in-clear due to MTE activity). Not sure how to expose this machinery to userspace - just as set of buffers, with some control
 node(s), for requesting buffer, release buffer, clear buffer, move buffer around, change buffer type?  with list of "used-by-xxx" attributes?? May be just expose MTE as `generic` DMA engine for start (if this unit really can move  blocks of memory in full 1GB [max memory size on O2] range)?

Also, patches for r10k O2 still unstable? I have only r5k, so i can't test them, but if i remember correctly there was mostly driver issues, network and scsi namely. I'm very unfamiliar with anything SCSI, PCI related - can someone just look at current code and post some comments here?


      
