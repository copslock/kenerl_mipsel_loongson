Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Feb 2003 14:39:11 +0000 (GMT)
Received: from t111.niisi.ras.ru ([IPv6:::ffff:193.232.173.111]:15426 "EHLO
	t111.niisi.ras.ru") by linux-mips.org with ESMTP
	id <S8225209AbTBGOjK>; Fri, 7 Feb 2003 14:39:10 +0000
Received: from t06.niisi.ras.ru (t06.niisi.ras.ru [193.232.173.6])
	by t111.niisi.ras.ru (8.9.1/8.9.1) with ESMTP id RAA29876
	for <linux-mips@linux-mips.org>; Fri, 7 Feb 2003 17:39:19 +0300
Received: (from uucp@localhost) by t06.niisi.ras.ru (8.7.6/8.7.3) with UUCP id RAA22448 for linux-mips@linux-mips.org; Fri, 7 Feb 2003 17:41:33 +0300
Received: from niisi.msk.ru (t34 [193.232.173.34])
	by niisi.msk.ru (8.12.5/8.12.5) with ESMTP id h17ELqxl009762
	for <linux-mips@linux-mips.org>; Fri, 7 Feb 2003 17:21:53 +0300 (MSK)
Message-ID: <3E43ECC6.8090109@niisi.msk.ru>
Date: Fri, 07 Feb 2003 17:28:38 +0000
From: Alexandr Andreev <andreev@niisi.msk.ru>
Organization: niisi
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
X-Accept-Language: ru, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: Endianity problems in XFree86-4.2 XAA on MIPSEB
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <andreev@niisi.msk.ru>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1362
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andreev@niisi.msk.ru
Precedence: bulk
X-list: linux-mips

We have a MipsEB machine and a video card which has a 2D BitBLT engine.
It looks like we found a problem in XAA when we tried to use our hardware
8x8 Mono Pattern Fills. The problem appears when an application uses 
pixmaps.
Stipple and tile with the same pixmap are drawing in the different ways
(bytes in video memory are swapped). We looked through the XAA source tree
and found a dubious code in xaaPCache.c.

In two words... XAA tries to check that a pixmap (stipple/tile) can be 
reduced
to a 8x8 mono pattern, and if so, puts this stipple/tile to two dwords and
passes it to hw driver. And it looks like the stipple code works fine, 
but there
is an endianity problem in the "tile" case:

Bool
XAACheckStippleReducibility(PixmapPtr pPixmap)
{
...
pPriv->pattern0 = bits[0] | SHIFT_L(bits[1],8) | SHIFT_L(bits[2],16) | 
SHIFT_L(bits[3],24);
pPriv->pattern1 = bits[4] | SHIFT_L(bits[5],8) | SHIFT_L(bits[6],16) | 
SHIFT_L(bits[7],24);
...
}
where SHIFT_L(value, shift) is defined as ((value) >> (shift)) for Big 
Endian.


Bool
XAACheckTileReducibility(PixmapPtr pPixmap, Bool checkMono)
{
...
pPriv->pattern0 = bits[0] | (bits[1]<<8) | (bits[2]<<16) | (bits[3]<<24);
pPriv->pattern1 = bits[4] | (bits[5]<<8) | (bits[6]<<16) | (bits[7]<<24);
...
}

In both cases the unsigned int bits[] array contains bytes! with the 
bitmask to be
passed to a driver via pPriv->pattern0, pPriv->pattern1.

When we tried to use the fbdev driver which is not using XAA, the problem
is gone.

Did anybody see something similar on Mips EB with XFree + XAA?
