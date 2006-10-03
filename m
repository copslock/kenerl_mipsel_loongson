Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Oct 2006 15:43:54 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.185]:38023 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20037823AbWJCOnw (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 3 Oct 2006 15:43:52 +0100
Received: by nf-out-0910.google.com with SMTP id l23so184193nfc
        for <linux-mips@linux-mips.org>; Tue, 03 Oct 2006 07:43:51 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:subject:content-type:content-transfer-encoding:from;
        b=WzLNzRcMG7pvK/Y1uy1mNxYojweL20ud4XJiNtdsHt/E5Fw/tsKRJrG8ONFKKNjjFxjf7RjUymRhcq5fDWWHzb75IzS79YmgxuZakRLm9dC1+MzYilWA1gy6+3z5SUNCBHowHpDQLTGnR1PmE+uXxs9I0wfPyedJLAknc3B53JA=
Received: by 10.48.48.15 with SMTP id v15mr924082nfv;
        Tue, 03 Oct 2006 07:43:51 -0700 (PDT)
Received: from ?192.168.0.24? ( [81.252.61.1])
        by mx.gmail.com with ESMTP id l32sm1218693nfa.2006.10.03.07.43.50;
        Tue, 03 Oct 2006 07:43:50 -0700 (PDT)
Message-ID: <45227762.8090207@innova-card.com>
Date:	Tue, 03 Oct 2006 16:44:50 +0200
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: [RFC] setup.c: get ride of CPHYSADDR()
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12778
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

The following patch is an attempt to remove this macro in setup.c.
I'm not sure about why sometimes it is used and sometimes it is
not. By sending this RFC, I hope to get some feedbacks that will shed
some light on this obscure macro...

The reason why I'm trying to kick out this macro is that we should
rely on __pa() for address convertions instead of having several
helpers that do the same thing but differently. Futermore if some
tricks are needed for these conversions, they should be done in
one place.

Thanks
		Franck

-- >8 --

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index fdbb508..00d62bd 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -204,12 +204,12 @@ static void __init finalize_initrd(void)
 		printk(KERN_INFO "Initrd not found or empty");
 		goto disable;
 	}
-	if (CPHYSADDR(initrd_end) > PFN_PHYS(max_low_pfn)) {
+	if (__pa(initrd_end) > PFN_PHYS(max_low_pfn)) {
 		printk("Initrd extends beyond end of memory");
 		goto disable;
 	}
 
-	reserve_bootmem(CPHYSADDR(initrd_start), size);
+	reserve_bootmem(__pa(initrd_start), size);
 	initrd_below_start_ok = 1;
 
 	printk(KERN_INFO "Initial ramdisk at: 0x%lx (%lu bytes)\n",
@@ -256,7 +256,7 @@ static void __init bootmem_init(void)
 	 * of usable memory.
 	 */
 	reserved_end = init_initrd();
-	reserved_end = PFN_UP(CPHYSADDR(max(reserved_end, (unsigned long)&_end)));
+	reserved_end = PFN_UP(__pa(max(reserved_end, (unsigned long)&_end)));
 
 	/*
 	 * Find the highest page frame number we have available.
