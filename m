Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Jan 2010 08:13:23 +0100 (CET)
Received: from mail-px0-f181.google.com ([209.85.216.181]:40087 "EHLO
        mail-px0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491167Ab0AFHNU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 6 Jan 2010 08:13:20 +0100
Received: by pxi11 with SMTP id 11so12845954pxi.22
        for <linux-mips@linux-mips.org>; Tue, 05 Jan 2010 23:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=/Ul6QQe0Yo/v08x66dWTY9rTODWabfeu7xcstXfqqNI=;
        b=fUUBPSnBucV04tktxUMs799X67TWTJaZFNIbt2kXyrUosDMEk3j6wgNF+FaArYW6ZI
         he1NviGHORFfmepNkx7AhTE9M+AnvhV4IKRPNgjCYGY84vb9Whu8MAxziJOuHriP8ha0
         9BTERYnn941PxrcKKMRsSKylptzFzagYGUYRY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=imIo6NaN0e5ZAf+rJLhNtBWKwxJ/dizkdrn9unmsN6e7F/Xt3GkOR4a/YSrMBQgTlP
         8Xt4j9/pr2ym1adnk4kYk7/mnYopG4sEPLnDyF0FN9Djei/cM934AFnKbqF2Uak4N8V9
         05h1DxdBEM0LZJgiIiaTYPZiB3XEhjEzEovoY=
MIME-Version: 1.0
Received: by 10.143.129.7 with SMTP id g7mr8905486wfn.336.1262761991571; Tue, 
        05 Jan 2010 23:13:11 -0800 (PST)
Date:   Wed, 6 Jan 2010 15:13:11 +0800
Message-ID: <3a665c761001052313v36bfeb89v37ada6b76e91c271@mail.gmail.com>
Subject: some question about Extended Asm
From:   loody <miloody@gmail.com>
To:     Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 25519
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: miloody@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                
X-UID: 3908

Dear all:
I write an assembly in c at the end of letter.
I try to
  "or %0, count\n", where count is $a1.
so I write %1 as count and write
  "or %0, %1\n" and assign %1 as count in input section.

But the result is not what I expect.
the result is "   or      v1,v1,v0"
Did I miss something or the only way to meet what I need is directly write
 "or %0, $a1\n"?
appreciate your help,
miloody

void cpuperformanceEvent11_initial(unsigned int mode,unsigned count)
{
bf0106d8:       27bdfff0        addiu   sp,sp,-16
bf0106dc:       afbe0008        sw      s8,8(sp)
bf0106e0:       03a0f021        move    s8,sp
bf0106e4:       afc40010        sw      a0,16(s8)
bf0106e8:       afc50014        sw      a1,20(s8)
        unsigned int temp;
        asm(
bf0106ec:       8fc30010        lw      v1,16(s8)
bf0106f0:       8fc20014        lw      v0,20(s8)
bf0106f4:       4003c801        mfc0    v1,c0_perfcnt,1
bf0106f8:       00621825        or      v1,v1,v0
bf0106fc:       4083c801        mtc0    v1,c0_perfcnt,1
                "mfc0 %0, $25, 1\n"
                "or %0, %1\n"
                "mtc0 %0, $25, 1\n"
                :
                :"r" (mode), "r" (count)
        );
}


void cpuperformanceEvent0_initial(unsigned int mode,unsigned count)
{
	unsigned int temp;
	asm(
		"mfc0 %0, $25, 1\n"
		"or %0, %1\n"
		"mtc0 %0, $25, 1\n"
		:
		:"r" (mode), "r" (count)
	);
}
