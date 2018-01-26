Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Jan 2018 18:02:08 +0100 (CET)
Received: from smtp.codeaurora.org ([198.145.29.96]:55566 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991066AbeAZRCAv7EVC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 26 Jan 2018 18:02:00 +0100
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 62AD760A5F; Fri, 26 Jan 2018 17:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1516986114;
        bh=P9Q7JoUscm/qlo56fogiL3dIptqCqSb8248Ml7yFR9Y=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=VqTgsaZH50Sl7oZwYPxysmD2Vc3QNE3bY6DoFTpv9uUa//ZV4aGvRloa4tJGySy9k
         CaU/qmZqiG/9PNR3ryrhNJLjYO1K8Vv9P0tZSzUIhcH7dRexefUvqPUz38V1wzgCyK
         khtCR2n1KIsL0TqCpnlGXMXGIZ/ptwqT59voWjXI=
Received: from purkki.adurom.net (purkki.adurom.net [80.68.90.206])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0EF686032C;
        Fri, 26 Jan 2018 17:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1516986113;
        bh=P9Q7JoUscm/qlo56fogiL3dIptqCqSb8248Ml7yFR9Y=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=jSLlsOt3a2pfElVTB7IrgI8L+HDZMnGEdt5+yvguDzbnBW2SCUHB6Z1SC4YHEvV37
         FSEm098hXrmMNLCCzZnjmZXf4kOGN0Nb0f3nar3jksTJ1X9+c8iaTnRXmqu0pbp+3e
         Qau7xtDs2dXXayhkKwFDNStyaGiF607r0vu149eA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0EF686032C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     James Hogan <jhogan@kernel.org>
Cc:     Sven Joachim <svenjoac@gmx.de>, Michael Buesch <m@bues.ch>,
        linux-wireless@vger.kernel.org, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] ssb: Do not disable PCI host on non-Mips
References: <87vafpq7t2.fsf@turtle.gmx.de> <20180126100902.GN5446@saruman>
        <87fu6su1mv.fsf@kamboji.qca.qualcomm.com>
Date:   Fri, 26 Jan 2018 19:01:49 +0200
In-Reply-To: <87fu6su1mv.fsf@kamboji.qca.qualcomm.com> (Kalle Valo's message
        of "Fri, 26 Jan 2018 16:37:44 +0200")
Message-ID: <87tvv8r1tu.fsf@purkki.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <kvalo@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62340
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kvalo@codeaurora.org
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

Kalle Valo <kvalo@codeaurora.org> writes:

> James Hogan <jhogan@kernel.org> writes:
>
>> On Fri, Jan 26, 2018 at 10:38:01AM +0100, Sven Joachim wrote:
>>> After upgrading an old laptop to 4.15-rc9, I found that the eth0 and
>>> wlan0 interfaces had disappeared.  It turns out that the b43 and b44
>>> drivers require SSB_PCIHOST_POSSIBLE which depends on
>>> PCI_DRIVERS_LEGACY, a config option that only exists on Mips.
>>> 
>>> Fixes: 58eae1416b80 ("ssb: Disable PCI host for PCI_DRIVERS_GENERIC")
>>> Cc: stable@vger.org
>>> Signed-off-by: Sven Joachim <svenjoac@gmx.de>
>>
>> Whoops, thats a very good point. I hadn't twigged that
>> PCI_DRIVERS_LEGACY was MIPS specific (one of the disadvantages of using
>> "tig grep" I suppose!).
>>
>> Reviewed-by: James Hogan <jhogan@kernel.org>
>>
>> I think this is obviously correct, so it'd be great to squeeze it into
>> 4.15 final.
>
> I'm not sure if I'm able to get it to 4.15 as it has go via the net
> tree, and we have only two days before the (likely) final release, but
> I'll try.

Too late, Dave already sent his last pull request for 4.15. This will be
in 4.16.

-- 
Kalle Valo
