Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7OBspp11807
	for linux-mips-outgoing; Fri, 24 Aug 2001 04:54:51 -0700
Received: from t111.niisi.ras.ru (IDENT:root@[193.232.173.111])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7OBsRd11740
	for <linux-mips@oss.sgi.com>; Fri, 24 Aug 2001 04:54:29 -0700
Received: from t06.niisi.ras.ru (t06.niisi.ras.ru [193.232.173.6])
	by t111.niisi.ras.ru (8.9.1/8.9.1) with ESMTP id PAA29899
	for <linux-mips@oss.sgi.com>; Fri, 24 Aug 2001 15:54:16 +0400
Received: (from uucp@localhost) by t06.niisi.ras.ru (8.7.6/8.7.3) with UUCP id PAA00518 for linux-mips@oss.sgi.com; Fri, 24 Aug 2001 15:30:17 +0400
Received: from niisi.msk.ru (t34 [193.232.173.34]) by niisi.msk.ru (8.8.8/8.8.8) with ESMTP id NAA20624 for <linux-mips@oss.sgi.com>; Fri, 24 Aug 2001 13:54:57 +0400 (MSD)
Message-ID: <3B862487.EF22D143@niisi.msk.ru>
Date: Fri, 24 Aug 2001 13:55:19 +0400
From: "Gleb O. Raiko" <raiko@niisi.msk.ru>
Organization: NIISI RAN
X-Mailer: Mozilla 4.77 [en] (WinNT; U)
X-Accept-Language: en,ru
MIME-Version: 1.0
To: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: arch/mips/pci* stuff
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hello,

Could somebody, please, explain me what arch/mips/pci* stuff is for? My
understanding is drivers/pci code shall setup everything except proper
placing in PCI MEM/IO spaces and irqs. The code in arch/mips/pci*
contains much more.

Anyway, drivers/pci code provides enough fixup interface, doesn't it ?

BTW, if the code in arch/mips/pci* is really required how about
fine-grained placing, like in sparc64?

Regards,
Gleb.
