Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Aug 2012 12:05:17 +0200 (CEST)
Received: from mail-lb0-f177.google.com ([209.85.217.177]:50110 "EHLO
        mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903504Ab2HGKFO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Aug 2012 12:05:14 +0200
Received: by lbbgf7 with SMTP id gf7so1073002lbb.36
        for <linux-mips@linux-mips.org>; Tue, 07 Aug 2012 03:05:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=bKORR3Z64BfrDPcRMgFb8qBsN+g/VXQNPELvkEuYz8Q=;
        b=WkZdMTtek6f8EyFd//4I39H1Q0bZDWBepBCZ7TrtyFyCQiODMQRfKi4UgpyaUrQ1k7
         WvJTPnpyIc+NVv16PxF4/lyFnpvlMvoD7k10zZ9a0EHV1s3weBLlwtFKUnaMstUXdlQE
         6vr02xPNv3v+pDZopFDU7emEb3PCLDKUxmCT4ALkuEVVhFomVBV3giqTNoT/ekAyv1KE
         lW3OeedrhqNa6WL8ACJ74OyZZbAlpfdA4Ae2mcq1lpYoRbrkzkjSF8Slm5u+rcPm2noh
         4HxQlfmWG+47olVWcUTAZUqx4mSrRfgWbIxo+eJtdm48ocSJnpKioBaq68zKSE0v58CN
         Jaig==
Received: by 10.152.104.146 with SMTP id ge18mr13973586lab.7.1344333908506;
        Tue, 07 Aug 2012 03:05:08 -0700 (PDT)
Received: from [192.168.2.2] (ppp91-79-93-132.pppoe.mtu-net.ru. [91.79.93.132])
        by mx.google.com with ESMTPS id ly17sm8483444lab.2.2012.08.07.03.05.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 07 Aug 2012 03:05:07 -0700 (PDT)
Message-ID: <5020E81C.5020809@mvista.com>
Date:   Tue, 07 Aug 2012 14:04:12 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:14.0) Gecko/20120713 Thunderbird/14.0
MIME-Version: 1.0
To:     "Steven J. Hill" <sjhill@mips.com>
CC:     Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH] usb: host: mips: sead3: Update for EHCI register structure.
References: <1344292171-3111-1-git-send-email-sjhill@mips.com>
In-Reply-To: <1344292171-3111-1-git-send-email-sjhill@mips.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQkV9UNK0ruKKW3gFHolh3tP3MHuNG4Yf0mVdSjVK8K/Yso1yby4Sup/NFUASPsWyPq8ISp7
X-archive-position: 34068
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Hello.

On 07.08.2012 2:29, Steven J. Hill wrote:

> From: "Steven J. Hill" <sjhill@mips.com>

> One line fix after 'struct ehci_regs' definition was changed
> in commit a46af4ebf9ffec35eea0390e89935197b833dc61.

    Please also specify that commit's summary in parens.

> Signed-off-by: Steven J. Hill <sjhill@mips.com>

WBR, Sergei
