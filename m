Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Aug 2013 20:37:39 +0200 (CEST)
Received: from mail-la0-f49.google.com ([209.85.215.49]:59651 "EHLO
        mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6827306Ab3HWShhWlsia (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Aug 2013 20:37:37 +0200
Received: by mail-la0-f49.google.com with SMTP id ev20so772310lab.22
        for <linux-mips@linux-mips.org>; Fri, 23 Aug 2013 11:37:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-gm-message-state:message-id:date:from:organization:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=ru+aT9Rr5SfTBaWvKu3DSrVNYc+ZEK++fwMrsSgvVoI=;
        b=LVauy3c6k0fcNmLjZFpq7v4FXGjL9AoRK/rabJlI6cx/3guL69q2N05IW2y9by5rTa
         8OoGdoAuJgOPG/vPZJOQ9gQHYl38doTQhXE7RtdIusExtFMV4P5d64tByyiVcQs4Pp4t
         iOMn/wie/jEmCSWXutH6+BgUKuzLH6vX6Iz1ujpMg2d6xl3Sj2Q/Zuw1jc0wPelBQVPT
         98Zf7NvGX6/6zv7FhRuOTV0MiHJCVR8ik0jtxdNNsTE1HbPpwnlD9flyzGFgzsQmTiys
         +uueOtlPlUx7tzFFX4y4GIyRsNZoXfF7hN4oG9R90ruiiYxopjWILwV6KaPWetkjvlie
         ziWA==
X-Gm-Message-State: ALoCoQmDFMxKCbdQph/m8apCsYerqVs7+d1M7xAs5ikiWrBPYVLwiaVJN9iq2umL2cmHGhs/7yp0
X-Received: by 10.152.2.4 with SMTP id 4mr670430laq.0.1377283050449;
        Fri, 23 Aug 2013 11:37:30 -0700 (PDT)
Received: from wasted.dev.rtsoft.ru (ppp91-76-147-116.pppoe.mtu-net.ru. [91.76.147.116])
        by mx.google.com with ESMTPSA id b3sm406398laf.7.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 23 Aug 2013 11:37:29 -0700 (PDT)
Message-ID: <5217ABF1.3000805@cogentembedded.com>
Date:   Fri, 23 Aug 2013 22:37:37 +0400
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
MIME-Version: 1.0
To:     John Crispin <blogic@openwrt.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        devicetree-discuss@lists.ozlabs.org
Subject: Re: [PATCH 4/6] DT: MIPS: ralink: add RT2880 dts files
References: <1365843026-11015-1-git-send-email-blogic@openwrt.org> <1365843026-11015-4-git-send-email-blogic@openwrt.org> <5217AB25.3050106@cogentembedded.com>
In-Reply-To: <5217AB25.3050106@cogentembedded.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37668
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sergei.shtylyov@cogentembedded.com
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

On 08/23/2013 10:34 PM, Sergei Shtylyov wrote:
> On 04/13/2013 12:50 PM, John Crispin wrote:

>> Add a dtsi file for RT2880 SoC and a sample dts file.

>     You forgot to mention Kconfig entry...

    Hm, didn't notice I was replying to the mail from April until it was too 
late. :-)

WBR, Sergei
