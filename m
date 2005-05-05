Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 May 2005 18:56:37 +0100 (BST)
Received: from p549F4CCC.dip.t-dialin.net ([IPv6:::ffff:84.159.76.204]:56488
	"EHLO p549F4CCC.dip.t-dialin.net") by linux-mips.org with ESMTP
	id <S8225009AbVEER4W>; Thu, 5 May 2005 18:56:22 +0100
Received: from [IPv6:::ffff:62.214.77.149] ([IPv6:::ffff:62.214.77.149]:4458
	"EHLO arbas.nms.ulrich-teichert.org") by linux-mips.net with ESMTP
	id <S868816AbVEER4U>; Thu, 5 May 2005 19:56:20 +0200
Received: from arbas.nms.ulrich-teichert.org (localhost [127.0.0.1])
	by arbas.nms.ulrich-teichert.org (8.12.10/8.12.1) with ESMTP id j45Hu70g021122;
	Thu, 5 May 2005 19:56:07 +0200
Received: (from ut@localhost)
	by arbas.nms.ulrich-teichert.org (8.12.10/8.12.1/Submit) id j45Hu54Y021121;
	Thu, 5 May 2005 19:56:05 +0200
Message-Id: <200505051756.j45Hu54Y021121@arbas.nms.ulrich-teichert.org>
X-Authentication-Warning: arbas.nms.ulrich-teichert.org: ut set sender to krypton using -f
Subject: Re: USB hangs on AU1100
To:	ths@networkno.de (Thiemo Seufer)
Date:	Thu, 5 May 2005 19:56:04 +0200 (MEST)
Cc:	linux-mips@linux-mips.org ('linux-mips@linux-mips.org')
In-Reply-To: <20050505172017.GC1628@hattusa.textio> from "Thiemo Seufer" at May 05, 2005 07:20:17 PM
From:	Ulrich Teichert <krypton@ulrich-teichert.org>
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <krypton@ulrich-teichert.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7864
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: krypton@ulrich-teichert.org
Precedence: bulk
X-list: linux-mips

Hi,

[del]
>I wonder if the code works reliable. At least, a comma operator isn't a
>sequence point, which means the compiler is free to change the execution
>order.

Not accordingly to the C standard, which notes strict left-to-right
execution without reordering for the comma operator.

HTH,
Uli
-- 
Dipl. Inf. Ulrich Teichert|e-mail: Ulrich.Teichert@gmx.de
Stormweg 24               |listening to: Suicide Drive (The Deep Eynde)
24539 Neumuenster, Germany|Public Pervert (Interpol) Cauchemar (Opération S)
