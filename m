Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Jan 2013 12:44:58 +0100 (CET)
Received: from mail-lb0-f169.google.com ([209.85.217.169]:43856 "EHLO
        mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6833458Ab3AYLoyJm0uQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 25 Jan 2013 12:44:54 +0100
Received: by mail-lb0-f169.google.com with SMTP id m4so553142lbo.14
        for <linux-mips@linux-mips.org>; Fri, 25 Jan 2013 03:44:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding:x-gm-message-state;
        bh=EjlATkXJKz8oubiYVYV8K6XT/XPxxzWFljBQSALsgpY=;
        b=h6kcz7tIiEeesaMKUJ8zdkUcbnMmcaucutxCnnapqhx0byrdsieDRpOdXkrdAkbhNY
         TfCtaZdKlsx01w6NAHhnErVi6tMJhyD7KU9QfzSG8iOI22SB8Nb8p/ae2T0sx40ms/dO
         n/ooxFAHpe6f7VblStyI4nZY5ZvK4jHPqRJkJF9ZdjlI0bF4DX23iaWp4Z++ntsujcu5
         DXz/geEAYLkPmWSoMlT7VtFgr4NWaA2qo1s4PvBLSpXW9pm0JHivUh7rwfwiRu3b6fEo
         B5O7/EMdpCL+sn4XYGJhxfowIvUKoLxzzjSgnq4J8wTGEPhC0yi8RlNVlQNqy5/gyAPk
         FYlw==
X-Received: by 10.152.125.237 with SMTP id mt13mr4879661lab.45.1359114288272;
        Fri, 25 Jan 2013 03:44:48 -0800 (PST)
Received: from [192.168.2.2] (ppp91-79-73-40.pppoe.mtu-net.ru. [91.79.73.40])
        by mx.google.com with ESMTPS id s9sm441493lbc.12.2013.01.25.03.44.46
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 25 Jan 2013 03:44:47 -0800 (PST)
Message-ID: <51027021.8010802@mvista.com>
Date:   Fri, 25 Jan 2013 15:44:33 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
MIME-Version: 1.0
To:     John Crispin <blogic@openwrt.org>
CC:     Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH 2/2] serial: of: allow au1x00 and rt288x to load from
 OF
References: <1359111008-9998-1-git-send-email-blogic@openwrt.org> <1359111008-9998-2-git-send-email-blogic@openwrt.org>
In-Reply-To: <1359111008-9998-2-git-send-email-blogic@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQnAhkppV1VQg9zQYv8wXmdBpOlAs4w/y8kA+Es6tH85WZq8SxFQqkz9moQtp2SgS3z+EkNV
X-archive-position: 35556
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

On 25-01-2013 14:50, John Crispin wrote:

> In order to make serial_8250 loadable via OF on Au1x00 and Ralink WiSoC we need
> to default the iotype to UPIO_AU.

    Alan Cox no longer works on Linux, Greg KH looks after the serial drivers 
snow.

> Signed-off-by: John Crispin <blogic@openwrt.org>

WBR, Sergei
