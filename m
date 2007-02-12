Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Feb 2007 09:02:25 +0000 (GMT)
Received: from qb-out-0506.google.com ([72.14.204.237]:34083 "EHLO
	qb-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20038520AbXBLJCU (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 12 Feb 2007 09:02:20 +0000
Received: by qb-out-0506.google.com with SMTP id e12so539722qba
        for <linux-mips@linux-mips.org>; Mon, 12 Feb 2007 01:01:19 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=n0uO21anpFrOKlUhkC6c8Gzt7VLuUO/69ykK1doSkpfcpnls7zcZGHs52cDFkpecYZpz86L2mVHr11gbYU5mNaQk0p90Iu+0a3Nrh0Txg97eYa3dO2DrJ9iuiGBbPlPEc6l+Cdve5rCHgN31sMCz6XZEjIazaad62pEIsmbROCk=
Received: by 10.114.197.1 with SMTP id u1mr5568082waf.1171270878410;
        Mon, 12 Feb 2007 01:01:18 -0800 (PST)
Received: by 10.114.136.11 with HTTP; Mon, 12 Feb 2007 01:01:18 -0800 (PST)
Message-ID: <cda58cb80702120101k770e059end43579394206b9d2@mail.gmail.com>
Date:	Mon, 12 Feb 2007 10:01:18 +0100
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Ralf Baechle" <ralf@linux-mips.org>
Subject: Re: [PATCH 3/3] signal.c: fix gcc warning on 32 bits kernel
Cc:	"Franck Bui-Huu" <fbuihuu@gmail.com>,
	"Atsushi Nemoto" <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org
In-Reply-To: <20070209210014.GA26939@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1171033658561-git-send-email-fbuihuu@gmail.com>
	 <11710336591652-git-send-email-fbuihuu@gmail.com>
	 <20070210.011835.08318488.anemo@mba.ocn.ne.jp>
	 <61ec3ea90702090834k774bf18bwf7ec5f7b10349779@mail.gmail.com>
	 <20070209210014.GA26939@linux-mips.org>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14044
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

On 2/9/07, Ralf Baechle <ralf@linux-mips.org> wrote:
> Which is quite a funny C problem to solve :-)
>

How about this instead ?

-- >8 --

diff --git a/include/asm-mips/uaccess.h b/include/asm-mips/uaccess.h
index 1cdd4ee..ab7fe1c 100644
--- a/include/asm-mips/uaccess.h
+++ b/include/asm-mips/uaccess.h
@@ -265,7 +265,7 @@ do {									\
  */
 #define __get_user_asm_ll32(val, addr)					\
 {									\
-        unsigned long long __gu_tmp;					\
+        __typeof__(*(addr)) __gu_tmp;					\
 									\
 	__asm__ __volatile__(						\
 	"1:	lw	%1, (%3)				\n"	\
@@ -283,7 +283,7 @@ do {									\
 	"	.previous					\n"	\
 	: "=r" (__gu_err), "=&r" (__gu_tmp)				\
 	: "0" (0), "r" (addr), "i" (-EFAULT));				\
-	(val) = (__typeof__(*(addr))) __gu_tmp;				\
+	(val) = __gu_tmp;						\
 }

 /*

-- 
               Franck
