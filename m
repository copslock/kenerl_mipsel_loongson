Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 19 May 2007 08:35:34 +0100 (BST)
Received: from mail1.pearl-online.net ([62.159.194.147]:36414 "EHLO
	mail1.pearl-online.net") by ftp.linux-mips.org with ESMTP
	id S20022780AbXESHfc (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 19 May 2007 08:35:32 +0100
Received: from SNaIlmail.Peter (77.47.4.25.static.cablesurf.de [77.47.4.25])
	by mail1.pearl-online.net (Postfix) with ESMTP id C9BC5BC7D;
	Sat, 19 May 2007 09:35:24 +0200 (CEST)
Received: from Indigo2.Peter (Indigo2.Peter [192.168.1.28])
	by SNaIlmail.Peter (8.12.6/8.12.6/Sendmail/Linux 2.0.32) with ESMTP id l4J7aGgP000681;
	Sat, 19 May 2007 09:36:17 +0200
Received: from Indigo2.Peter (localhost [127.0.0.1])
	by Indigo2.Peter (8.12.6/8.12.6/Sendmail/Linux 2.6.14-rc2-ip28) with ESMTP id l4J7XeZ9000192;
	Sat, 19 May 2007 09:33:41 +0200
Received: from localhost (pf@localhost)
	by Indigo2.Peter (8.12.6/8.12.6/Submit) with ESMTP id l4J7XeP2000189;
	Sat, 19 May 2007 09:33:40 +0200
X-Authentication-Warning: Indigo2.Peter: pf owned process doing -bs
Date:	Sat, 19 May 2007 09:33:40 +0200 (CEST)
From:	peter fuerst <post@pfrst.de>
X-X-Sender: pf@Indigo2.Peter
Reply-To: post@pfrst.de
To:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: R1000 status
In-Reply-To: <49027.193.253.35.188.1179557496.squirrel@eppesuigoccas.homedns.org>
Message-ID: <Pine.LNX.4.58.0705190928580.182@Indigo2.Peter>
References: <49027.193.253.35.188.1179557496.squirrel@eppesuigoccas.homedns.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <post@pfrst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15085
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: post@pfrst.de
Precedence: bulk
X-list: linux-mips



Hello,

yes, the GCC-patches should do the trick. And without a significant
performance decrease, as i was told in the latest success-report (see
http://sgi.sedlacek.biz/).

kind regards


On Sat, 19 May 2007, Giuseppe Sacco wrote:

> Date: Sat, 19 May 2007 08:51:36 +0200 (CEST)
> From: Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>
> To: linux-mips@linux-mips.org
> Subject: R1000 status
>
> Hi all,
> reading many web pages I think to understand that R10000 is supported on
> IP22 systems and is unsupported on IP32 systems because of its cache.
>
> The page http://www.linux-mips.org/wiki/Silicon_Graphics display a
> different result: R10000 on SIGG O2 is supported.
>
> Is there any news or a list of known problems?
>
> Thanks,
> Giuseppe
>
>
>
>
