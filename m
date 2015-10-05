Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Oct 2015 15:18:16 +0200 (CEST)
Received: from smtp2-g21.free.fr ([212.27.42.2]:8462 "EHLO smtp2-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27009506AbbJENSOR6o78 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 5 Oct 2015 15:18:14 +0200
Received: from avionic-0020 (unknown [91.60.2.86])
        (Authenticated sender: albeu@free.fr)
        by smtp2-g21.free.fr (Postfix) with ESMTPSA id 5CF9C4B0049;
        Mon,  5 Oct 2015 15:18:07 +0200 (CEST)
Date:   Mon, 5 Oct 2015 15:18:03 +0200
From:   Alban <albeu@free.fr>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Alban <albeu@free.fr>
Subject: Re: [PATCH] MIPS: jz4740: Add missing gpio.h include
Message-ID: <20151005151803.5b5a5b40@avionic-0020>
In-Reply-To: <1444044571-11304-1-git-send-email-thierry.reding@gmail.com>
References: <1444044571-11304-1-git-send-email-thierry.reding@gmail.com>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49440
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: albeu@free.fr
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

Am Mon,  5 Oct 2015 13:29:31 +0200
schrieb Thierry Reding <thierry.reding@gmail.com>:

> Commit 832f5dacfa0b ("MIPS: Remove all the uses of custom gpio.h") was
> incomplete in that it didn't replace any of the includes for the JZ4740
> platform and thus broke the qi_lb60_defconfig build.

The fix for this break has just been merged upstream yesterday.

Alban
