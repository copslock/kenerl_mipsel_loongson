Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Apr 2009 18:35:15 +0100 (BST)
Received: from dns1.mips.com ([63.167.95.197]:65494 "EHLO dns1.mips.com")
	by ftp.linux-mips.org with ESMTP id S20023866AbZDORfJ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 15 Apr 2009 18:35:09 +0100
Received: from MTVEXCHANGE.mips.com ([192.168.36.60])
	by dns1.mips.com (8.13.8/8.13.8) with ESMTP id n3FHZQ9I027917;
	Wed, 15 Apr 2009 10:35:26 -0700
Received: from [192.168.65.41] ([192.168.65.41]) by MTVEXCHANGE.mips.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 15 Apr 2009 10:34:59 -0700
Message-ID: <49E61AC3.2050402@mips.com>
Date:	Wed, 15 Apr 2009 10:34:59 -0700
From:	Chris Dearman <chris@mips.com>
Organization: MIPS Technologies
User-Agent: Icedove 1.5.0.14eol (X11/20090106)
MIME-Version: 1.0
To:	wu zhangjin <wuzhangjin@gmail.com>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] ftrace porting of linux-2.6.29 for mips
References: <b00321320904021847w5ab3acb6nd1cd554c251ef8f6@mail.gmail.com> <20090403113315.GC6629@adriano.hkcable.com.hk> <b00321320904030503w8fe0165t2aded6727f35e24c@mail.gmail.com> <b00321320904030551p774d295lce3581c23d9d8c26@mail.gmail.com> <20090403141158.GA27751@adriano.hkcable.com.hk> <b00321320904030753s2e10503fud4ba50b0fda13d8f@mail.gmail.com> <20090403160304.GB27751@adriano.hkcable.com.hk> <20090403180652.GC27751@adriano.hkcable.com.hk> <20090414124001.GB28950@adriano.hkcable.com.hk>
In-Reply-To: <20090414124001.GB28950@adriano.hkcable.com.hk>
Content-Type: multipart/mixed;
 boundary="------------090804080601090507000200"
X-OriginalArrivalTime: 15 Apr 2009 17:34:59.0728 (UTC) FILETIME=[80313900:01C9BDF0]
Return-Path: <chris@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22340
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chris@mips.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------090804080601090507000200
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Zhang Le wrote:
> I got ftrace working on fuloong 2f box, finally.
> 
> The patch could be get here:
> http://repo.or.cz/w/linux-2.6/linux-loongson.git?a=shortlog;h=refs/heads/linux-2.6.29-stable-ftrace-from-wu
> 
> It is the second last patch in the above git repo.

I pulled this patch into my local tree to try it out. The attached patch 
removes spurious warnings about linking pic and non-pic object files.

It might be better to pass KBUILD_CFLAGS into the script to get the same 
build options as the rest of the kernel. Was there a reason not to do this?

Regards
Chris

-- 
Chris Dearman               Desk: +1 650 567 5092  Cell: +1 650 224 8603
MIPS Technologies Inc         1225 Charleston Rd, Mountain View CA 94043

--------------090804080601090507000200
Content-Type: text/x-patch;
 name="ftrace.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ftrace.patch"

commit dfda04e16fa0cb3929c799d3fdec6b2c1bcc7e51
Author: Chris Dearman <chris@mips.com>
Date:   Wed Apr 15 10:26:38 2009 -0700

    [MIPS] Generate non-PIC object file when building mcount helper code
    
    Signed-off-by: Chris Dearman <chris@mips.com>

diff --git a/scripts/recordmcount.pl b/scripts/recordmcount.pl
index 8f6118e..ccf4043 100755
--- a/scripts/recordmcount.pl
+++ b/scripts/recordmcount.pl
@@ -213,7 +213,7 @@ if ($arch eq "x86_64") {
             $ld .= " -melf".$bits."ltsmip";
     }   
 
-    $cc .= " -mno-abicalls -mabi=" . $bits . $endian;
+    $cc .= " -mno-abicalls -fno-pic -mabi=" . $bits . $endian;
     $ld .= $endian;
 
     if ($bits == 64) {

--------------090804080601090507000200--
