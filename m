Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Apr 2010 18:58:34 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:10179 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492402Ab0D3Q63 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 30 Apr 2010 18:58:29 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4bdb0c3f0000>; Fri, 30 Apr 2010 09:58:39 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Fri, 30 Apr 2010 09:57:47 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Fri, 30 Apr 2010 09:57:47 -0700
Message-ID: <4BDB0C0A.1060506@caviumnetworks.com>
Date:   Fri, 30 Apr 2010 09:57:46 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100330 Fedora/3.0.4-1.fc12 Thunderbird/3.0.4
MIME-Version: 1.0
To:     linux-mips <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        =?UTF-8?B?UmFsZiBSw7ZzY2g=?= <ralf.roesch@rw-gmbh.de>
Subject: Fwd: check_for_high_segbits not used when 32bit
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 30 Apr 2010 16:57:47.0548 (UTC) FILETIME=[42AE95C0:01CAE886]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26541
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Sorry about that.

Perhaps you can send it with a Signed-off-by: to lmo.

David Daney

-------- Original Message --------
Subject: check_for_high_segbits not used when 32bit
Date: Fri, 30 Apr 2010 17:57:53 +0200
From: Ralf Rösch <ralf.roesch@rw-gmbh.de>
To: ddaney@caviumnetworks.com

Hi David,

check_for_high_segbits are only used when 64 bit kernel.

CC      arch/mips/mm/tlbex.o
cc1: warnings being treated as errors
/pub/build/linux-mips/work-2.6/arch/mips/mm/tlbex.c:172: error:
‘check_for_high_segbits’ defined but not used
make[6]: *** [arch/mips/mm/tlbex.o] Fehler 1

regards
Ralf



diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index e60ea35..86f004d 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -169,7 +169,9 @@ static u32 tlb_handler[128] __cpuinitdata;
  static struct uasm_label labels[128] __cpuinitdata;
  static struct uasm_reloc relocs[128] __cpuinitdata;

+#ifdef CONFIG_64BIT
  static int check_for_high_segbits __cpuinitdata;
+#endif

  #ifndef CONFIG_MIPS_PGD_C0_CONTEXT
  /*

-- 
Roesch&  Walter___________________________________________
Industrie-Elektronik GmbH * Tel.: +49-7824 / 6628-0
Wörtelweg 2b/c            * Fax:  +49-7824 / 6628-29
D-77963 Schwanau          * mailto:ralf.roesch@rw-gmbh.de
Germany                   * WWW: http://www.rw-gmbh.de
Amtsgericht Freiburg i.Br. HRB 391345
Geschäftsführer: Dipl.Ing.(FH) Ralf Rösch, Dipl.Ing.(FH) Martin Walter
