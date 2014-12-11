Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Dec 2014 20:20:21 +0100 (CET)
Received: from mail-qg0-f46.google.com ([209.85.192.46]:39502 "EHLO
        mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008517AbaLKTUTputT9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 11 Dec 2014 20:20:19 +0100
Received: by mail-qg0-f46.google.com with SMTP id q107so2237087qgd.33
        for <multiple recipients>; Thu, 11 Dec 2014 11:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=GNI6MbstSu1LpUHKTpOtLMtX2JivsKMbg1IE1+FfmCc=;
        b=xg8/kV100fx6MaWFmLqkbDUGqMdV4C3QG2xpg0KpVQpEO/GVX7alAlgp7wZZEd8bTy
         OQXwNmOLJq4+yBKtdgt5F1ntBshPsrXZ1c15j3lKfWl/1wAZuFcpAx76WxvlP7HHzA8C
         zaAGb1bOt24BQr4dsdHe8FI77uMFmBXiHl0OGUSF2fPBXqhbX/oNcfdJV+ewM8W3AJmN
         D/EnZ8YAVCkQPdoGaCKEtgsyggKv+hyjg3/kqUl6VbS+UW3WkxCVibIh0eOBfilQVC0V
         tXUzXKEHI8pdArkEQawSBz3BUfeaj3OMsrYqBQWwUXGPkSXAQGdPPmbbUzWgSPCiHpMX
         NBeQ==
X-Received: by 10.140.34.67 with SMTP id k61mr21762994qgk.95.1418325613675;
 Thu, 11 Dec 2014 11:20:13 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.82.48 with HTTP; Thu, 11 Dec 2014 11:19:53 -0800 (PST)
In-Reply-To: <20141211132746.GF31723@linux-mips.org>
References: <20141211132746.GF31723@linux-mips.org>
From:   Kevin Cernekee <cernekee@gmail.com>
Date:   Thu, 11 Dec 2014 11:19:53 -0800
Message-ID: <CAJiQ=7C=WTzOKJ4CPGH3zB4hTr=RkF1ywn9bHs2DXpPRmwpCKg@mail.gmail.com>
Subject: Re: MIPS in 3.19
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44620
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

On Thu, Dec 11, 2014 at 5:27 AM, Ralf Baechle <ralf@linux-mips.org> wrote:
>
> Kevin Cernekee (15):
>       Documentation: DT: Add entries for BCM3384 and its peripherals

>       MIPS: bcm3384: Initial commit of bcm3384 platform support
>       MAINTAINERS: Add entry for BCM33xx cable chips

Hi Ralf,

Could we drop/revert these three patches for now, and then use the
"BMIPS Generic target V4" patch series to support BCM3384?  The BMIPS
Generic series incorporates a great deal of helpful feedback from Arnd
and others, and it also runs on 5+ other chips.

It is OK if it isn't merged until 3.20+.  No rush.

Thanks!
