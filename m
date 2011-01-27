Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Jan 2011 10:20:49 +0100 (CET)
Received: from mail-iy0-f177.google.com ([209.85.210.177]:49518 "EHLO
        mail-iy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490978Ab1A0JUq convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 27 Jan 2011 10:20:46 +0100
Received: by iyj21 with SMTP id 21so1306301iyj.36
        for <linux-mips@linux-mips.org>; Thu, 27 Jan 2011 01:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:content-type:content-transfer-encoding;
        bh=TkTHUXog/ig/W7p4uLTH7hjlEO4m2gF6ZFxQv/bArqs=;
        b=Iu+BcSR8vdc96hcoUwvroT5GLXAH+qAI0FqtAnLVUAYxjmrDBHR33rLxfYq8+gzJSz
         gn5zCXvi612oVPQ/6rMsLV44u8pRagRexBvaoh5YP6Zq7kaCrsfD3sfHqKrgThhlCjwK
         Nc6BZsbAy7RcsBPt21LNkbMyKjeT4nZkuL8LA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=iC9Z1awZPJRM7/jBDHRAgG+JvD93/9bW38/RNu2iS4qMBZFVA52XuMqjpVh0SqI00j
         EL1RqYI6crwF4VAdPaR2S8pBB/JdJjGUe/6qUQCunAwHQkvBWxDT55EdbhvGT5l3LVzh
         yLCkOUvjeW0rt00A+2Or1DhnNtM5Hh/IuW0kc=
MIME-Version: 1.0
Received: by 10.42.228.68 with SMTP id jd4mr1779403icb.499.1296120039057; Thu,
 27 Jan 2011 01:20:39 -0800 (PST)
Received: by 10.42.195.199 with HTTP; Thu, 27 Jan 2011 01:20:39 -0800 (PST)
In-Reply-To: <AANLkTim_swh58fCUxZ4e6MDrM9Lqrbm+1ufnp8W767JL@mail.gmail.com>
References: <AANLkTinvdEPwQ=DmcF8nnTAa0Py_O=+p7x1pobcTNHom@mail.gmail.com>
        <AANLkTik8hQfd8cvNj=qeq5U=6zpQHw33a9hfK-q8+x1Z@mail.gmail.com>
        <AANLkTikpUBtg2zz8tcbcz2rcG-O+fTFwb_pTi88uZe0h@mail.gmail.com>
        <AANLkTi=zfr5YuwBCcvH2Jas50UxnUtvzp_CDyN25sT5h@mail.gmail.com>
        <AANLkTim_swh58fCUxZ4e6MDrM9Lqrbm+1ufnp8W767JL@mail.gmail.com>
Date:   Thu, 27 Jan 2011 17:20:39 +0800
Message-ID: <AANLkTim+Dy1_MFoMcXK3aPCKUcz6hpJY7B5kKY_nXNnP@mail.gmail.com>
Subject: Fwd: about udelay in mips
From:   loody <miloody@gmail.com>
To:     gcc-help <gcc-help@gcc.gnu.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <miloody@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29093
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: miloody@gmail.com
Precedence: bulk
X-list: linux-mips

hi all:
I guess there seems be some differences about
"unsigned long long" and "ull" so I forward the letter to gcc-help.
If my guess is correct, what are the differences between them and why
"unsigned long long" cannot let compiler compile the 64-bits
operations as I want?
thanks a lot,
miloody

I found my kernel will compile udelay(xx) as zero no matter what xx I filled in.
below are the dis-assemblies:
(as you can see the v0 = v1 = zero.)
My version is 2.6.30.9:
void __udelay(unsigned long us)
{
       unsigned int lpj = current_cpu_data.udelay_val;

       __delay(((unsigned long long)(us * 0x000010c7 * HZ * lpj)) >> 32);
80306ed0:       00001821        move    v1,zero
80306ed4:       00601021        move    v0,v1
#include <asm/compiler.h>
#include <asm/war.h>

inline void __delay(unsigned int loops)
{
       __asm__ __volatile__ (
80306ed8:       1440ffff        bnez    v0,80306ed8 <__udelay+0x8>
80306edc:       2442ffff        addiu   v0,v0,-1
void __udelay(unsigned long us)

I have double checked the __delay source code of 2.6.33.4
and the dis-assemblies:

void __udelay(unsigned long us)
{
       unsigned int lpj = current_cpu_data.udelay_val;

       __delay((us * 0x000010c7ull * HZ * lpj) >> 32);
802f7310:       3c02804f        lui     v0,0x804f
802f7314:       8c429360        lw      v0,-27808(v0)
802f7318:       3c050010        lui     a1,0x10
802f731c:       34a56256        ori     a1,a1,0x6256
802f7320:       00450019        multu   v0,a1
802f7324:       00002821        move    a1,zero
802f7328:       00001012        mflo    v0
802f732c:       00001810        mfhi    v1
802f7330:       00a20018        mult    a1,v0
802f7334:       70640000        madd    v1,a0
802f7338:       00003012        mflo    a2
802f733c:       00440019        multu   v0,a0
802f7340:       00001810        mfhi    v1
802f7344:       00c31021        addu    v0,a2,v1
#include <asm/compiler.h>
#include <asm/war.h>

inline void __delay(unsigned int loops)
{
       __asm__ __volatile__ (
802f7348:       1440ffff        bnez    v0,802f7348 <__udelay+0x38>
802f734c:       2442ffff        addiu   v0,v0,-1
void __udelay(unsigned long us)
{
       unsigned int lpj = current_cpu_data.udelay_val;

       __delay((us * 0x000010c7ull * HZ * lpj) >> 32);
}
802f7350:       03e00008        jr      ra
