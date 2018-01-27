Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 27 Jan 2018 10:09:15 +0100 (CET)
Received: from mail-out.m-online.net ([212.18.0.10]:41053 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990400AbeA0JJHkx0i5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 27 Jan 2018 10:09:07 +0100
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 3zT91s64rQz1qtFB;
        Sat, 27 Jan 2018 10:09:05 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 3zT91s3pCHz1qrDF;
        Sat, 27 Jan 2018 10:09:05 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id Q2fl3NaMPoKr; Sat, 27 Jan 2018 10:09:04 +0100 (CET)
X-Auth-Info: 0PB2jkXWL5NT3aHFyfmHLa4/rQZ6XZNzhuurVA2MNzoXkI1lmM81G+r4zqzX3HEt
Received: from linux.local (ppp-188-174-150-113.dynamic.mnet-online.de [188.174.150.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Sat, 27 Jan 2018 10:09:04 +0100 (CET)
Received: by linux.local (Postfix, from userid 501)
        id B93791E580A; Sat, 27 Jan 2018 10:08:57 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     James Hogan <jhogan@kernel.org>, Michael Buesch <m@bues.ch>,
        linux-wireless@vger.kernel.org, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [for-4.15] ssb: Disable PCI host for PCI_DRIVERS_GENERIC
References: <20180115211714.24009-1-jhogan@kernel.org>
        <20180116191636.6B3E5605A4@smtp.codeaurora.org>
X-Yow:  ANN JILLIAN'S HAIR makes LONI ANDERSON'S HAIR look like
 RICARDO MONTALBAN'S HAIR!
Date:   Sat, 27 Jan 2018 10:08:56 +0100
In-Reply-To: <20180116191636.6B3E5605A4@smtp.codeaurora.org> (Kalle Valo's
        message of "Tue, 16 Jan 2018 19:16:36 +0000 (UTC)")
Message-ID: <m2bmhfsm6v.fsf@linux-m68k.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.0.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <whitebox@nefkom.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62356
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

On Jan 16 2018, Kalle Valo <kvalo@codeaurora.org> wrote:

> 58eae1416b80 ssb: Disable PCI host for PCI_DRIVERS_GENERIC

That breaks wireless on PowerMac!  There is nothing MIPS-specific about
SSB.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
