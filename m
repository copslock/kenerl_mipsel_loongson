Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Sep 2008 13:09:56 +0100 (BST)
Received: from fg-out-1718.google.com ([72.14.220.152]:56200 "EHLO
	fg-out-1718.google.com") by ftp.linux-mips.org with ESMTP
	id S20033190AbYIWMJx (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 23 Sep 2008 13:09:53 +0100
Received: by fg-out-1718.google.com with SMTP id d23so1946901fga.32
        for <linux-mips@linux-mips.org>; Tue, 23 Sep 2008 05:09:52 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:reply-to:organization:to
         :subject:date:user-agent:x-face:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=x/P2SOq+EEi8Dfdtb5xifQhLezO+bF92vv04j5uqGEk=;
        b=Mg8LR0XjX9tl1T+D+Md3HX67cCf9lC8hF8hfU1M3xOk6rhcDTIyciujnkA8Pe5jkzY
         G0aBxqi/kujl1syg3qYsjg2jgFEoQOtcQ7UnQ7pN2ju0SpAUvrtJjJtsKPj67YV75PiM
         /4L6f6eZQOVibC7xYIb8CTS/njoXCkGPavfAA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:reply-to:organization:to:subject:date:user-agent:x-face
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=aF6kaIp4wCyIVIeejQkywLMchBBWKj2TEmkV0KSgNHsoK6jkzbojimoKrp1P9xdphY
         J8KIX9pfLrSliyvKWV09pFW1x4et/Ii73PHUR37nzbuu+K4PZHXuA2V5xn6+B52p7xKo
         Dhm65aj1bnO3fCFq1itzALrVLj59AZQVdTCNM=
Received: by 10.86.100.19 with SMTP id x19mr205935fgb.29.1222171792122;
        Tue, 23 Sep 2008 05:09:52 -0700 (PDT)
Received: from cartesio.localnet (host250-108-static.46-85-b.business.telecomitalia.it [85.46.108.250])
        by mx.google.com with ESMTPS id 12sm7340511fgg.0.2008.09.23.05.09.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 23 Sep 2008 05:09:51 -0700 (PDT)
From:	"Luigi 'Comio' Mantellini" <luigi.mantellini.ml@gmail.com>
Reply-To: luigi.mantellini.ml@gmail.com
Organization: Industrie Dial Face S.p.A.
To:	linux-mips@linux-mips.org
Subject: page_write_back infinite wait (porting to Mips 4kec SoC)
Date:	Tue, 23 Sep 2008 14:09:44 +0200
User-Agent: KMail/1.10.1 (Linux/2.6.24-21-generic; KDE/4.1.1; i686; ; )
X-Face:	'6!%DGk.Oa/l`>tHr&^29|<`2s/|PIbM@0,\4g%@-F7xr9V,K@Iu<A>G-jQ\T_t@ZM5UC7
	.l0\.nz[=$C9^`vJt;P=ZRBk2+x+pB)\8;"bA3>@5aI66l5Xfw*X8#+kcy1ybOBUNMnc;s
	UXb\&]+8*bloRi<euepX(,esSS\}3j|oU|_Xku72+-?C0miI}a^~$j-O-/ELA-gTX/IVUi
	%fmY6(!tfc}&,mzme<IwkA;^CKV:vIY</xKrN8F6`X~EPI#-B4*e"I;edO
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200809231409.44987.luigi.mantellini.ml@gmail.com>
Return-Path: <luigi.mantellini.ml@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20600
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: luigi.mantellini.ml@gmail.com
Precedence: bulk
X-list: linux-mips

Hi List,

I'm working on a 4Kec SoC. I'm trying to port a recent kernel (2.6.26-rcX from 
trunk) to my SoC but I have problem on timers (i think).

The start sequence (start_kernel @init/main.c) freezes on the 
page_writeback_init() call. The page_writeback_init function calls the 
lock_timer_base function (by means the mod_timer/__mod_timer) that fails 
always the test likely(base!=NULL) (source file kernel/timer.c). The base 
variable (ponter to tvec_base) is always NULL, resulting an infinite loop.

I'm using the cevt-r4t and csrc-4k standard mips 4k timer (on irq #7). With 
debugger I verified that the c0_compare_interrupt service routine is correctly 
invoked.

Kindly, can anyone help me to understand what I need to check to solve this 
issue? If you need other information, please, ask me (This is my first mips 
port).

Thanks in advance.

best regards.

luigi


-- 
Luigi Mantellini
R&D - Software
Industrie Dial Face S.p.A.
Via Canzo, 4
20068 Peschiera Borromeo (MI), Italy
Tel.:  +39 02 5167 2813
Fax:   +39 02 5167 2459
Email: luigi.mantellini@idf-hit.com
