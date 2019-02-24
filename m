Return-Path: <SRS0=K/c0=Q7=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF57DC43381
	for <linux-mips@archiver.kernel.org>; Sun, 24 Feb 2019 04:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F7EF206B6
	for <linux-mips@archiver.kernel.org>; Sun, 24 Feb 2019 04:56:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbfBXE4c convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@archiver.kernel.org>);
        Sat, 23 Feb 2019 23:56:32 -0500
Received: from linux-libre.fsfla.org ([209.51.188.54]:38788 "EHLO
        linux-libre.fsfla.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727689AbfBXE4c (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Sat, 23 Feb 2019 23:56:32 -0500
Received: from free.home (home.lxoliva.fsfla.org [172.31.160.164])
        by linux-libre.fsfla.org (8.15.2/8.15.2/Debian-3) with ESMTP id x1O4u3Ua003292;
        Sun, 24 Feb 2019 04:56:04 GMT
Received: from livre (livre.home [172.31.160.2])
        by free.home (8.15.2/8.15.2) with ESMTP id x1O4tWHt477343;
        Sun, 24 Feb 2019 01:55:32 -0300
From:   Alexandre Oliva <lxoliva@fsfla.org>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     Tom Li <tomli@tomli.me>, Aaro Koskinen <aaro.koskinen@iki.fi>,
        James Hogan <jhogan@kernel.org>,
        Huacai Chen <chenhc@lemote.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@vger.kernel.org
Subject: Re: CS5536 Spurious Interrupt Problem on Loongson2
Organization: Free thinker, not speaking for FSF Latin America
References: <ora7in8tfs.fsf@lxoliva.fsfla.org>
        <20190223015650.GA8616@localhost.localdomain>
        <e57f51ad-4065-b652-ef0e-d93b084d938f@flygoat.com>
Date:   Sun, 24 Feb 2019 01:55:32 -0300
In-Reply-To: <e57f51ad-4065-b652-ef0e-d93b084d938f@flygoat.com> (Jiaxun Yang's
        message of "Sat, 23 Feb 2019 14:08:38 +0800")
Message-ID: <orpnrh7pkr.fsf@lxoliva.fsfla.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Scanned-By: MIMEDefang 2.84
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On Feb 23, 2019, Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:

> Check "env" variables in PMON shell. There night be some information
> such as version or build date.

Ah, yes, thanks.

EC PQ1D28, PMON LM8089-1.4.5 built on Aug 10, 2009.

-- 
Alexandre Oliva, freedom fighter   https://FSFLA.org/blogs/lxo
Be the change, be Free!         FSF Latin America board member
GNU Toolchain Engineer                Free Software Evangelist
Hay que enGNUrecerse, pero sin perder la terGNUra jamás-GNUChe
