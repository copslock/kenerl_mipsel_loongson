Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Aug 2011 11:45:51 +0200 (CEST)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:56122 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491819Ab1HOJpq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Aug 2011 11:45:46 +0200
Received: by wyh11 with SMTP id 11so4063283wyh.36
        for <linux-mips@linux-mips.org>; Mon, 15 Aug 2011 02:45:41 -0700 (PDT)
Received: by 10.216.235.212 with SMTP id u62mr2308961weq.104.1313401540928;
        Mon, 15 Aug 2011 02:45:40 -0700 (PDT)
Received: from [192.168.2.2] ([91.79.88.120])
        by mx.google.com with ESMTPS id n6sm3516827wed.40.2011.08.15.02.45.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 15 Aug 2011 02:45:39 -0700 (PDT)
Message-ID: <4E48EAA0.5020901@mvista.com>
Date:   Mon, 15 Aug 2011 13:45:04 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:5.0) Gecko/20110624 Thunderbird/5.0
MIME-Version: 1.0
To:     Arnaud Lacombe <lacombar@gmail.com>
CC:     linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH 02/11] arch/mips: do not use EXTRA_CFLAGS
References: <1313384834-24433-1-git-send-email-lacombar@gmail.com> <1313384834-24433-3-git-send-email-lacombar@gmail.com>
In-Reply-To: <1313384834-24433-3-git-send-email-lacombar@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 30874
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 10710

Hello.

On 15-08-2011 9:07, Arnaud Lacombe wrote:

> Usage of these flags has been deprecated for nearly 4 years by:

>      commit f77bf01425b11947eeb3b5b54685212c302741b8
>      Author: Sam Ravnborg<sam@neptun.(none)>
>      Date:   Mon Oct 15 22:25:06 2007 +0200

>          kbuild: introduce ccflags-y, asflags-y and ldflags-y

> Moreover, these flags (at least EXTRA_CFLAGS) have been documented for command
> line use. By default, gmake(1) do not override command line setting, so this is
> likely to result in build failure or unexpected behavior.

> Replace their usage by Kbuild's `{as,cc,ld}flags-y'.

> Cc: Sam Ravnborg<sam@ravnborg.org>
> Cc: linux-mips@linux-mips.org

    You didn't sign off.

WBR, Sergei
