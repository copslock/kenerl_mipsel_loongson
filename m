Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Nov 2009 06:59:23 +0100 (CET)
Received: from mail-pz0-f194.google.com ([209.85.222.194]:38234 "EHLO
	mail-pz0-f194.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492132AbZKDF7Q (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 4 Nov 2009 06:59:16 +0100
Received: by pzk32 with SMTP id 32so4621608pzk.21
        for <multiple recipients>; Tue, 03 Nov 2009 21:59:06 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :content-type:organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=4+9wjNcALbJgNrRWWyl0BTpbTMtMbodJH4CMMT7Tu7A=;
        b=lzh7M4cWsgGqHTTDBOrI+BcC9qhvZNv5c6tVTdagT+UggzCwm0YQiyRbssUtTFZaXG
         /iM3x4YqHEGvZcYo2IyFNb1RrqgFN0X6C5o3AQmZb6A8hsCf7OkK76ehyWCCGoxSbnpw
         bHKYdZlpgrdJp+NMLBal+SMbsZFc7l1sm85ws=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:content-type:organization:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=nb/iCqS4EoqGFuMvvR6gj6ervviRAZi+dyz1A+z4fx6310b0aTS8TTrUpA+R90/oKK
         lb3BWv7LgdlwjRng11ZGSpi9ncho9UCKINVNolNsgBakO4VCReL9L2RDq2aYq+xrwQtG
         EhJ9kRgkkN9zc17ojwVnuH3Nsk2gdb3n0cNT0=
Received: by 10.115.66.29 with SMTP id t29mr1333273wak.187.1257314346821;
        Tue, 03 Nov 2009 21:59:06 -0800 (PST)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 21sm411051pzk.3.2009.11.03.21.59.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 03 Nov 2009 21:59:06 -0800 (PST)
Subject: [-queue] arch/mips/kernel/linux32.c:304: error: implicit
 declaration of function 'lock_kernel'
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:	Wed, 04 Nov 2009 13:59:09 +0800
Message-ID: <1257314349.3778.62.camel@falcon.domain.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24655
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Hi, Ralf

When I compile the queue branch of your -queue git repo, meet this
error:

arch/mips/kernel/linux32.c: In function 'SYSC_32_sysctl':
arch/mips/kernel/linux32.c:304: error: implicit declaration of function
'lock_kernel'
arch/mips/kernel/linux32.c:307: error: implicit declaration of function
'unlock_kernel'

and found you have removed this <linux/smp_lock.h> header file in
linux32.c in this commit: 

commit 0adcf22332d4da33629568fd14e00069cbf002e6
Author: Ralf Baechle <ralf@linux-mips.org>
Date:   Tue Nov 3 23:06:18 2009 +0100

    MIPS: Don't include <linux/smp_lock.h> unnecessarily.
    
    Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

:100644 100644 938b1d0... 3676660... M
arch/mips/basler/excite/excite_iodev.c
:100644 100644 b77fefa... 07cc39e... M  arch/mips/kernel/linux32.c
:100644 100644 364f066... dcaed1b... M  arch/mips/kernel/rtlx.c
:100644 100644 6047752... 2bd2151... M  arch/mips/kernel/vpe.c
:100644 100644 15ea778... ed2453e... M
arch/mips/sibyte/common/sb_tbprof.c

So, revert it for linux32.c?

Regards,
	Wu Zhangjin
