Received:  by oss.sgi.com id <S305167AbQDGImY>;
	Fri, 7 Apr 2000 01:42:24 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:55340 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305171AbQDGImO>;
	Fri, 7 Apr 2000 01:42:14 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id BAA09995; Fri, 7 Apr 2000 01:37:31 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id BAA68447
	for linux-list;
	Fri, 7 Apr 2000 01:34:06 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id BAA51062
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 7 Apr 2000 01:34:04 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: from noose.gt.owl.de (noose.gt.owl.de [62.52.19.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id BAA07572
	for <linux@cthulhu.engr.sgi.com>; Fri, 7 Apr 2000 01:34:03 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id B83737F4; Fri,  7 Apr 2000 10:34:04 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 303F48FC3; Fri,  7 Apr 2000 10:20:38 +0200 (CEST)
Date:   Fri, 7 Apr 2000 10:20:38 +0200
From:   Florian Lohoff <flo@rfc822.org>
To:     Ralf Baechle <ralf@oss.sgi.com>
Cc:     linux@cthulhu.engr.sgi.com
Subject: Re: DMA memory on IP22 unavailable ?
Message-ID: <20000407102038.D268@paradigm.rfc822.org>
References: <20000406215014.E5141@paradigm.rfc822.org> <20000406153741.C801@uni-koblenz.de> <20000407101346.C268@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <20000407101346.C268@paradigm.rfc822.org>; from Florian Lohoff on Fri, Apr 07, 2000 at 10:13:46AM +0200
Organization: rfc822 - pure communication
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Fri, Apr 07, 2000 at 10:13:46AM +0200, Florian Lohoff wrote:

> BTW: Are the EISA slots supported ? 
>      Does the "Default" MAX_DMA_ADDRESS apply to that DMA controller ?
>      My above solution just declares all memory to DMA-able memory.

BTW: With above solution i meant a thread with Geert which contained a
probably better solution.

This is arch/mips/mm/init.c - Which puts all memory into ZONE_DMA when
no ISA or PCI available.

#if defined(CONFIG_ISA) || defined(CONFIG_PCI)
        if (low < max_dma)
                zones_size[ZONE_DMA] = low;
        else {
                zones_size[ZONE_DMA] = max_dma;
                zones_size[ZONE_NORMAL] = low - max_dma;
        }
#else
        zones_size[ZONE_DMA] = low;
#endif

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-subject-2-change
"Technology is a constant battle between manufacturers producing bigger and
more idiot-proof systems and nature producing bigger and better idiots."
