Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Dec 2014 18:08:53 +0100 (CET)
Received: from mail-qg0-f48.google.com ([209.85.192.48]:44514 "EHLO
        mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009683AbaLWRIvc9AyD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 23 Dec 2014 18:08:51 +0100
Received: by mail-qg0-f48.google.com with SMTP id f51so4792399qge.21;
        Tue, 23 Dec 2014 09:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Q4Oo5X9tUYqp0OeN/YFttdWek9HXw8DK81xH4UB3fCQ=;
        b=zPW0GGpL9/byF4Es8+VGnsN+988pY8L3y+emEuhr7lQU+Gi+is9Y7gdH5tcYAOzip7
         49fGYBTuTu76NWbJgCwt4+9E44ZazITD58/8eXWXl1EJPJaeojzxVSa2Kb3i2zAywfBq
         cBuW69V+uBVY+npvXKysAqfwMKIaUFkI8ZN3WftzB9MENtOOzkMRzdO7W66k0qkGaIbv
         j2UC869nhixHrZKbQMBCUxqp+hFwC19l7luMi3uUi3DdJv5yAsk7p0p5B1JhHoHcairs
         lnogv3k7xIpC9L3nB3gOvNBEvDhfXInN8mTY39vglfT0sya+2xpYN3cJ4281jcF9BOvo
         80LQ==
X-Received: by 10.140.38.114 with SMTP id s105mr10025763qgs.106.1419354525774;
 Tue, 23 Dec 2014 09:08:45 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.82.48 with HTTP; Tue, 23 Dec 2014 09:08:25 -0800 (PST)
In-Reply-To: <1419353032-10340-1-git-send-email-abrestic@chromium.org>
References: <1419353032-10340-1-git-send-email-abrestic@chromium.org>
From:   Kevin Cernekee <cernekee@gmail.com>
Date:   Tue, 23 Dec 2014 09:08:25 -0800
Message-ID: <CAJiQ=7AB46Dz5hPKRjZXkmcanf4KTfcry87Ai503xX6yQOE_VQ@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] MIPS: Move device-trees into vendor sub-directories
To:     Andrew Bresticker <abrestic@chromium.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44903
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
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

On Tue, Dec 23, 2014 at 8:43 AM, Andrew Bresticker
<abrestic@chromium.org> wrote:
> Move the MIPS device-trees into the appropriate vendor sub-directories.
>
> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
> ---
> Changes from v1:
>  - renamed bcm -> brcm

Thanks, this works for me.  For both patches in the series:

Tested-by: Kevin Cernekee <cernekee@gmail.com>
