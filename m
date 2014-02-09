Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 09 Feb 2014 22:44:36 +0100 (CET)
Received: from cpsmtpb-ews02.kpnxchange.com ([213.75.39.5]:60469 "EHLO
        cpsmtpb-ews02.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6826068AbaBIVoeLrMFg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 9 Feb 2014 22:44:34 +0100
Received: from cpsps-ews19.kpnxchange.com ([10.94.84.185]) by cpsmtpb-ews02.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
         Sun, 9 Feb 2014 22:44:28 +0100
Received: from CPSMTPM-TLF104.kpnxchange.com ([195.121.3.7]) by cpsps-ews19.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
         Sun, 9 Feb 2014 22:44:28 +0100
Received: from [192.168.1.104] ([82.169.24.127]) by CPSMTPM-TLF104.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
         Sun, 9 Feb 2014 22:44:28 +0100
Message-ID: <1391982267.25855.63.camel@x220>
Subject: Re: [PATCH 08/28] Remove SYS_HAS_DMA_OPS
From:   Paul Bolle <pebolle@tiscali.nl>
To:     Richard Weinberger <richard@nod.at>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        "open list:MIPS" <linux-mips@linux-mips.org>,
        open list <linux-kernel@vger.kernel.org>
Date:   Sun, 09 Feb 2014 22:44:27 +0100
In-Reply-To: <1391971686-9517-9-git-send-email-richard@nod.at>
References: <1391971686-9517-1-git-send-email-richard@nod.at>
         <1391971686-9517-9-git-send-email-richard@nod.at>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.3 (3.10.3-1.fc20) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Feb 2014 21:44:28.0288 (UTC) FILETIME=[1B97F800:01CF25E0]
X-RcptDomain: linux-mips.org
Return-Path: <pebolle@tiscali.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39259
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pebolle@tiscali.nl
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

On Sun, 2014-02-09 at 19:47 +0100, Richard Weinberger wrote:
> The symbol is an orphan, get rid of it.

I don't think a symbol with that name was ever part of the tree (but I
didn't look past v2.6.12). It seems just a typo, but it's unclear what
was intended here. It's a nop now, so safe to remove.

> Signed-off-by: Richard Weinberger <richard@nod.at>

So, perhaps Richard should update the commit explanation. But I'm fine
with the patch itself:
    Acked-by: Paul Bolle <pebolle@tiscali.nl>
 

Paul Bolle
