Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Feb 2006 06:29:53 +0000 (GMT)
Received: from wproxy.gmail.com ([64.233.184.204]:18525 "EHLO wproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8133435AbWBIG3Y convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 9 Feb 2006 06:29:24 +0000
Received: by wproxy.gmail.com with SMTP id i3so236190wra
        for <linux-mips@linux-mips.org>; Wed, 08 Feb 2006 22:35:14 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=BH/egFK0ZohYoPmqheX/1VdYliLKzRn3lx8lKbKe8ZwHl9dCX3DxZpobmYF7eDhsH1yh/hJTfLDQ7Ek7MeTBIh/YzBJJ2lQOzo/7/9lPrMABOR6tYrJz4q0r8nbVJ4+Ph/O5SXKX8kYW0LYtHVZ9YrWcd5SPjyA5pJhuilxphl8=
Received: by 10.54.135.1 with SMTP id i1mr1107756wrd;
        Wed, 08 Feb 2006 22:35:14 -0800 (PST)
Received: by 10.54.128.6 with HTTP; Wed, 8 Feb 2006 22:35:14 -0800 (PST)
Message-ID: <50c9a2250602082235k1add529ctff120d0184425048@mail.gmail.com>
Date:	Thu, 9 Feb 2006 14:35:14 +0800
From:	zhuzhenhua <zzh.hust@gmail.com>
To:	linux-mips <linux-mips@linux-mips.org>
Subject: how to use sde toolchain to compile a hello world?
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Return-Path: <zzh.hust@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10376
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zzh.hust@gmail.com
Precedence: bulk
X-list: linux-mips

some toolchain can use as "xxx-gcc -o hello hello.c" to compile, but
sde toolchain can't find the printf function, does it means sde is not
a complete toolchain to compile applications?


Best regards

Zhuzhenhua
