Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 May 2013 19:20:08 +0200 (CEST)
Received: from mail-out.m-online.net ([212.18.0.10]:48808 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823124Ab3EFRUBJZ1Ac (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 6 May 2013 19:20:01 +0200
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
        by mail-out.m-online.net (Postfix) with ESMTP id 3b49gK1VqFz3hhgD;
        Mon,  6 May 2013 19:19:57 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
        by mail.m-online.net (Postfix) with ESMTP id 3b49gK0Q51zbc0G;
        Mon,  6 May 2013 19:19:57 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
        by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
        with ESMTP id 0c_V_GurtuI9; Mon,  6 May 2013 19:19:55 +0200 (CEST)
X-Auth-Info: FPNL7TgVaYNzYOAKngKM1eFO/hBHJGk/cu81lMBp3kk=
Received: from hase.home (ppp-88-217-97-84.dynamic.mnet-online.de [88.217.97.84])
        by mail.mnet-online.de (Postfix) with ESMTPA;
        Mon,  6 May 2013 19:19:55 +0200 (CEST)
Received: by hase.home (Postfix, from userid 1000)
        id 2A21210526B; Mon,  6 May 2013 19:19:54 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linux-arch@vger.kernel.org
Subject: Re: Build errors caused by modalias generation patch
References: <20130506160253.GA27181@linux-mips.org>
X-Yow:  The Osmonds!  You are all Osmonds!!  Throwing up on a freeway at dawn!!!
Date:   Mon, 06 May 2013 19:19:53 +0200
In-Reply-To: <20130506160253.GA27181@linux-mips.org> (Ralf Baechle's message
        of "Mon, 6 May 2013 18:02:54 +0200")
Message-ID: <87mws8m3eu.fsf@hase.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <whitebox@nefkom.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36329
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: schwab@linux-m68k.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Please try the patch in
<http://marc.info/?l=linux-kbuild&m=136767800809256&w=2>.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
