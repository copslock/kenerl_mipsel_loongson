Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Sep 2006 16:25:15 +0100 (BST)
Received: from mail.sysgo.com ([62.8.134.5]:5133 "EHLO mail.sysgo.com")
	by ftp.linux-mips.org with ESMTP id S20038456AbWIKPZN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 11 Sep 2006 16:25:13 +0100
Received: from localhost (localhost [127.0.0.1])
	by mail.sysgo.com (Postfix) with ESMTP id 5FB76CC1C0
	for <linux-mips@linux-mips.org>; Mon, 11 Sep 2006 17:25:07 +0200 (CEST)
Received: from mail.sysgo.com (localhost [127.0.0.1])
	by localhost (AvMailGate-2.0.2-8) id 26031-392B27E7;
	Mon, 11 Sep 2006 17:25:07 +0200
Received: from donald.sysgo.com (unknown [172.20.1.30])
	by mail.sysgo.com (Postfix) with ESMTP id 13A0ECC1BF
	for <linux-mips@linux-mips.org>; Mon, 11 Sep 2006 17:25:07 +0200 (CEST)
Received: by donald.sysgo.com (Postfix, from userid 65534)
	id 7CC5826A66B; Mon, 11 Sep 2006 17:25:07 +0200 (CEST)
Received: from cam (unknown [172.40.1.200])
	by donald.sysgo.com (Postfix) with ESMTP id 714D126A669
	for <linux-mips@linux-mips.org>; Mon, 11 Sep 2006 17:25:06 +0200 (CEST)
From:	Carlos Mitidieri <carlos.mitidieri@sysgo.com>
To:	linux-mips@linux-mips.org
Subject: Re: "Uncompressing Linux at load address"
Date:	Mon, 11 Sep 2006 17:25:11 +0200
User-Agent: KMail/1.8.2
References: <2156B1E923F1A147AABDF4D9FDEAB4CB1727D5@blr-m2-msg.wipro.com>
In-Reply-To: <2156B1E923F1A147AABDF4D9FDEAB4CB1727D5@blr-m2-msg.wipro.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200609111725.12209.carlos.mitidieri@sysgo.com>
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.2-8; AVE: 7.1.1.16; VDF: 6.35.1.213; host: mailgate.sysgo.com)
Return-Path: <carlos.mitidieri@sysgo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12559
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: carlos.mitidieri@sysgo.com
Precedence: bulk
X-list: linux-mips

thanks for commenting
Since my APPRAMBASE in umon is 0xa0300000, I have changed my parametes in a 
way that the kernel would be loaded above that address:

AVAIL_RAM_START=0xb0a00000
AVAIL_RAM_END=0xb0f00000
LOADADDR =0xb0000000

unfortunately, the problem persists, i.e., the systems hangs just after the 
messages:

 zImage: size=680372 base=0xa0300000
loaded at:     A0300000 A03A4000
 zimage at:     A0306180 A03A3EE1
 Uncompressing Linux at load address B0000000

I am pretty sure that the problem relates to where the things are loaded, but 
I don't realize exactly what.



On Monday 11 September 2006 15:55, you wrote:
> I had faced similar issue with AU1100 based boards which also use the
> zImage patch. It turned out to be board initialization issue rather that
> a zImage problem, since after uncompressing the image control is
> transferred to kernel_entry.
>
> Thanks
> Hemanth
>
> -----Original Message-----
> From: linux-mips-bounce@linux-mips.org
> [mailto:linux-mips-bounce@linux-mips.org] On Behalf Of Carlos Mitidieri
> Sent: Monday, September 11, 2006 7:00 PM
> To: linux-mips@linux-mips.org
> Subject: "Uncompressing Linux at load address"
>
> Hi,
>
> I am trying to boot a zImage from micromonitor on a csb655 board
> (Au1550 processor).
>
> For that matter, I patched my kernel 2.6.15 with the zImage_2_6_10.patch
> from
> Popov.
>
> In the arch/mips/boot/compressed/au1xxx/Makefile, I have set:
> 	1) RAM_RUN_ADDR=0xa0300000, which is the value got  from the
> umon's
> APPRAMBASE environment variable.
> 	2) AVAIL_RAM_START=0x80500000
>             AVAIL_RAM_END=0x80900000
>      	3) LOADADDR =0x80100000, which is the same value I have set in
> an
> entry for this board in arch/mips/Makefile.
>
> I can compile and link the zImage with home build gcc cross tools, based
> on
> gcc-3.4.4 and glibc-2.3.4 . When the (binary) zImage is decompressed on
> the
> target, I get these messages:
>
> zImage: size=680372 base=0xa0300000
> loaded at:     A0300000 A03A4000
> zimage at:     A0306180 A03A3EE1
> Uncompressing Linux at load address 80100000
>
> and then the target resets.
> This zImage is very small, so the decompressed image is not going beyond
> the
> AVAIL_RAM limits. Would you have any guess on what is going on?
>
> I have looked for this information the list through, but anyone seems to
> have
> had this problem before. Thanks for any comment.

-- 
Carlos Mitidieri
SYSGO AG - Office Ulm
Lise-Meitner-Str. 15
D-89081 Ulm

Tel: +49 731 94683 16
Fax: +49 731 94683 10
Web: www.sysgo.com

Meet us at our next event:

RTS Embedded Systems 2006
April 4-6, 2006
Paris, La Défense
http://www.birp.com/rts
