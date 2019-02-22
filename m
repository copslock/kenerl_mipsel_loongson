Return-Path: <SRS0=tVub=Q5=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=FAKE_REPLY_C,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3383C43381
	for <linux-mips@archiver.kernel.org>; Fri, 22 Feb 2019 20:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E00A2081B
	for <linux-mips@archiver.kernel.org>; Fri, 22 Feb 2019 20:23:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725990AbfBVUXG convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 22 Feb 2019 15:23:06 -0500
Received: from linux-libre.fsfla.org ([209.51.188.54]:36264 "EHLO
        linux-libre.fsfla.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbfBVUXG (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Fri, 22 Feb 2019 15:23:06 -0500
Received: from free.home (home.lxoliva.fsfla.org [172.31.160.164])
        by linux-libre.fsfla.org (8.15.2/8.15.2/Debian-3) with ESMTP id x1MKMZOU010366;
        Fri, 22 Feb 2019 20:22:36 GMT
Received: from livre (livre.home [172.31.160.2])
        by free.home (8.15.2/8.15.2) with ESMTP id x1MKMFHs349781;
        Fri, 22 Feb 2019 17:22:15 -0300
From:   Alexandre Oliva <lxoliva@fsfla.org>
To:     Tom Li <tomli@tomli.me>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        James Hogan <jhogan@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhc@lemote.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@vger.kernel.org
Subject: Re: CS5536 Spurious Interrupt Problem on Loongson2
Organization: Free thinker, not speaking for FSF Latin America
Date:   Fri, 22 Feb 2019 17:22:15 -0300
In-Reply-To: Tom Li's message of "Fri\, 22 Feb 2019 22\:37\:11 +0800"
Message-ID: <ora7in8tfs.fsf@lxoliva.fsfla.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Scanned-By: MIMEDefang 2.84
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On Feb 22, 2019, Tom Li <tomli@tomli.me> wrote:

> I meant the already-identified and fixed reboot/shutdown problem, not the
> CS3356 spurious interrupt problem.

Aha.

> To be honest, I don't understand why the libata driver can even be a problem
> at all. To add some background information,  I started using the libata driver
> since 2014, and to this day, I NEVER encountered any problem with it.

I have had occasional IRQ 14 issues over the years, but they were not
common, and they'd hit while using the system.  After 4.20, they seem to
deterministically hit very early during boot-up.

> Therefore, I'm suspicious that this problem is related to a specific firmware/
> hardware revision

That's possible.  Another possibility is that it is related with the
hard drive models connected to the controller.  What suggested this to
me was the quirks code in the old, non-libata driver, that recognized
specific hard drive models, one of which matches the drive I have on my
yeeloong.

$ hdparm -i /dev/sda
[...]
 Model=FUJITSU MHZ2160BH G2, FwRev=00000009, SerialNo=[...]


> $ cat /proc/cmdline

I don't have the PMON or EC versions in /proc/cmdline.  machtype is the same.

'vers' in the pmon text prompt responds: PMON2000 2.1 (Bonito) #291

> $ cat /proc/interrupts 

Differences (running 4.19) are IRQ 5, and USBs on 11 (XT) and 39 (bonito).

> (P.S: Interrupt 10, sci, is the platform driver I'm developing, just ignore it)

Err, should I be worried that I have that too?

-- 
Alexandre Oliva, freedom fighter   https://FSFLA.org/blogs/lxo
Be the change, be Free!         FSF Latin America board member
GNU Toolchain Engineer                Free Software Evangelist
Hay que enGNUrecerse, pero sin perder la terGNUra jamás-GNUChe
