Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Jan 2006 10:01:29 +0000 (GMT)
Received: from uproxy.gmail.com ([66.249.92.204]:19766 "EHLO uproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S3458532AbWAPKBJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 16 Jan 2006 10:01:09 +0000
Received: by uproxy.gmail.com with SMTP id u40so564150ugc
        for <linux-mips@linux-mips.org>; Mon, 16 Jan 2006 02:04:40 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=gtCIoGfHk6Ubj2h6fvo3EFsPLsc/vZEtodYZ+R3+sFegTSwL8w++jB24d+JpT5/U3fT8vKT1K1Mh2cuPtbd88Je4XJN1IgKAxYmEalwnAUGenLSnTBDgcQpYYFCM1BWdCX/nPD054TWJ5JyzdorBTX8vxohDASeM9NBj1Q1fwRs=
Received: by 10.48.4.9 with SMTP id 9mr215207nfd;
        Mon, 16 Jan 2006 02:04:40 -0800 (PST)
Received: by 10.48.225.20 with HTTP; Mon, 16 Jan 2006 02:04:39 -0800 (PST)
Message-ID: <c58a7a270601160204h41e5dca7pa9c26578b6b29f6f@mail.gmail.com>
Date:	Mon, 16 Jan 2006 10:04:39 +0000
From:	Alex Gonzalez <langabe@gmail.com>
To:	linux-mips <linux-mips@linux-mips.org>
Subject: Setting gp on pic code
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Return-Path: <langabe@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9882
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: langabe@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

I am trying to set the gp register on pic code as follows:

"la gp,_gp"

Disassembling the resulting code,

"lw gp,0(gp)"

I am confused as to why it uses a gp-relative address instead of an
absolute address for _gp. How I am supposed to reset gp then?

A bit of background. I am working on a dual core chip, with each core
running independently. They both boot from the same startup code, then
the second core waits until the first one sets all the hardware and
loads a pic binary into a shared memory region.

The second core is then released and should reset gp and jump to the
new binary (which is compiled separately from the startup code).

This arrangement seems to work OK if the binary is compiled non-pic,
but for pic code  the gp register is not set to the correct value.

Any insight into this appreciated.

Thanks,
Alex
