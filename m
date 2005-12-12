Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Dec 2005 21:34:05 +0000 (GMT)
Received: from xproxy.gmail.com ([66.249.82.195]:39015 "EHLO xproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8133566AbVLLVds (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 12 Dec 2005 21:33:48 +0000
Received: by xproxy.gmail.com with SMTP id s14so1126774wxc
        for <linux-mips@linux-mips.org>; Mon, 12 Dec 2005 13:34:05 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=t1v/0hYabmjPKtBVNoXhBs37j7dSeWDLUMCJk8dmPkUc+uR/yGiFI9zIGBMYHWPMfDR+5WK4eVXiOGcg6ZhdDWATku+Fe42uyATsXoxx97i3mzr82CiOdZPZzNZBdE0dBmUFOuuIBsFgw8IL7t0LA7g8NsfZRkaRezpzREVHX8o=
Received: by 10.70.46.17 with SMTP id t17mr9861914wxt;
        Mon, 12 Dec 2005 13:34:03 -0800 (PST)
Received: by 10.70.30.10 with HTTP; Mon, 12 Dec 2005 13:34:03 -0800 (PST)
Message-ID: <ecb4efd10512121334g6713d30ftf5a351fc61f1b6bd@mail.gmail.com>
Date:	Mon, 12 Dec 2005 16:34:03 -0500
From:	Clem Taylor <clem.taylor@gmail.com>
To:	linux-mips@linux-mips.org
Subject: mprotect(PROT_NONE) doesn't prevent reading/writing on 2.6.14 Au1550
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_20475_3385653.1134423243152"
Return-Path: <clem.taylor@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9660
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: clem.taylor@gmail.com
Precedence: bulk
X-list: linux-mips

------=_Part_20475_3385653.1134423243152
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

It seems that mprotect(PROT_NONE) isn't actually doing anything on my
2.6.14 au1550 system.

Attached is a simple test that allocates 64K (64K aligned),
reads/writes the buffer, mprotect(PROT_NONE) the buffer and then
attempts to read and write to the buffer a second time. I expected
that writing to a PROT_NONE page would result in a segfault, but on
the Au1550 the program runs without faulting. Running the same code on
x86 (2.6.13) segfaults as expected.

Is there some reason why mprotect() wouldn't work on the Au1550, or is
this a bug?

                                         Thanks,
                                         Clem Taylor

------=_Part_20475_3385653.1134423243152
Content-Type: text/x-csrc; name=mprotectTest.c; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="mprotectTest.c"

#include <stdio.h>
#include <stdlib.h>
#include <malloc.h>
#include <sys/mman.h>
#include <string.h>
#include <errno.h>

int main ( int argc, char *argv [ ] )
{
    int size = 65536, i, ret;
    unsigned char *buffer;

    /* allocate 64K, 64K aligned */
    buffer = memalign ( size, size );
    if ( buffer == NULL )
    {
        fprintf ( stderr, "memalign() failed.\n" );
        return 1;
    }

    fprintf ( stderr, "buffer=%p size=%d\n", buffer, size );

    /* write and read buffer */
    memset ( buffer, 0xAA, size );
    for ( i = 0; i < 2; i++ )
        fprintf ( stderr, "buffer [ %d ] = 0x%02X\n", i, buffer [ i ] );

    /* disable reading and writing */
    ret = mprotect ( buffer, size, PROT_NONE );
    if ( ret != 0 )
    {
        fprintf ( stderr, "mprotect(%p,%d,PROT_NONE) failed: %s\n",
            buffer, size, strerror ( errno ) );
        return 1;
    }

    /* write buffer, should segfault */
    memset ( buffer, 0x55, size );

    /* read buffer, should segfault */
    for ( i = 0; i < 2; i++ )
        fprintf ( stderr, "buffer [ %d ] = 0x%02X\n", i, buffer [ i ] );

    return 0;
}


------=_Part_20475_3385653.1134423243152--
