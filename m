Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Dec 2005 21:51:53 +0000 (GMT)
Received: from xproxy.gmail.com ([66.249.82.205]:12899 "EHLO xproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8133595AbVLGVvf (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 7 Dec 2005 21:51:35 +0000
Received: by xproxy.gmail.com with SMTP id s18so317582wxc
        for <linux-mips@linux-mips.org>; Wed, 07 Dec 2005 13:51:24 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=kJUT7fgy6QL+o0K/uSR0FNLHMlmT3Mfvsmfc41BwUGSfypLzPZgmgZ8rB8Mc65c7Pz4urbVQRe0bnNuJVOW3HshhI7dYw4fUJ2ezq/QKALLnfdH+4l6anJ+lRMTc3eE8M6ONcd2IpjPnD6falo8atHEdGO9AyfeX5p9ViNs0lwo=
Received: by 10.70.33.1 with SMTP id g1mr2763615wxg;
        Wed, 07 Dec 2005 13:51:23 -0800 (PST)
Received: by 10.70.30.10 with HTTP; Wed, 7 Dec 2005 13:51:23 -0800 (PST)
Message-ID: <ecb4efd10512071351scea736fg8d026e3fa3c54c79@mail.gmail.com>
Date:	Wed, 7 Dec 2005 16:51:23 -0500
From:	Clem Taylor <clem.taylor@gmail.com>
To:	linux-mips <linux-mips@linux-mips.org>
Subject: can read/write to mprotect(PROT_NONE) region with 2.6.14 on au1550
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_5886_18805544.1133992283905"
Return-Path: <clem.taylor@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9631
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: clem.taylor@gmail.com
Precedence: bulk
X-list: linux-mips

------=_Part_5886_18805544.1133992283905
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

I was trying to use mprotect(PROT_NONE) to help debug a problem, and
it seems that mprotect() isn't actually doing anything with my 2.6.14
linux-mips kernel on an au1550. Attached is a simple test program that
segfaults as expected on x86 (2.6.12), but does not segfault on mips
(2.6.14). I can both read and write PROT_NONE memory without problem,
which should result in a segfault. Originally, I was trying to
mprotect() a mmaped GFP_DMA region which wasn't working and then I
tried a simpler test that also wasn't working.

Shouldn't mprotect() work? Could I be missing a config option, or is
this just broken?

                               Thanks,
                               Clem Taylor

------=_Part_5886_18805544.1133992283905
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

    /* write and read buffer, should segfault */
    memset ( buffer, 0x55, size );
    for ( i = 0; i < 2; i++ )
        fprintf ( stderr, "buffer [ %d ] = 0x%02X\n", i, buffer [ i ] );

    return 0;
}









------=_Part_5886_18805544.1133992283905--
