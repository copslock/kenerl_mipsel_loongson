Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 21 Feb 2016 14:19:09 +0100 (CET)
Received: from mail-lf0-f41.google.com ([209.85.215.41]:34676 "EHLO
        mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007423AbcBUNTHy9qFF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 21 Feb 2016 14:19:07 +0100
Received: by mail-lf0-f41.google.com with SMTP id j78so78985070lfb.1
        for <linux-mips@linux-mips.org>; Sun, 21 Feb 2016 05:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-type:content-transfer-encoding;
        bh=w2Gpw6iSZx6psqKDVROajll1Boms1K3B+DK6FFVhGfE=;
        b=zlurkZAVjjcDenwsLTBs/jNe5HeFjeRy64QJlry0vudRDd7go0LBod1nKEPU/eGjHH
         obwnlgK1C4uZoPiMnIAO2KqdaTGIhLtr+U0AzG2o6qPLcs3wMw4lenuUDVPh58CE4xfQ
         NgvLH30CjJ7zc0tMaRuRLiWuIW8xn3n3VaVjwHESUTUfHLDiEzp1BVBA35TpnxNnsR1o
         Y5uN1zkPZtKijQUMuPPdK4JrSTw7fyw5VqTW/liV9HQJaR8M0BmICDw4VDvoRqohuLkg
         QaLPLbhPewlNYIOYstGLb2DIKFTA2rihijif8aZtlyWwLk0XavJAYNekLI6iGFzUMtWo
         O/FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-type
         :content-transfer-encoding;
        bh=w2Gpw6iSZx6psqKDVROajll1Boms1K3B+DK6FFVhGfE=;
        b=TRk9K/XTfqBUXmgGnt+xL8zoo1lBaSK/asK/Iz6AvMm9p0fsT3KVOfvFo1iuT3bVgc
         MqYHtbpKPh9Uzsjd8gNc/khltrrteYI73tq9ud/4oxdNCYo5YOtzt9fuE+x0MS6RI/gI
         MDaOoJB7gYqCt31tFBM5H8qx+OYgsyiBo7xDdyK3Ep93hqeV8N7M2frDinqslXXQpBX8
         3i+OEbZ8oH7Mg3TIfGsC4h9AWggqF8RXBvYCNIEcZrPaMpgzjx/T49y6PsWpxyGCMYFJ
         UQ5/x6IpAe27crxA8jSnqcXT/CWioYIqgcYH27yQ1oid0fZZG8aK8ECkKRgLAJ0CP4uQ
         zapQ==
X-Gm-Message-State: AG10YOQ7xjjaZNpE96qnb9SMBfdOqvI/j/cGcak/KLVQuLMVL0yhAeQE8ERaEFbW5hov+Q==
X-Received: by 10.25.86.195 with SMTP id k186mr2009659lfb.155.1456060742248;
        Sun, 21 Feb 2016 05:19:02 -0800 (PST)
Received: from [192.168.4.126] ([83.149.8.15])
        by smtp.gmail.com with ESMTPSA id k3sm2766553lbp.9.2016.02.21.05.18.59
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 21 Feb 2016 05:19:01 -0800 (PST)
Subject: Re: [PATCH] MIPS: vdso: flush the vdso data page to update it on all
 processes
To:     Hauke Mehrtens <hauke@hauke-m.de>, linux-mips@linux-mips.org,
        ralf@linux-mips.org
References: <1456059443-13889-1-git-send-email-hauke@hauke-m.de>
Cc:     alex.smith@imgtec.com, "# v4 . 4+" <stable@vger.kernel.org>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <56C9B943.1080006@cogentembedded.com>
Date:   Sun, 21 Feb 2016 16:18:59 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <1456059443-13889-1-git-send-email-hauke@hauke-m.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52148
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

Hello.

On 2/21/2016 3:57 PM, Hauke Mehrtens wrote:

> Without flushing the vdso data page the vdso call is working on dated
> or unsynced data. This resulted in problems where the clock_gettime
> vdso call returned a time 6 seconds later after a 3 sounds sleep,
> while the syscall reported a time 3 sounds later like expected. This

    s/sounds/seconds/ perhaps?

> happened very often and I got these ping results for example:
>
> root@OpenWrt:/# ping 192.168.1.255
> PING 192.168.1.255 (192.168.1.255): 56 data bytes
> 64 bytes from 192.168.1.3: seq=0 ttl=64 time=0.688 ms
> 64 bytes from 192.168.1.3: seq=1 ttl=64 time=4294172.045 ms
> 64 bytes from 192.168.1.3: seq=2 ttl=64 time=4293968.105 ms
> 64 bytes from 192.168.1.3: seq=3 ttl=64 time=4294055.920 ms
> 64 bytes from 192.168.1.3: seq=4 ttl=64 time=4294671.913 ms
>
> The flush is now done like it is done on the arm architecture code.
>
> This was tested on a Lantiq/Intel VRX288 (MIPS BE 34Kc V5.6 CPU with
> two VPEs)
>
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> Cc: <stable@vger.kernel.org> # v4.4+
[...]

MBR, Sergei
