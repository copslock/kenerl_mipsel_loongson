Return-Path: <SRS0=tVub=Q5=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9410DC43381
	for <linux-mips@archiver.kernel.org>; Fri, 22 Feb 2019 14:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53C092075A
	for <linux-mips@archiver.kernel.org>; Fri, 22 Feb 2019 14:37:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tomli.me header.i=@tomli.me header.b="IoClFL/k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbfBVOhY (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 22 Feb 2019 09:37:24 -0500
Received: from tomli.me ([153.92.126.73]:38290 "EHLO tomli.me"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbfBVOhX (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Fri, 22 Feb 2019 09:37:23 -0500
Received: from tomli.me (localhost [127.0.0.1])
        by tomli.me (OpenSMTPD) with ESMTP id 51fe32ac;
        Fri, 22 Feb 2019 14:37:21 +0000 (UTC)
X-HELO: localhost.localdomain
Authentication-Results: tomli.me; auth=pass (login) smtp.auth=tomli
Received: from Unknown (HELO localhost.localdomain) (2402:f000:1:1501:200:5efe:3d30:359c)
 by tomli.me (qpsmtpd/0.95) with ESMTPSA (DHE-RSA-CHACHA20-POLY1305 encrypted); Fri, 22 Feb 2019 14:37:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=tomli.me; h=date:from:to:cc:subject:message-id:mime-version:content-type; s=1490979754; bh=dg0pcYbfSuhhY539fhwtCF4QPHYdIyAEnTyHaw0JNkI=; b=IoClFL/kFo468GCGuYMlGZCJJCkq9poQJNVzq2U84wRDzURpKnz8l6+z26a+WZJByuD/15CqK4/hi2UuELnuIMSAMZmGvTaauov0jgPElxCW/7UdjXPNdX6VhC2js/mLqJ9Bv+5r3iMmHvmzZ6B5Intc6f7VddrAp/npVH0KEM60kbazcasrOdzlJeiPNOjNxj6Sfy2N8qUeLz1odTIzmXqBzh5di93BRBbuHDwMfwKYIpNNcjDZaZH8j/ZMYG22/rFSZFSY2TjDSfIQx3ctbufRRXsTMzSLXcr9iv/1KDbyjGDLkQviRO9Of9LiLoKUwfbu0NRpsZFupE/Cchvr6w==
Date:   Fri, 22 Feb 2019 22:37:11 +0800
From:   Tom Li <tomli@tomli.me>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>, Tom Li <tomli@tomli.me>
Cc:     James Hogan <jhogan@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhc@lemote.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@vger.kernel.org
Subject: CS5536 Spurious Interrupt Problem on Loongson2
Message-ID: <20190222143710.GA8504@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Hi all,

During the discussion of Loongson/Yeeloong driver mainlining, both
Alexandre Oliva and Aaro Koskinen reported the their Loongson machine
is being bombarded by spurious interrupt from CS5536 when using the
libata driver. Continue replying the original thread is off-topic and
difficult to follow, so here I start a new thread for this problem.

On Sun, Feb 17, 2019 at 01:59:26AM -0300, Alexandre Oliva wrote:
> Tom, why do you say bisecting this is impossible?  I realize you wrote
> you did so for 24 hours non-stop, but...  I'm curious as to what
> obstacles you ran into.  It's such a reproducible problem for me that I
> can't see how bisecting it might be difficult.
> 
> Or were by any chance you talking about the reboot/shutdown problem
> then?

I meant the already-identified and fixed reboot/shutdown problem, not the
CS3356 spurious interrupt problem.

To be honest, I don't understand why the libata driver can even be a problem
at all. To add some background information,  I started using the libata driver
since 2014, and to this day, I NEVER encountered any problem with it. And not
only me, I had a personal project - a prebuilt kernel for Yeeloong laptops,
and at least three different users had tried it. In addition, Jiaxun Yang also
who did some independent work - none of these people have reported any problem
similar to this one.

Therefore, I'm suspicious that this problem is related to a specific firmware/
hardware revision, or a probabilistic issue. PMON/EC version may be the first
thing we need to confirm.

My system is,

$ cat /proc/cmdline
PMON_VER=LM8089-1.4.9a EC_VER=PQ1D28 machtype=lemote-yeeloong-2f-8.9inches

$ cat /proc/interrupts 
           CPU0       
  1:         11    XT-PIC   1  i8042
  2:          0    XT-PIC   2  cascade
  8:          0    XT-PIC   8  rtc0
  9:          0    XT-PIC   9  snd_cs5535audio
 10:          0    XT-PIC  10  sci
 12:         87    XT-PIC  12  i8042
 14:       6418    XT-PIC  14  pata_cs5536
 18:          0      MIPS   2  cascade
 22:          0      MIPS   6  cascade
 23:     148498      MIPS   7  timer
 37:        296  bonito_irq      eth0
ERR:          0

Interrupts have no problem at all.

(P.S: Interrupt 10, sci, is the platform driver I'm developing, just ignore it)

Thus, I don't see any CS5536 interrupt problem when using the libata driver.
My first question is, what are your EC/PMON versions? can you report back?

Thanks,
Tom Li
