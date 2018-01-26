Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Jan 2018 15:38:02 +0100 (CET)
Received: from smtp.codeaurora.org ([198.145.29.96]:47314 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992827AbeAZOhxt9DfD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 26 Jan 2018 15:37:53 +0100
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8BF236028B; Fri, 26 Jan 2018 14:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1516977469;
        bh=IFP9nAQcQxraSnjOoaAeaOntH6Pu8Y02xRzlF4/1QEg=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=JFmyn6hDKlfsj563KeUYNrGs5zDSjoH+5gCw+Mv+RMdOaQHfnzJYpudFJ13auv2/S
         Qtb/OGXpS2A5HHc2IsEXtzDnBssC+a56lvpWZH6yvDugAysuX7zybt0PlNUDzIe6fS
         Z55sPOmupKUo+6VLJv7K6RPI3PZMKlU4XKwAUnQE=
Received: from potku.adurom.net (88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BA76F6028B;
        Fri, 26 Jan 2018 14:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1516977468;
        bh=IFP9nAQcQxraSnjOoaAeaOntH6Pu8Y02xRzlF4/1QEg=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Q9kJNTR9n2QmB8sCb0UdZ2VP3I313nJPZKCyrp/Qu52j57Soczybfl2YysbOt467X
         CWV71vChxVQmd5jTJevogigFKZ4IdK2OWfcQF4WVl5PU9c1vFdsxGVzjohITmEBz0M
         +LmIsj26/Ef56/PzQh5/MOzPRXuojpMg2iXsmULA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BA76F6028B
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
Date:   Fri, 26 Jan 2018 16:37:44 +0200
In-Reply-To: <20180126100902.GN5446@saruman> (James Hogan's message of "Fri,
        26 Jan 2018 10:09:03 +0000")
Message-ID: <87fu6su1mv.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <kvalo@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62338
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

James Hogan <jhogan@kernel.org> writes:

> On Fri, Jan 26, 2018 at 10:38:01AM +0100, Sven Joachim wrote:
>> After upgrading an old laptop to 4.15-rc9, I found that the eth0 and
>> wlan0 interfaces had disappeared.  It turns out that the b43 and b44
>> drivers require SSB_PCIHOST_POSSIBLE which depends on
>> PCI_DRIVERS_LEGACY, a config option that only exists on Mips.
>> 
>> Fixes: 58eae1416b80 ("ssb: Disable PCI host for PCI_DRIVERS_GENERIC")
>> Cc: stable@vger.org
>> Signed-off-by: Sven Joachim <svenjoac@gmx.de>
>
> Whoops, thats a very good point. I hadn't twigged that
> PCI_DRIVERS_LEGACY was MIPS specific (one of the disadvantages of using
> "tig grep" I suppose!).
>
> Reviewed-by: James Hogan <jhogan@kernel.org>
>
> I think this is obviously correct, so it'd be great to squeeze it into
> 4.15 final.

I'm not sure if I'm able to get it to 4.15 as it has go via the net
tree, and we have only two days before the (likely) final release, but
I'll try.

-- 
Kalle Valo
