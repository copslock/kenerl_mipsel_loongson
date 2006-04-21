Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Apr 2006 15:55:44 +0100 (BST)
Received: from pproxy.gmail.com ([64.233.166.183]:60288 "EHLO pproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8133623AbWDUOzf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 21 Apr 2006 15:55:35 +0100
Received: by pproxy.gmail.com with SMTP id d80so529338pyd
        for <linux-mips@linux-mips.org>; Fri, 21 Apr 2006 08:08:23 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=XBGJbotB10GRH54SgwauLt2YPfEf+6AujVy7w5hbzzxJYGkBqc0VnCbR9JlHMssreWzO8LpuJMDwiCL1MKbRFvRC/6n0ZnkAA5hm90Il9BQCAHmFRoNhqrsxfBUN8r3VKY3ShVrGIhANv/0TKHR6B/rsLudcGlyuA4ERGf4D1jw=
Received: by 10.35.22.17 with SMTP id z17mr1823347pyi;
        Fri, 21 Apr 2006 08:08:22 -0700 (PDT)
Received: by 10.35.60.20 with HTTP; Fri, 21 Apr 2006 08:08:22 -0700 (PDT)
Message-ID: <3857255c0604210808y1208045by3449b003b4b2ffea@mail.gmail.com>
Date:	Fri, 21 Apr 2006 20:38:22 +0530
From:	"Shyamal Sadanshio" <shyamal.sadanshio@gmail.com>
To:	linux-mips@linux-mips.org
Subject: Crosstools for MALTA MIPS in little endian
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Return-Path: <shyamal.sadanshio@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11173
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: shyamal.sadanshio@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

I am come across the MALTA specific stable kernel (2.6.12-rc6)
available on linux-malta.git repository.
I have cloned this repository and would like to build it with the
compatible toolchain in little endian mode.

Can anyone please let me know the toolchain specification
(gcc/glibc/binutils version specifcations) that have been used or can
be used for compiling the 2.6.12 kernel?

I tried to build the few toolchain combination from automated script
(demo-mipsel.sh) available at kegel.com, but they are failing.

My native OS is Red Hat 9 (gcc version 3.2.2 20030222 (Red Hat Linux 3.2.2-5).

Thanks and Regards,
Shyamal
