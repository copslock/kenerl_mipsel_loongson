Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Feb 2016 12:23:56 +0100 (CET)
Received: from mail-out.m-online.net ([212.18.0.10]:52515 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011595AbcBILXiTJO6a (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 9 Feb 2016 12:23:38 +0100
Received: from mail.nefkom.net (unknown [192.168.8.184])
        by mail-out.m-online.net (Postfix) with ESMTP id 3q020V1KRlz3hjYN;
        Tue,  9 Feb 2016 12:23:38 +0100 (CET)
X-Auth-Info: De49d3iFm4JTA81yIq3nNHwkZqXbpR75fcep5kKwj8s=
Received: from chi.localnet (unknown [195.140.253.167])
        (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-auth.mnet-online.de (Postfix) with ESMTPSA id 3q020V02hzzvhTg;
        Tue,  9 Feb 2016 12:23:37 +0100 (CET)
From:   Marek Vasut <marex@denx.de>
To:     Antony Pavlov <antonynpavlov@gmail.com>
Subject: Re: [RFC v5 04/15] WIP: MIPS: ath79: setup.c: disable platform code for OF boards
Date:   Tue, 9 Feb 2016 12:08:32 +0100
User-Agent: KMail/1.13.7 (Linux/3.14-2-amd64; KDE/4.13.1; x86_64; ; )
Cc:     linux-mips@linux-mips.org, Wills Wang <wills.wang@live.com>,
        Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
        Alban Bedel <albeu@free.fr>
References: <1455005641-7079-1-git-send-email-antonynpavlov@gmail.com> <1455005641-7079-5-git-send-email-antonynpavlov@gmail.com>
In-Reply-To: <1455005641-7079-5-git-send-email-antonynpavlov@gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201602091208.32281.marex@denx.de>
Return-Path: <marex@denx.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51893
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marex@denx.de
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

On Tuesday, February 09, 2016 at 09:13:50 AM, Antony Pavlov wrote:
> For OF boards we have to skip platform initialization code
> so we can prove that OF code do all necessary initialization.
> 
> Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
> Cc: Alban Bedel <albeu@free.fr>
> Cc: linux-mips@linux-mips.org

Why is this WIP ? It looks fine.

Reviewed-by: Marek Vasut <marex@denx.de>

Best regards,
Marek Vasut
