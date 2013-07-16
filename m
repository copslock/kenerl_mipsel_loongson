Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Jul 2013 14:32:13 +0200 (CEST)
Received: from mail-pd0-f174.google.com ([209.85.192.174]:59043 "EHLO
        mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6827510Ab3GPMcHJekPr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 16 Jul 2013 14:32:07 +0200
Received: by mail-pd0-f174.google.com with SMTP id 10so628901pdc.19
        for <multiple recipients>; Tue, 16 Jul 2013 05:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=aeYRy3yLEUzhb+keBiqykrfJTbX/4DppQD20lsZtu48=;
        b=ZSGd/SHvuqyPAHnPX+GRnP6b1HQhdoO2m6ZDcePE5p+RD9TuJeRhd1pXv1UYYP3Een
         1tozM4qEkI3jNXGiggxveyhMQFB8Ui0XaBSrSLZwr5uuceoShKg+jSXYy1EAV+eImA/5
         /7rVVmOnQiIbAlQyD2QHPgrNq649sUTKdadp3J2AZx0RwFkTp4uLkMKfy7Ni5x5jVPVo
         0hkqlfD6XLxeRp7FHOmNB4gV3+3431egxTqP7/HUcu1Rni6t5xQXm/On3KcH1oF/XbJW
         HSwczIiIoJAXYGsc4YqvxxX2qiXEbC77WBzlkYJMGX6cV+1jIPlatL0pj8dVP2h9qEoq
         rROg==
X-Received: by 10.68.131.68 with SMTP id ok4mr1295767pbb.146.1373977920300;
 Tue, 16 Jul 2013 05:32:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.68.10.101 with HTTP; Tue, 16 Jul 2013 05:31:20 -0700 (PDT)
In-Reply-To: <1372537073-27370-6-git-send-email-jogo@openwrt.org>
References: <1372537073-27370-1-git-send-email-jogo@openwrt.org> <1372537073-27370-6-git-send-email-jogo@openwrt.org>
From:   Florian Fainelli <florian@openwrt.org>
Date:   Tue, 16 Jul 2013 13:31:20 +0100
X-Google-Sender-Auth: VP9buYGN-DeARjSYGn6WZpyLSk4
Message-ID: <CAGVrzcYsJrohQBoDG+TP6aXJcQ2b4Gb8JrLFnBM7uYTHycWF4Q@mail.gmail.com>
Subject: Re: [PATCH 05/10] MIPS: bmips: merge CPU options into one option
To:     Jonas Gorski <jogo@openwrt.org>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Kevin Cernekee <cernekee@gmail.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37297
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
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

Hello Jonas,

2013/6/29 Jonas Gorski <jogo@openwrt.org>:
[snip]

> +config CPU_BMIPS
> +       bool "Broadcom BMIPS"
> +       depends on SYS_HAS_CPU_BMIPS
> +       select CPU_MIPS32
> +       select CPU_BMIPS3300 if SYS_HAS_CPU_BMIPS3300
> +       select CPU_BMIPS4350 if SYS_HAS_CPU_BMIPS4350
> +       select CPU_BMIPS4350 if SYS_HAS_CPU_BMIPS4380

As you already made me notice privately, this should be:

select CPU_BMIPS4380 if SYS_HAS_CPU_BMIPS4380
--
Florian
