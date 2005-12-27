Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Dec 2005 06:31:59 +0000 (GMT)
Received: from wproxy.gmail.com ([64.233.184.192]:33314 "EHLO wproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8126497AbVL0Gb3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 27 Dec 2005 06:31:29 +0000
Received: by wproxy.gmail.com with SMTP id 36so1109481wra
        for <linux-mips@linux-mips.org>; Mon, 26 Dec 2005 22:33:11 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=b60SN/7ZjQYzaL22EErV/fCwVDij0fCThNNMpM85HgN9w7E1NGJr2XimW3QPsDV/6D+iNX26nL4khhvUZO1dRsOEPN9CxIyymWutvTZT2PedoA7EVgYymrlDiPr6XLJBm44D+qNZwntqPQNtArgit8ratIXoAr75I9eZOtcNehA=
Received: by 10.54.157.19 with SMTP id f19mr2518185wre;
        Mon, 26 Dec 2005 22:33:11 -0800 (PST)
Received: by 10.54.156.5 with HTTP; Mon, 26 Dec 2005 22:33:11 -0800 (PST)
Message-ID: <50c9a2250512262233n651294acicd1da8ed677472f1@mail.gmail.com>
Date:	Tue, 27 Dec 2005 14:33:11 +0800
From:	zhuzhenhua <zzh.hust@gmail.com>
To:	linux-mips@linux-mips.org
Subject: implicit declaration of function `BUILD_BUG'
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Return-Path: <zzh.hust@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9739
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zzh.hust@gmail.com
Precedence: bulk
X-list: linux-mips

when i compile the linux-2.6.14, i have too many warning as follow:

implicit declaration of function `BUILD_BUG'
include/asm/io.h:399: warning: implicit declaration of function `BUILD_BUG'

i have checked the io.h:399, but i can not find something wrong
can someone tell me why?

thanks!

Best regards



zhuzhenhua
